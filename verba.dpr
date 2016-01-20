program verba;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  WBoth in 'wboth.pas',
  unit_Verba in 'unit_Verba.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
