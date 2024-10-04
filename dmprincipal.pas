unit dmoduleprincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB;

type

  { Tdmoduleprincipal }

  Tdmoduleprincipal = class(TDataModule)
    procedure conexaoAfterConnect(Sender: TObject);
  private

  public

  end;

var
  dmoduleprincipal: Tdmoduleprincipal;

implementation

{$R *.lfm}

{ Tdmoduleprincipal }

procedure Tdmoduleprincipal.conexaoAfterConnect(Sender: TObject);
begin

end;

end.

