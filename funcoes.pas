unit funcoes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function ComandosCSV(stArquivo:TStringList):TStringList;

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
          arrLinha:=sLinha.Split(';');

          for j:=0 to Length(arrLinha)-1 do
          begin
              if(j < Length(arrLinha)-1)then
                   sSql:=sSql+QuotedStr(arrLinha[j])+','
              else
                  sSql:=sSql+QuotedStr(arrLinha[j])+');';


          end;
          stLista.Add(sSql);
     end;

     Result:=stLista;
     //FreeAndNil(stLista);
end;

end.

