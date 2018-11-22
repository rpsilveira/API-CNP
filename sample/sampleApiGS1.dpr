program sampleApiGS1;

uses
  Vcl.Forms,
  U_API_GS1 in '..\U_API_GS1.pas',
  U_Principal in 'U_Principal.pas' {F_Principal},
  U_Conversao in '..\U_Conversao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'exemplo API - CNP';
  Application.CreateForm(TF_Principal, F_Principal);
  Application.Run;
end.
