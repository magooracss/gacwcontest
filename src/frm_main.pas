unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  Menus;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    contLoad: TAction;
    MenuItem5: TMenuItem;
    prgExit: TAction;
    contNew: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    SelContest: TSelectDirectoryDialog;
    procedure contLoadExecute(Sender: TObject);
    procedure contNewExecute(Sender: TObject);
    procedure prgExitExecute(Sender: TObject);
  private
    procedure ContestProperties (path: string);
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.lfm}
uses
  frm_contestam
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


end.

