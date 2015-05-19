unit dmcontest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZConnection, ZSqlProcessor, ZDataset
  ,IniFiles, db
  , dmgeneral
 ;

const
  PROP_NAME = 'contest.cfg';
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
  QSO_CONFIRMED = 1;
  QSO_MAYBE = 2; //For logs have not received to match
  QSO_INVALID = 3; //The Qso matched, but it wasn't pass the validations (Date, time, freq, etc)

  //Labels from Cabrillo
  LB_qso = 'QSO';


type

  { TDM_Contest }

  TDM_Contest = class(TDataModule)
    cnxContest: TZConnection;
    INSQSOs: TZQuery;
    qAllStationsacity: TStringField;
    qAllStationsaCountry: TStringField;
    qAllStationsaddress: TStringField;
    qAllStationsaPostalCode: TStringField;
    qAllStationsaStateProv: TStringField;
    qAllStationscallsign: TStringField;
    qAllStationscAssisted: TStringField;
    qAllStationscBand: TStringField;
    qAllStationsclaimedScore: TLargeintField;
    qAllStationsclub: TStringField;
    qAllStationscMode: TStringField;
    qAllStationscontest: TStringField;
    qAllStationscOper: TStringField;
    qAllStationscOverlay: TStringField;
    qAllStationscPower: TStringField;
    qAllStationscreatedBy: TStringField;
    qAllStationscStation: TStringField;
    qAllStationscTime: TStringField;
    qAllStationscTransmitter: TStringField;
    qAllStationsemail: TStringField;
    qAllStationsidStation: TLargeintField;
    qAllStationslocation: TStringField;
    qAllStationsname: TStringField;
    qAllStationsofftime: TStringField;
    qAllStationsOperators: TStringField;
    qAllStationssoapbox: TStringField;
    qPairedQSO: TZQuery;
    qPairedQSOcallr: TStringField;
    qPairedQSOcalls: TStringField;
    qPairedQSOconfirmed: TLargeintField;
    qPairedQSOexchr: TLargeintField;
    qPairedQSOexchs: TLargeintField;
    qPairedQSOfreq: TStringField;
    qPairedQSOidQSO: TLargeintField;
    qPairedQSOpoints: TLargeintField;
    qPairedQSOqdate: TStringField;
    qPairedQSOqmode: TStringField;
    qPairedQSOqtime: TStringField;
    qPairedQSOrefItuCallSign: TStringField;
    qPairedQSOrefStation: TLargeintField;
    qPairedQSOrstr: TLargeintField;
    qPairedQSOrsts: TLargeintField;
    qPairedQSOt: TLargeintField;
    qInsertRecord: TZQuery;
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
    qStationByCallsoapbox: TStringField;
    SELQSOs: TZQuery;
    qAllStations: TZQuery;
    qQSOByStation: TZQuery;
    SELQSOscallr: TStringField;
    SELQSOscallr2: TStringField;
    SELQSOscalls: TStringField;
    SELQSOscalls2: TStringField;
    SELQSOsconfirmed: TLargeintField;
    SELQSOsconfirmed2: TLargeintField;
    SELQSOsexchr: TLargeintField;
    SELQSOsexchr2: TLargeintField;
    SELQSOsexchs: TLargeintField;
    SELQSOsexchs2: TLargeintField;
    SELQSOsfreq: TStringField;
    SELQSOsfreq2: TStringField;
    SELQSOsidQSO: TLargeintField;
    SELQSOsidQSO2: TLargeintField;
    SELQSOspoints: TLargeintField;
    SELQSOspoints2: TLargeintField;
    SELQSOsqdate: TStringField;
    SELQSOsqdate2: TStringField;
    SELQSOsqmode: TStringField;
    SELQSOsqmode2: TStringField;
    SELQSOsqtime: TStringField;
    SELQSOsqtime2: TStringField;
    SELQSOsrefItuCallSign: TStringField;
    SELQSOsrefItuCallSign2: TStringField;
    SELQSOsrefStation: TLargeintField;
    SELQSOsrefStation2: TLargeintField;
    SELQSOsrstr: TLargeintField;
    SELQSOsrstr2: TLargeintField;
    SELQSOsrsts: TLargeintField;
    SELQSOsrsts2: TLargeintField;
    SELQSOst: TLargeintField;
    SELQSOst2: TLargeintField;
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
    SELStationssoapbox: TStringField;
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
    qResetConfirmed: TZQuery;
    UPDStations: TZQuery;
    UPDQSOs: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qsosAfterInsert(DataSet: TDataSet);
    procedure stationsAfterInsert(DataSet: TDataSet);
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

     procedure ProcessQSOsNoPartner;
     procedure ProcessQSOsConfirmed;
     procedure LoadQSOByStationID(stationID: integer);
     function ValidContact: boolean;

     procedure SaveCountries(prefix, country, continent, latitude, longitude
                            , doubt, itu, cq, table: string);
     procedure SaveExceptionsTable(var line: TStringList);
     procedure SavePrefixesTable(var line: TstringList);

     procedure ScoresByStation;

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

   procedure CalculateScores;

   procedure ImportPrefixes (fileName: String);

  end;

