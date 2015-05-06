unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  Menus, ExtCtrls, StdCtrls, DBGrids
  ,dmgeneral;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    conImportPrefixes: TAction;
    conCalcScores: TAction;
    conAddFileLog: TAction;
    conAddFolderLogs: TAction;
    contLoad: TAction;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem9: TMenuItem;
    selPrefixes: TOpenDialog;
    txLog: TMemo;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    selLog: TOpenDialog;
    Panel1: TPanel;
    prgExit: TAction;
    contNew: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    SelContest: TSelectDirectoryDialog;
    stYearContest: TStaticText;
    stNameContest: TStaticText;
    stPath: TStaticText;
    procedure conAddFileLogExecute(Sender: TObject);
    procedure conAddFolderLogsExecute(Sender: TObject);
    procedure conCalcScoresExecute(Sender: TObject);
    procedure conImportPrefixesExecute(Sender: TObject);
    procedure contLoadExecute(Sender: TObject);
    procedure contNewExecute(Sender: TObject);
    procedure prgExitExecute(Sender: TObject);
  private
    procedure ContestProperties (path: string);
    procedure LoadScreen;
    procedure RefreshLog;
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.lfm}
uses
  frm_contestam
  ,dmcontest
  ;

{ TfrmMain }

procedure TfrmMain.prgExitExecute(Sender: TObject);
begin
  application.Terminate;
end;

(*******************************************************************************
*** CONTEST
*******************************************************************************)

procedure TfrmMain.ContestProperties(path: string);
var
  scrContest: TfrmContestAM;
begin
  scrContest:= TfrmContestAM.Create(self);
  try
    scrContest.path:= path;
    scrContest.ShowModal;
  finally
    scrContest.Free;
  end;
  LoadScreen;
end;

procedure TfrmMain.LoadScreen;
begin
  stYearContest.Caption:= DM_Contest.contestYear;
  stNameContest.Caption:= DM_Contest.contestName;
  stPath.Caption:= DM_Contest.contestPath;
  RefreshLog;
end;

procedure TfrmMain.RefreshLog;
begin
  txLog.Clear;
  DM_General.EventLog.Active:= false;
  txLog.Lines.LoadFromFile(DM_General.EventLog.FileName);
  DM_General.EventLog.Active:= true;
end;

procedure TfrmMain.contNewExecute(Sender: TObject);
begin
  ContestProperties(EmptyStr);
end;

procedure TfrmMain.contLoadExecute(Sender: TObject);
begin
  if SelContest.Execute then
    ContestProperties(SelContest.FileName);
end;

procedure TfrmMain.conAddFolderLogsExecute(Sender: TObject);
begin
  DM_Contest.analizeLogDir;
  RefreshLog;
  ShowMessage('Process finished');
end;

procedure TfrmMain.conAddFileLogExecute(Sender: TObject);
begin
  if selLog.Execute then
    DM_Contest.analizeFile(selLog.FileName);
  RefreshLog;
  ShowMessage('Process finished');
end;


procedure TfrmMain.conCalcScoresExecute(Sender: TObject);

begin
  DM_Contest.CalculateScores;
  ShowMessage('The scores have been calculated');
end;

procedure TfrmMain.conImportPrefixesExecute(Sender: TObject);
begin
  if selPrefixes.Execute then
    DM_Contest.ImportPrefixes (selPrefixes.FileName);
end;


end.

