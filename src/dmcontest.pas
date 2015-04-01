unit dmcontest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZConnection, ZSqlProcessor, ZDataset
  ,IniFiles, db
  , dmgeneral
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

  CBR_SEPARATOR = ':';

  MSG_ERROR = 'ERROR';

  QSO_NOT_CONFIRMED = 0;

  //Labels from Cabrillo
  LB_qso = 'QSO';


type

  { TDM_Contest }

  TDM_Contest = class(TDataModule)
    cnxContest: TZConnection;
    INSQSOs: TZQuery;
    qsoscallr: TStringField;
    qsoscalls: TStringField;
    qsosconfirmed: TLongintField;
    qsosexchr: TLongintField;
    qsosexchs: TLongintField;
    qsosfreq: TStringField;
    qsosidQSO: TLongintField;
    qsospoints: TLongintField;
    qsosqdate: TStringField;
    qsosqmode: TStringField;
    qsosqTime: TStringField;
    qsosrefItuCallSign: TLongintField;
    qsosrefStation: TLongintField;
    qsosrstr: TLongintField;
    qsosrsts: TLongintField;
    qsost: TLongintField;
    qStationByCallacity: TStringField;
    qStationByCallaCountry: TStringField;
    qStationByCalladdress: TStringField;
    qStationByCallaPostalCode: TStringField;
    qStationByCallaStateProv: TStringField;
    qStationByCallcallsign: TStringField;
    qStationByCallcAssisted: TStringField;
    qStationByCallcBand: TStringField;
    qStationByCallclaimedScore: TLargeintField;
    qStationByCallclub: TStringField;
    qStationByCallcMode: TStringField;
    qStationByCallcontest: TStringField;
    qStationByCallcOper: TStringField;
    qStationByCallcOverlay: TStringField;
    qStationByCallcPower: TStringField;
    qStationByCallcreatedBy: TStringField;
    qStationByCallcStation: TStringField;
    qStationByCallcTime: TStringField;
    qStationByCallcTransmitter: TStringField;
    qStationByCallemail: TStringField;
    qStationByCallidStation: TLargeintField;
    qStationByCalllocation: TStringField;
    qStationByCallname: TStringField;
    qStationByCallofftime: TStringField;
    qStationByCallOperators: TStringField;
    qStationByCallsoapbox: TMemoField;
    SELQSOs: TZQuery;
    SELQSOscallr: TStringField;
    SELQSOscalls: TStringField;
    SELQSOsconfirmed: TLargeintField;
    SELQSOsexchr: TLargeintField;
    SELQSOsexchs: TLargeintField;
    SELQSOsfreq: TStringField;
    SELQSOsidQSO: TLargeintField;
    SELQSOspoints: TLargeintField;
    SELQSOsqdate: TStringField;
    SELQSOsqmode: TStringField;
    SELQSOsqtime: TStringField;
    SELQSOsrefItuCallSign: TStringField;
    SELQSOsrefStation: TLargeintField;
    SELQSOsrstr: TLargeintField;
    SELQSOsrsts: TLargeintField;
    SELQSOst: TLargeintField;
    SELStationsacity: TStringField;
    SELStationsaCountry: TStringField;
    SELStationsaddress: TStringField;
    SELStationsaPostalCode: TStringField;
    SELStationsaStateProv: TStringField;
    SELStationscallsign: TStringField;
    SELStationscAssisted: TStringField;
    SELStationscBand: TStringField;
    SELStationsclaimedScore: TLargeintField;
    SELStationsclub: TStringField;
    SELStationscMode: TStringField;
    SELStationscontest: TStringField;
    SELStationscOper: TStringField;
    SELStationscOverlay: TStringField;
    SELStationscPower: TStringField;
    SELStationscreatedBy: TStringField;
    SELStationscStation: TStringField;
    SELStationscTime: TStringField;
    SELStationscTransmitter: TStringField;
    SELStationsemail: TStringField;
    SELStationsidStation: TLargeintField;
    SELStationslocation: TStringField;
    SELStationsname: TStringField;
    SELStationsofftime: TStringField;
    SELStationsOperators: TStringField;
    SELStationssoapbox: TMemoField;
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
    stationscTransmitter: TStringField;
    stationsemail: TStringField;
    stationsidStation: TLongintField;
    stationslocation: TStringField;
    stationsname: TStringField;
    stationsofftime: TStringField;
    stationsoperators: TStringField;
    stationssoapbox: TStringField;
    qStationByCall: TZQuery;
    SELStations: TZQuery;
    INSstations: TZQuery;
    UPDStations: TZQuery;
    UPDQSOs: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qsosAfterInsert(DataSet: TDataSet);
  private
     conName
    ,conYear
    , cfgPath
    , logPath
    , fileProcess: string;
     dateStart
     ,dateFinish: TDate;
     timeStart
     ,timeFinish: TTime;


     procedure processQSOData(rowData: string);
     procedure processStationData (rowLabel, rowData: string);
     procedure analizeLine (aLine: string);
     procedure GenerateDictionary;

  public
   LabelsField: TStringList;
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
   procedure saveDB;
   function LogLoaded (callsign: string): boolean;

  end;

var
  DM_Contest: TDM_Contest;

implementation
{$R *.lfm}
uses
  forms;

{ TDM_Contest }

procedure TDM_Contest.qsosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    qsosrefStation.asInteger:= 0;
    qsospoints.asInteger:= 0;
    qsosrefItuCallSign.AsInteger:= 0;
    qsost.AsInteger:= 0;
  end;
end;

procedure TDM_Contest.DataModuleCreate(Sender: TObject);
begin
  GenerateDictionary;
end;


function TDM_Contest.loadContest(path: string): boolean;
var
  anIni: TIniFile;
