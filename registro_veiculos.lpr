program registro_veiculos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, principal, pessoas, funcoes, veiculos, dmVeiculos;

{$R *.res}

begin
  RequireDerivedFormResource:=False;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tfrmprincipal, frmprincipal);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

