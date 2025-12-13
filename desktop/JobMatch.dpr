program JobMatch;

uses
  Forms, Vcl.Themes, Vcl.Styles, System.SysUtils, System.Classes,
  unMainForm in 'forms\unMainForm.pas' {frmMainForm},
  ChildWin in 'ChildWin.pas' {MDIChild},
  Constants in 'libs\Constants.pas',
  Language in 'libs\Language.pas',
  Utils in 'libs\Utils.pas',
  unConfiguration in 'forms\unConfiguration.pas' {frmConfiguration},
  Config in 'libs\Config.pas',
  unSplash in 'forms\unSplash.pas' {frmSplash},
  unAbout in 'forms\unAbout.pas' {frmAbout},
  unNewProject in 'forms\unNewProject.pas' {frmNewProject},
  unOpenProject in 'forms\unOpenProject.pas' {frmOpenProject};

{$R *.RES}

const
  TOTAL_FORMS = 5;

procedure CreateFormAndUpdateProgress(InstanceClass: TComponentClass; var Reference);
begin
  Application.CreateForm(InstanceClass, Reference);
  frmSplash.pgbProgress.Position := frmSplash.pgbProgress.Position + 1;
  Sleep(300);
end;

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

  CreateFormAndUpdateProgress(TfrmAbout, frmAbout);
  CreateFormAndUpdateProgress(TfrmNewProject, frmNewProject);
  CreateFormAndUpdateProgress(TfrmOpenProject, frmOpenProject);
  CreateFormAndUpdateProgress(TfrmConfiguration, frmConfiguration);

  frmSplash.Close;
  frmSplash.Free;

  Application.Run;
end.
