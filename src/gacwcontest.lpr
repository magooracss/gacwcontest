program gacwcontest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, zcomponent, frm_main, dmgeneral, frm_contestam, dmcontest,
  SD_Configuracion;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Contest, DM_Contest);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

