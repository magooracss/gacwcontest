unit dmcontest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil
  ,IniFiles
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
  end;

var
  DM_Contest: TDM_Contest;

implementation

{$R *.lfm}

{ TDM_Contest }

function TDM_Contest.loadContest(path: string): boolean;
var
  anIni: TIniFile;
begin
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

end.

