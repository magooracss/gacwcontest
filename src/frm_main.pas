unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  Menus, ExtCtrls, StdCtrls
  ,dmgeneral;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    conAddFileLog: TAction;
    conAddFolderLogs: TAction;
    contLoad: TAction;
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
end;

procedure TfrmMain.conAddFileLogExecute(Sender: TObject);
begin
  if selLog.Execute then
    DM_Contest.analizeFile(selLog.FileName);
  RefreshLog;
end;


end.

