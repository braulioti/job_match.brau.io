program JobMatch;

uses
  Forms,
  unMainForm in 'unMainForm.pas' {MainForm},
  ChildWin in 'ChildWin.pas' {MDIChild},
  about in 'about.pas' {AboutBox},
  Vcl.Themes,
  Vcl.Styles,
  Constants in 'Constants.pas',
  Language in 'Language.pas',
  Utils in 'Utils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskBar := True;
  Application.Title := 'Job Match';
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
