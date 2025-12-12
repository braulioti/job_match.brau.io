program Update;

uses
  Vcl.Forms,
  unUpdate in 'unUpdate.pas' {frmUpdate},
  Utils in 'libs\Utils.pas',
  Vcl.Themes,
  Vcl.Styles,
  Constants in 'libs\Constants.pas',
  Language in 'libs\Language.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmUpdate, frmUpdate);
  Application.Run;
end.
