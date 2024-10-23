unit veiculos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmVeiculos }

  TfrmVeiculos = class(TForm)
    btnConfirma: TButton;
    edtPlaca: TEdit;
    edtMarca: TEdit;
    edtModelo: TEdit;
    edtAno: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
  private

  public

  end;

var
  frmVeiculos: TfrmVeiculos;

implementation

{$R *.lfm}

{ TfrmVeiculos }

procedure TfrmVeiculos.btnConfirmaClick(Sender: TObject);
begin

end;

end.