{ TQSOInformation }

TQSOInformation = class
  private
    _station: string;
    function isSpecialStation: boolean;
    procedure loadSpecialStation;
    procedure loadStation;
  public
   continent: string;
   country: string;
   sudamerican: boolean;
   cqZone: integer;
   radiocountry: string;
   procedure Create (station: string);
 end;


var
  DM_Contest: TDM_Contest;

implementation
{$R *.lfm}
uses
  forms
  ,dateutils
  ;

{ TQSOInformation }

function TQSOInformation.isSpecialStation: boolean;
begin

end;

procedure TQSOInformation.loadSpecialStation;
begin

end;

procedure TQSOInformation.loadStation;
begin

end;

procedure TQSOInformation.Create(station: string);
begin
  _station:= station;
  if isEspecialStation then
   loadSpecialStation
  else
   loadStation;
end;

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

procedure TDM_Contest.stationsAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    stationsidStation.AsInteger:= 0;
    stationscallsign.AsString:= EmptyStr;
    stationssoapbox.AsString:= EmptyStr;
    stationscAssisted.AsString:= EmptyStr;
    stationscBand.AsString:= EmptyStr;
    stationscOper.AsString:= EmptyStr;
    stationscPower.AsString:= EmptyStr;
    stationscStation.AsString:= EmptyStr;
    stationscTime.AsString:= EmptyStr;
    stationsclaimedScore.asInteger:= 0;
    stationsclub.AsString:= EmptyStr;
    stationscreatedBy.AsString:= EmptyStr;
    stationsemail.AsString:= EmptyStr;
    stationslocation.AsString:= EmptyStr;
    stationsname.AsString:= EmptyStr;
    stationsaddress.AsString:= EmptyStr;
    stationsacity.AsString:= EmptyStr;
    stationsaStateProv.AsString:= EmptyStr;
    stationsaCountry.AsString:= EmptyStr;
    stationsoperators.AsString:= EmptyStr;
    stationsofftime.AsString:= EmptyStr;
    stationscTransmitter.AsString:= EmptyStr;
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
        qsosfreq.asString:= UpperCase(Trim(splitRow [0]));
        qsosqmode.AsString:= UpperCase(Trim(splitRow [1]));
        qsosqdate.AsString:= UpperCase(Trim(splitRow [2]));
        qsosqTime.asString:= UpperCase(Trim(splitRow [3]));
        qsoscalls.asString:= UpperCase(Trim(splitRow [4]));
        qsosrsts.AsInteger:= strToIntDef (splitRow [5], 599);
        qsosexchs.AsInteger:= strToIntDef (splitRow [6], -1);
        qsoscallr.AsString:= UpperCase(Trim(splitRow [7]));
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
        FieldByName(fieldName).AsString:= FieldByName(fieldName).AsString + UpperCase(Trim(rowData));
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
   if TRIM (rowLabel) <> EmptyStr then
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
  DM_General.SaveINSData(INSstations, stations);

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

   DM_General.SaveINSData(INSQSOs, qsos);

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
       DM_General.ReiniciarTabla(stations);
       DM_General.ReiniciarTabla(qsos);
       stations.Insert;
       analizeFile(logPath+'\'+fileSearch.Name);
    Until FindNext(fileSearch)<>0;
  end;
  FindClose(fileSearch);
end;

(*******************************************************************************
*** Calculate Scores
********************************************************************************)
//
procedure TDM_Contest.ScoresByStation;
var
  continentLst
  ,countryLst
  ,sudamericanLst
  ,cqzoneLst
  ,radiocountryLst: TStringList;
begin
  continentLst:=  TStringList.Create;
  with qsos do
  begin
    First;
    While Not EOF do
    begin
      if ((qsosconfirmed.AsInteger = QSO_CONFIRMED) or
         (qsosconfirmed.AsInteger = QSO_CONFIRMED)) then
      begin

      end;
      Next;
    end;
  end;
end;


//QSOs without a partner
procedure TDM_Contest.ProcessQSOsNoPartner;
begin
  qStationByCall.Close;
  qStationByCall.ParamByName('callsign').AsString:= TRIM(UpperCase(qsoscallr.asString));
  qStationByCall.Open;
  if (qStationByCall.RecordCount = 0) then
  begin
     qsos.Edit;
     qsosconfirmed.AsInteger:= QSO_MAYBE;
     qsos.Post;
  end;
end;

function TDM_Contest.ValidContact: boolean;
const
  _TOLERANCE = 10; //minutes
var
  dateSender, dateReceiver
  ,datediff: TDateTime;
  ResOK: Boolean;
  firstComp:integer;
  dt: TFormatSettings;
begin
  ResOK:= false;
  dt.ShortDateFormat:= 'YYYY-MM-DD';
  dt.DateSeparator:= '-';
  dt.LongDateFormat:= 'YYYY-MM-DD HHMM';
  dt.LongTimeFormat:= 'HHMM';
  dt.ShortTimeFormat:= 'HHMM';
  dt.TimeSeparator:=':';
  dateSender:= StrToDate(qsosqdate.AsString, dt)
               + StrToTime(Copy (qsosqTime.AsString, 1,2)
               +':'+Copy(qsosqTime.AsString, 3,2), dt);
  dateReceiver:=  StrToDate(qPairedQSOqdate.AsString, dt)
                  + StrToTime(Copy (qPairedQSOqtime.AsString, 1,2)
                  +':'+Copy(qPairedQSOqtime.AsString, 3,2), dt);
  firstComp:= CompareDateTime(dateSender, dateReceiver);
  if firstComp = 0 then
   ResOK := true
  else
    if firstComp < 0 then
    begin //dateSender < dateReceiver
      dateSender:= IncMinute(dateSender,_TOLERANCE);
      dateReceiver:= IncMinute(dateReceiver,(_TOLERANCE * -1));
      ResOK:= (CompareDateTime(dateSender, dateReceiver) > 0);
    end
    else
    begin //dateSender > dateReceiver
      dateSender:= IncMinute(dateSender,(_TOLERANCE * -1));
      dateReceiver:= IncMinute(dateReceiver,_TOLERANCE);
      ResOK:= (CompareDateTime(dateSender, dateReceiver) < 0);
    end;
    Result:= ResOK;
end;

procedure TDM_Contest.ProcessQSOsConfirmed;
var
  stateQ: integer;
begin
  with qPairedQSO do
  begin
    if active then close;
    ParamByName('calls').AsString:= Trim(qsoscallr.AsString);
    ParamByName('callr').AsString:= Trim(qsoscalls.AsString);
    Open;
    stateQ:= QSO_INVALID;
    if (RecordCount > 0) then
    begin
      if ValidContact then
       stateQ:= QSO_CONFIRMED;
    end;
    qsos.Edit;
    qsosconfirmed.AsInteger:= stateQ;
    qsos.Post;
  end;
end;


procedure TDM_Contest.LoadQSOByStationID(stationID: integer);
begin
  DM_General.ReiniciarTabla(qsos);
  with qQSOByStation do
  begin
    if active then close;
    ParamByName('station').asInteger:= stationID;
    Open;
    qsos.LoadFromDataSet(qQSOByStation, 0, lmAppend);
    Close;
  end;
end;


procedure TDM_Contest.CalculateScores;
begin
  qResetConfirmed.ExecSQL;
  with qAllStations do
  begin
    if active then close;
    open;
    while not EOF do
    begin
      LoadQSOByStationID(qAllStationsidStation.AsInteger);
      qsos.First;
      While Not qsos.EOF do
      begin
        ProcessQSOsNoPartner;
        if qsosconfirmed.AsInteger = 0 then
          ProcessQSOsConfirmed;
        qsos.Next;
      end;
      DM_General.GrabarDatos(SELQSOs, INSQSOs, UPDQSOs, qsos, 'idQSO');

      Next;//NextStation
    end;
  end;
end;

(*******************************************************************************
*** Load Prefixes from Scott N3FJP format
********************************************************************************)


procedure TDM_Contest.SaveCountries(prefix, country, continent, latitude,
  longitude, doubt, itu, cq, table: string);

begin
  with qInsertRecord do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO ' + table);
    SQL.Add('(prefix, country, continent, latitude, longitude, itu, cq) ');
    SQL.Add('VALUES');
    SQL.Add(''''+ prefix+ ''','''+ country+ ''','''+ continent+ ''','''
                + latitude+ ''','''+ longitude+ ''','''
                + itu+ ''','''+ cq+ ''',''');
    ExecSQL;
  end;
end;


procedure TDM_Contest.SaveExceptionsTable(var line: TStringList);
begin
  with qInsertRecord do
  begin
    sql.clear;
    sql.Add('INSERT INTO specialStations');
    sql.Add('(station, country, continent, latitude, longitude, cq, itu)');
    sql.Add('VALUES');
    sql.Add('('''+ Copy(TRIM(line[0]), 2, Length(TRIM(line[0]))-1)
            + ''', ''' + line[1]
            + ''', '''+ StringReplace(line[2], '''', ' ', [rfReplaceAll])
            + ''', ''' + StringReplace(line[3], '''', ' ', [rfReplaceAll])
            + ''', ''' + line[4]
            + ''', ' + line[6]
            + ', ' + line[7]
            + ')');
    ExecSQL;
  end;
end;

procedure TDM_Contest.SavePrefixesTable(var line: TstringList);
begin
  with qInsertRecord do
  begin
    sql.clear;
    sql.Add('INSERT INTO countryFile');
    sql.Add('(prefix, country, continent, latitude, longitude, cq, itu)');
    sql.Add('VALUES');
    sql.Add('('''+ line[0]
            + ''', ''' + line[1]
            + ''', '''+ StringReplace(line[2], '''', ' ', [rfReplaceAll])
            + ''', ''' + StringReplace(line[3], '''', ' ', [rfReplaceAll])
            + ''', '''  + line[4]
            + ''', ' + line[6]
            + ', ' + line[7]
            + ')');
    ExecSQL;
  end;
end;


procedure TDM_Contest.ImportPrefixes(fileName: String);
var
  fScott: Text;
  line: string;
  fields: TStringList;
begin
  AssignFile(fScott, fileName);
  fields:= TStringList.Create;
  try
    Reset(fScott);
    fields.Delimiter:= ',';
    While Not EOF(fScott) do
    begin
      ReadLn (fScott, line);
      fields.DelimitedText:= line;

      if Pos('=', fields[0] ) <> 0 then
        SaveExceptionsTable(fields)
      else
        SavePrefixesTable(fields);
    end;
  finally
    fields.Free;
    CloseFile(fScott);
  end;

end;


end.

