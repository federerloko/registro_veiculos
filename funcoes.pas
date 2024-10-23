unit funcoes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn,Dialogs;

function ComandosCSV(stArquivo:TStringList):TStringList;
procedure EnviaComando(database:TSQLite3Connection;sSql:string);

implementation

function ComandosCSV(stArquivo: TStringList):TStringList;
var
   stLista:TStringList;
   i,j:integer;
   sLinha,
   sSql:string;
   arrLinha:TStringArray;
begin
     stLista:=TStringList.create;

     for i:=1 to stArquivo.Count-1 do
     begin
          sSql:='insert into pessoas values(';

          sLinha:=stArquivo[i];

          if(sLinha = '')then
             Continue;

          arrLinha:=sLinha.Split(';');

          if(arrLinha[0]='1')then
             Continue;

          for j:=1 to Length(arrLinha)-1 do
          begin
              if(j < Length(arrLinha)-1)then
                   sSql:=sSql+QuotedStr(arrLinha[j])+','
              else
                  sSql:=sSql+QuotedStr(arrLinha[j])+');';


          end;
          stLista.Add(sSql);
     end;

     stLista.SaveToFile('lista.txt');
     Result:=stLista;
     //FreeAndNil(stLista);
end;

procedure EnviaComando(database:TSQLite3Connection;sSql: string);
begin
     try
        database.Transaction.Rollback;
        database.Transaction.StartTransaction;
        database.ExecuteDirect(sSql);
        database.Transaction.Commit;
     except on E:Exception do
     begin
            ShowMessage('Erro :'+e.Message);
            database.Transaction.Rollback;
     end;
     end;
end;

end.

