program JobMatch;

uses
  Forms,
  unMainForm in 'unMainForm.pas' {frmMainForm},
  ChildWin in 'ChildWin.pas' {MDIChild},
  about in 'about.pas' {AboutBox},
  Vcl.Themes,
  Vcl.Styles,
  Constants in 'Constants.pas',
  Language in 'Language.pas',
  Utils in 'Utils.pas',
  unConfiguration in 'unConfiguration.pas' {frmConfiguration};

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskBar := True;
  Application.Title := 'Job Match';
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfrmConfiguration, frmConfiguration);
  Application.Run;
end.
