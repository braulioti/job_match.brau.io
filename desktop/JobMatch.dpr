program JobMatch;

uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  unMainForm in 'forms\unMainForm.pas' {frmMainForm},
  ChildWin in 'ChildWin.pas' {MDIChild},
  Constants in 'libs\Constants.pas',
  Language in 'libs\Language.pas',
  Utils in 'libs\Utils.pas',
  unConfiguration in 'forms\unConfiguration.pas' {frmConfiguration},
  Config in 'libs\Config.pas',
  unSplash in 'forms\unSplash.pas' {frmSplash},
  unAbout in 'forms\unAbout.pas' {frmAbout};

{$R *.RES}

const
  TOTAL_FORMS = 3;

var
  Version: string;
  Author: string;

begin
  Application.Initialize;

  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;
  frmSplash.Update;

  frmSplash.pgbProgress.Max := TOTAL_FORMS;

  Application.MainFormOnTaskBar := True;
  Application.Title := 'Job Match';
  Application.CreateForm(TfrmMainForm, frmMainForm);
  frmSplash.pgbProgress.Position := frmSplash.pgbProgress.Position + 1;

  // Update Labels
  Version := Format('%s %s', [frmMainForm.Languages.VersionTitle, CustomConfig.Version]);
  Author := Format('%s %s', [frmMainForm.Languages.Author, AUTHOR_NAME]);
  ChangeAndRefreshLabel(frmSplash.lblProgressStatus, frmMainForm.Languages.LoadingApplicationScreens);
  ChangeAndRefreshLabel(frmSplash.lblVersion, Version);
  ChangeAndRefreshLabel(frmSplash.lblAboutDetails, frmMainForm.Languages.AboutDetails);
  ChangeAndRefreshLabel(frmSplash.lblAuthor, Author);
  Sleep(1000);

  Application.CreateForm(TfrmConfiguration, frmConfiguration);
  frmSplash.pgbProgress.Position := frmSplash.pgbProgress.Position + 1;
  Sleep(500);

  Application.CreateForm(TfrmAbout, frmAbout);
  frmSplash.pgbProgress.Position := frmSplash.pgbProgress.Position + 1;
  Sleep(500);

  frmSplash.Close;
  frmSplash.Free;

  Application.Run;
end.
