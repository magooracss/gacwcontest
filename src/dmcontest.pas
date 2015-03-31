unit dmcontest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZConnection, ZSqlProcessor
  ,IniFiles, db
  ;

const
  PROP_NAME = 'contest.cgf';
  DB_NAME = 'contest.db3';

  PR_SECC = 'CONTEST';
  PR_NAME = 'NAME';
  PR_YEAR = 'YEAR';
  PR_DSTART = 'DATESTART';
  PR_TSTART = 'TIMESTART';
  PR_DFINISH = 'DATEFINISH';
  PR_TFINISH = 'TIMEFINISH';
  PR_PATH = 'PR_PATH';
  PR_LOGPATH = 'LOG_PATH';

  MSG_ERROR = 'ERROR';


type

  { TDM_Contest }

  TDM_Contest = class(TDataModule)
    cnxContest: TZConnection;
    qsosconfirmed: TLongintField;
    qsosexchr: TLongintField;
    qsosexchs: TLongintField;
    qsosfreq: TStringField;
    qsosidQSO: TLongintField;
    qsospoints: TLongintField;
    qsosqcall: TStringField;
    qsosqdate: TStringField;
    qsosqmode: TStringField;
    qsosqTime: TStringField;
    qsosrefItuCallSign: TLongintField;
    qsosrefStation: TLongintField;
    qsosrstr: TLongintField;
    qsosrsts: TLongintField;
    qsost: TLongintField;
    stations: TRxMemoryData;
    qsos: TRxMemoryData;
    sqlNewContest: TZSQLProcessor;
    stationsacity: TStringField;
    stationsaCountry: TStringField;
    stationsaddress: TStringField;
    stationsaPostalCode: TStringField;
    stationsaStateProv: TStringField;
    stationscallsign: TStringField;
    stationscAssisted: TStringField;
    stationscBand: TStringField;
    stationsclaimedScore: TLongintField;
    stationsclub: TStringField;
    stationscMode: TStringField;
    stationscontest: TStringField;
    stationscOper: TStringField;
    stationscOverlay: TStringField;
    stationscPower: TStringField;
    stationscreatedBy: TStringField;
    stationscStation: TStringField;
    stationscTime: TStringField;
    stationsemail: TStringField;
    stationsidStation: TLongintField;
    stationslocation: TStringField;
    stationsname: TStringField;
    stationsofftime: TStringField;
    stationsoperators: TStringField;
    stationssoapbox: TStringField;
  private
     conName
    ,conYear
    , cfgPath
    , logPath: string;
     dateStart
     ,dateFinish: TDate;
     timeStart
     ,timeFinish: TTime;
  public
   property contestName: string read conName write conName;
   property contestYear: string read conYear write conYear;
   property contestPath: string read cfgPath write cfgPath;
   property contestLogs: string read logPath write logPath;
   property contestStartD: TDate read dateStart write dateStart;
   property contestStartT: TTime read timeStart write timeStart;
   property contestFinishD: TDate read dateFinish write dateFinish;
   property contestFinishT: TDate read timeFinish write timeFinish;

   function loadContest (path: string): boolean;
   procedure SaveContest;
   procedure SaveProperties (namecontest, yearContest: string; dateCStart: TDate;
                            timeCStart: TTime; dateCFinish: TDate; timeCFinish: TTime;
                            contestFolder, logsFolder: string);

   procedure analizeLogDir;
   procedure analizeFile (aLogFile: string);
   procedure analizeLine (aLine: string);

  end;

var
  DM_Contest: TDM_Contest;

implementation
{$R *.lfm}
uses
  forms;

{ TDM_Contest }

function TDM_Contest.loadContest(path: string): boolean;
var
  anIni: TIniFile;
