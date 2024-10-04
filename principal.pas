unit principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  pessoas, SQLDB, DB, SQLite3Conn;

type

  { Tfrmprincipal }

  Tfrmprincipal = class(TForm)
    lblPessoasForm: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lblPessoasFormClick(Sender: TObject);
    procedure lblPessoasFormMouseLeave(Sender: TObject);
    procedure lblPessoasFormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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

end.

