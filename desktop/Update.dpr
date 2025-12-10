program Update;

uses
  Vcl.Forms,
  unUpdate in 'unUpdate.pas' {frmUpdate},
  Utils in 'Utils.pas',
  Vcl.Themes,
  Vcl.Styles,
  Constants in 'Constants.pas',
  Language in 'Language.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TfrmUpdate, frmUpdate);
  Application.Run;
end.
