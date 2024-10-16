unit dmVeiculos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    database: TSQLite3Connection;
    transaction: TSQLTransaction;
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

end.