begin
 if (FileExists(path + DirectorySeparator + PROP_NAME)
    and FileExists(path + DirectorySeparator + DB_NAME)
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
    DM_General.ReiniciarTabla(stations);
    DM_General.ReiniciarTabla(qsos);
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

procedure TDM_Contest.processQSOData(rowData: string);
var
  splitRow: TStringList;
begin
  splitRow:= TStringList.Create;
  try
    splitRow.Delimiter:= ' ';
    splitRow.StrictDelimiter:= false;
    splitRow.DelimitedText:= rowData;
    if splitRow.Count >= 10 then
    begin
      with qsos do
      begin
        Insert;
        qsosfreq.asString:= splitRow [0];
        qsosqmode.AsString:= splitRow [1];
        qsosqdate.AsString:= splitRow [2];
        qsosqTime.asString:= splitRow [3];
        qsoscalls.asString:= splitRow [4];
        qsosrsts.AsInteger:= strToIntDef (splitRow [5], 599);
        qsosexchs.AsInteger:= strToIntDef (splitRow [6], -1);
        qsoscallr.AsString:= splitRow [7];
        qsosrstr.AsInteger:= strToIntDef (splitRow [8], 599);
        qsosexchr.AsInteger:= strToIntDef (splitRow [9], -1);
        qsosconfirmed.asInteger:= QSO_NOT_CONFIRMED;
        qsospoints.AsInteger:= 0;
        Post;
      end;
    end
    else
      DM_General.EventLog.Error('Error fields counter QSO: ' + rowData + ' FILE: ' + fileProcess );
  finally
    splitRow.Free;
  end;

end;

procedure TDM_Contest.processStationData(rowLabel, rowData: string);
var
   fieldName:string;
begin
  fieldName:= LabelsField.Values[UpperCase(Trim(rowLabel))];
  if fieldName <> EmptyStr then
  begin
    with stations do
    begin
      Edit;
      if (FieldByName(fieldName).DataType = ftInteger) then
      begin
        FieldByName(fieldName).asInteger:= StrToIntDef(rowData, -1);
        if StrToIntDef(rowData, -1) = -1 then
          DM_General.EventLog.Error('Error casting: ' + rowLabel + ' Data: '+ rowData + ' FILE: ' + fileProcess );
      end
      else
        FieldByName(fieldName).AsString:= FieldByName(fieldName).AsString + Trim(rowData);
      Post;
    end;
  end
  else
   DM_General.EventLog.Warning('Label unknow: ' + rowLabel + ' FILE: ' + fileProcess);
end;



procedure TDM_Contest.analizeLine(aLine: string);
var
  posIdx: integer;
  rowLabel, rowData: string;
begin
  posIdx:= pos(CBR_SEPARATOR, aLine);
  rowLabel:= Copy(aLine,1,posIdx - 1);
  rowData:= Copy (aLine, posIdx + 1 , Length(aLine)-posIdx);
  if UpperCase(Trim(rowLabel)) = LB_qso then
    processQSOData(rowData)
  else
    processStationData (rowLabel, rowData);
end;

procedure TDM_Contest.GenerateDictionary;
begin
  LabelsField:= TStringList.Create;
  LabelsField.CommaText:= 'CALLSIGN=callsign, CATEGORY-ASSISTED=cAssisted'
                         + ', CATEGORY-BAND=cBand, CATEGORY-MODE=cMode'
                         + ', CATEGORY-OPERATOR=cOper, CATEGORY=cOper'
                         + ', CATEGORY-POWER=cPower ,CLAIMED-SCORE=claimedScore'
                         + ', CLUB=club,CONTEST=contest, CREATED-BY=createdBy'
                         + ', EMAIL=email, NAME=name, ADDRESS=address'
                         + ', ADDRESS-CITY=acity, ADDRESS-POSTALCODE=aPostalCode'
                         + ', ADDRESS-COUNTRY=aCountry, OPERATORS=operators'
                         + ', SOAPBOX=soapbox'
                      ;
end;

procedure TDM_Contest.saveDB;
var
  id: integer;
begin
   DM_General.GrabarDatos(SELStations, INSstations, UPDStations, stations, 'idStation');

   //lastID from last station saved
   with qStationByCall do
   begin
     if active then close;
     ParamByName('callsign').asString:= stationscallsign.asString;
     open;
     if RecordCount > 0 then
       id:= qStationByCallidStation.asInteger
     else
     begin
       DM_General.EventLog.ERROR ('I can´t retry id saved from ' + stationscallsign.asString);
       id:= 0;
     end;
   end;

   //Link Qsos and station using ID
   with qsos do
   begin
     First;
     while not eof do
     begin
       If qsosrefStation.asInteger = 0 then
       begin
        Edit;
        qsosrefStation.asInteger:= id;
        Post;
       end;
       next;
     end;
   end;

   DM_General.GrabarDatos(SELQSOs, INSQSOs, UPDQSOs, qsos, 'idQSO');

end;

function TDM_Contest.LogLoaded(callsign: string): boolean;
begin
  with qStationByCall do
  begin
    if active then close;
    ParamByName('callsign').asString:= TRIM(callsign);
    open;
    Result:= (RecordCount > 0);
  end;
end;


procedure TDM_Contest.analizeFile(aLogFile: string);
var
  fileLog: TextFile;
  aLine: string;
begin
  AssignFile(fileLog, aLogFile);
  fileProcess:= aLogFile;
  try
   Reset(fileLog);
   While Not EOF(fileLog) do
   begin
     Readln(fileLog, aLine);
     analizeLine(aLine);
   end;
   if LogLoaded (stationscallsign.AsString) then
    DM_General.EventLog.Error('Station: ' + stationscallsign.AsString
                              + ' file ' + aLogFile
                              + 'already exists in DB')
   else
     SaveDB;
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

