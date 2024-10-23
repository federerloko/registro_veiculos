unit pessoas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  EditBtn, funcoes, dmVeiculos, SQLDB, DB;

type

  { TfrmPessoas }

  TfrmPessoas = class(TForm)
    btnNovo: TButton;
    btnConfirma: TButton;
    btnSincronizar: TButton;
    dtDataNasc: TDateEdit;
    dbgPessoas: TDBGrid;
    dsPessoas: TDataSource;
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
    qPessoas: TSQLQuery;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
    procedure edtcpfChange(Sender: TObject);
    procedure edtdatanascimentoChange(Sender: TObject);
    procedure edtnomeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmPessoas: TfrmPessoas;
  stPessoas:TStringList;

function ContaNaoSincronizados:Integer;

implementation

function ContaNaoSincronizados: Integer;
var
   i,
   iContador:integer;
   sLinha:String;
   arrLinha:TStringArray;
begin

     iContador:=0;
     // Percorre as linhas da stringlist
     // carregada com os dados do csv
     for i:=1 to stPessoas.Count-1 do
     begin
          sLinha:=stPessoas[i];
          arrLinha:=sLinha.Split(';');

          if(arrLinha[0]='0')then
             iContador:=iContador+1;
     end;

     Result:=iContador;
end;

{$R *.lfm}

{ TfrmPessoas }

procedure TfrmPessoas.FormCreate(Sender: TObject);
var
   sTexto:string;
begin

     if(stPessoas = nil)then
        stPessoas:=TStringList.Create;

     if(FileExists('pessoas.csv'))then
        stPessoas.LoadFromFile('pessoas.csv');

     sTexto:=Format('Existem %d registros não sincronizados',
     [ContaNaoSincronizados]);
     if(ContaNaoSincronizados > 0)then
     begin
        ShowMessage(sTexto);
        btnSincronizar.Enabled:=True;
     end;
end;

procedure TfrmPessoas.FormShow(Sender: TObject);
begin
     qPessoas.Active:=True;
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
var
   stLista:TStringList;
   i:Integer;
begin
     stLista:=TStringList.Create;

     stLista:=ComandosCSV(stPessoas);

     if(stLista.Count > 0)then
        for i:=0 to stLista.Count-1 do
        begin
             EnviaComando(DataModule1.database,stLista[i]);
        end;

     if(qPessoas.Active)then
        qPessoas.Refresh;
end;

procedure TfrmPessoas.edtcpfChange(Sender: TObject);
begin
     if(Length(edtcpf.Text)=3)or(Length(edtcpf.Text)=7)then
        edtcpf.Text:=edtcpf.Text+'.';

     if(Length(edtcpf.Text)=11)then
        edtcpf.Text:=edtcpf.Text+'-';

     edtcpf.SelStart:=Length(edtcpf.Text);
end;

procedure TfrmPessoas.edtdatanascimentoChange(Sender: TObject);
begin
  if(Length(edtdatanascimento.Text)=2)or(Length(edtdatanascimento.Text)=5)then
        edtdatanascimento.Text:=edtdatanascimento.Text+'/';

  edtdatanascimento.SelStart:=Length(edtdatanascimento.Text);
end;

procedure TfrmPessoas.edtnomeChange(Sender: TObject);
begin

end;

procedure TfrmPessoas.btnConfirmaClick(Sender: TObject);
var
   sInfo:String;
begin
     try
        sInfo:='0;'+edtcpf.Text+';'+edtnome.Text+';'+edtsobrenome.Text+';'+
        edtcontato.Text+';'+dtDataNasc.Text;

        stPessoas.Add(sInfo);

     Except
       ShowMessage('Erro');
       Exit;
     end;

     stPessoas.SaveToFile('pessoas.csv');

end;

end.