begin
 if (FileExists(path + DirectorySeparator + PROP_NAME)
    //and FileExists(path + DirectorySeparator + DB_NAME)
    )then
 begin

 (**************************   PROPERTIES   ***********************************)
  Result:= false;
  try
    anIni:= TiniFile.Create(path + DirectorySeparator + PROP_NAME);
    conName:= anIni.ReadString(PR_SECC, PR_NAME, MSG_ERROR);
    conYear:= anIni.ReadString(PR_SECC, PR_YEAR, MSG_ERROR);
    cfgPath:= anIni.ReadString(PR_SECC, PR_PATH, MSG_ERROR);
    logPath:= anIni.ReadString(PR_SECC, PR_LOGPATH, MSG_ERROR);
    dateStart:= anIni.ReadDate(PR_SECC, PR_DSTART, Now);
    dateFinish:= anIni.ReadDate(PR_SECC, PR_DFINISH, Now);
    timeStart:= anIni.ReadTime(PR_SECC, PR_TSTART, Now);
    timeFinish:= anIni.ReadTime(PR_SECC, PR_TFINISH, Now);
    Result:= true;
  finally
    anIni.Free;
  end;


  (**************************   DATABASE   ************************************)
  with cnxContest do
  begin
    if Connected then Disconnect;
    LibraryLocation:= ExtractFilePath(Application.ExeName) + 'sqlite3.dll';
    Database:= cfgPath+ DirectorySeparator + DB_NAME;
    Connect;
  end;
 end
 else
  Result:= False;

end;

procedure TDM_Contest.SaveContest;
var
   anIni: TIniFile;
begin
    anIni:= TiniFile.Create(cfgPath + DirectorySeparator + PROP_NAME);
    try
      anIni.WriteString(PR_SECC, PR_NAME, conName);
      anIni.WriteString(PR_SECC, PR_YEAR, conYear);
      anIni.WriteDate(PR_SECC, PR_DSTART, dateStart);
      anIni.WriteTime(PR_SECC, PR_TSTART, timeStart);
      anIni.WriteDate(PR_SECC, PR_DFINISH, dateFinish);
      anIni.WriteTime(PR_SECC, PR_TFINISH, timeFinish);
      anIni.WriteString(PR_SECC, PR_PATH, cfgPath);
      anIni.WriteString(PR_SECC, PR_LOGPATH, logPath);
    finally
      anIni.Free;
    end;

    (**************************   DATABASE   ************************************)

   if NOT FileExists(cfgPath + DirectorySeparator + DB_NAME) then
   begin
    with cnxContest do
    begin
      if Connected then Disconnect;
      LibraryLocation:= ExtractFilePath(Application.ExeName) + 'sqlite3.dll';
      Database:= cfgPath+ DirectorySeparator + DB_NAME;
      Connect;
      sqlNewContest.Execute;
    end;
   end;
end;

procedure TDM_Contest.SaveProperties(namecontest, yearContest: string;
  dateCStart: TDate; timeCStart: TTime; dateCFinish: TDate; timeCFinish: TTime;
  contestFolder, logsFolder: string);
begin
 conName:= namecontest;
 conYear:= yearContest;
 cfgPath:= contestFolder;
 logPath:= logsFolder;
 dateStart:= dateCStart;
 dateFinish:= dateCFinish;
 timeStart:= timeCStart;
 timeFinish:= timeCFinish;
 SaveContest;
end;


(*******************************************************************************
*** Insert LogFile in database
*******************************************************************************)

procedure TDM_Contest.analizeLine(aLine: string);
begin

end;


procedure TDM_Contest.analizeFile(aLogFile: string);
var
  fileLog: TextFile;
  aLine: string;
begin
  AssignFile(fileLog, aLogFile);
  try
   Reset(fileLog);
   Readln(fileLog, aLine);
   analizeLine(aLine);
  finally
    CloseFile(fileLog);
  end;
end;

procedure TDM_Contest.analizeLogDir;
var
  fileSearch: TSearchRec;
begin
  If FindFirst (logPath+'\*.*',faArchive, fileSearch)=0 then
  begin
    Repeat
       stations.Insert;
       analizeFile(logPath+'\'+fileSearch.Name);
    Until FindNext(fileSearch)<>0;
  end;
  FindClose(fileSearch);
end;

end.

