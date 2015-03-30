unit frm_contestam;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, tooledit, RxTimeEdit, Forms, Controls, Graphics,
  Dialogs, StdCtrls, EditBtn, Buttons
  ,dmcontest
  ,dateutils;


type

  { TfrmContestAM }

  TfrmContestAM = class(TForm)
    btnSaveExit: TBitBtn;
    contestFolder: TDirectoryEdit;
    dateStart: TDateEdit;
    dateFinish: TDateEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    logsFolder: TDirectoryEdit;
    edYear: TEdit;
    edName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    timeStart: TRxTimeEdit;
    timeFinish: TRxTimeEdit;
    procedure btnSaveExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _path: string;
    procedure NewContest;
    procedure LoadScreen;
  public
     property path: string read _path write _path;
  end;

var
  frmContestAM: TfrmContestAM;

implementation

{$R *.lfm}

{ TfrmContestAM }

procedure TfrmContestAM.FormShow(Sender: TObject);
begin
  if _path = EmptyStr then
     newContest
  else
    if DM_Contest.LoadContest(_path) then
       LoadScreen
    else
      ShowMessage('ERROR: I can´t load data from files');
end;

procedure TfrmContestAM.btnSaveExitClick(Sender: TObject);
begin
  DM_Contest.SaveProperties (edName.Text
                            , edYear.Text
                            , dateStart.Date
                            , timeStart.Time
                            , dateFinish.Date
                            , timeFinish.Time
                            , contestFolder.Text
                            , logsFolder.Text
                             );
  ModalResult:= mrOK;
end;


procedure TfrmContestAM.NewContest;
begin
  edName.Text:= EmptyStr;
  edName.SetFocus;
  edYear.Text:= IntToStr(YearOf(Now));
  dateStart.Date:= Now;
  timeStart.Time:= 0;
  dateFinish.Date:= IncDay(Now);
  timeFinish.Time:= EncodeTime(23,59,59,0);
  contestFolder.Text:= 'C:\';
  logsFolder.Text:= 'C:\';
end;

procedure TfrmContestAM.LoadScreen;
begin
  edName.Text:= DM_Contest.contestName;
  edName.SetFocus;
  edYear.Text:= DM_Contest.contestYear;
  dateStart.Date:= DM_Contest.contestStartD;
  timeStart.Time:= DM_Contest.contestStartT;
  dateFinish.Date:= DM_Contest.contestFinishD;
  timeFinish.Time:= DM_Contest.contestFinishT;
  contestFolder.Text:= DM_Contest.contestPath;
  logsFolder.Text:= DM_Contest.contestLogs;

end;

end.

