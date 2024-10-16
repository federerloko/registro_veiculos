unit principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  pessoas, veiculos, dmVeiculos, SQLDB, DB, SQLite3Conn;

type

  { Tfrmprincipal }

  Tfrmprincipal = class(TForm)
    lblVeiculos: TLabel;
    lblPessoasForm: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblPessoasFormClick(Sender: TObject);
    procedure lblPessoasFormMouseLeave(Sender: TObject);
    procedure lblPessoasFormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblVeiculosClick(Sender: TObject);


  private

  public

  end;

var
  frmprincipal: Tfrmprincipal;

implementation

{$R *.lfm}

{ Tfrmprincipal }

procedure Tfrmprincipal.lblPessoasFormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     // Altera a fonte para sublinhado quando o
     // usuário passar o mouse pela label
     TLabel(Sender).Font.Style:=[fsUnderline];
end;

procedure Tfrmprincipal.lblVeiculosClick(Sender: TObject);
begin
     // Chama o formulário de veiculos
     with TfrmVeiculos.Create(Self) do
          try
             ShowModal;
          finally
             Free;
          end;
end;



procedure Tfrmprincipal.lblPessoasFormMouseLeave(Sender: TObject);
begin
     //Remove o sublinhado quando o mouse
     // deixa a label
     TLabel(Sender).Font.Style:=[];
end;

procedure Tfrmprincipal.lblPessoasFormClick(Sender: TObject);
begin
     // Chama o formulário de pessoas
     with TfrmPessoas.Create(Self) do
          try
             ShowModal;
          finally
             Free;
          end;
end;

procedure Tfrmprincipal.FormCreate(Sender: TObject);
begin


end;

procedure Tfrmprincipal.FormShow(Sender: TObject);
begin
     DataModule1.database.Connected:=True;

     if(DataModule1.database.Connected)then
        Caption:='Conectado'
     else
        Caption:='Não conectado';
end;

end.

