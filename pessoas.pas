unit pessoas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, funcoes,
  dmVeiculos;

type

  { TfrmPessoas }

  TfrmPessoas = class(TForm)
    btnNovo: TButton;
    btnConfirma: TButton;
    btnSincronizar: TButton;
    edtcontato: TEdit;
    edtcpf: TEdit;
    edtdatanascimento: TEdit;
    edtnome: TEdit;
    edtsobrenome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmPessoas: TfrmPessoas;
  stPessoas:TStringList;

implementation

{$R *.lfm}

{ TfrmPessoas }

procedure TfrmPessoas.FormCreate(Sender: TObject);
begin

     if(stPessoas = nil)then
        stPessoas:=TStringList.Create;

     if(FileExists('pessoas.csv'))then
        stPessoas.LoadFromFile('pessoas.csv');

     if(stPessoas.Count > 1)then
     begin
        ShowMessage('Existem registros não gravados no banco.');
        btnSincronizar.Enabled:=True;
     end;
end;

procedure TfrmPessoas.btnNovoClick(Sender: TObject);
var
   i:integer;
begin
     for i:=0 to Self.ComponentCount-1 do
         if(Self.Components[i] is TEdit)then
            TEdit(Self.Components[i]).Clear;

     edtcpf.SetFocus;
end;

procedure TfrmPessoas.btnSincronizarClick(Sender: TObject);
begin
     Memo1.Lines:=ComandosCSV(stPessoas);

     EnviaComando(DataModule1.database,Memo1.Lines[0]);
end;

procedure TfrmPessoas.btnConfirmaClick(Sender: TObject);
var
   sInfo:String;
begin
     try
        sInfo:=edtcpf.Text+';'+edtnome.Text+';'+edtsobrenome.Text+';'+
        edtcontato.Text+';'+edtdatanascimento.Text;

        stPessoas.Add(sInfo);

     Except
       ShowMessage('Erro');
       Exit;
     end;

     stPessoas.SaveToFile('pessoas.csv');
     Memo1.Lines:=nil;
     Memo1.Lines:=stPessoas;
end;

end.

