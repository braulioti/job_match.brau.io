program JobMatch;

uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  System.JSON,
  REST.Types,
  REST.HttpClient,
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
  unOpenProject in 'forms\unOpenProject.pas' {frmOpenProject},
  unLogin in 'forms\unLogin.pas' {frmLogin},
  unMainDataModule in 'data_modules\unMainDataModule.pas' {dtmMainDataModule: TDataModule};

{$R *.RES}

const
  TOTAL_FORMS = 6;
  TOTAL_ACTIONS = 1;

function TryAuthenticate: Boolean;
var
  HashAuthentication: string;
  JsonValue: TJSONValue;
  URI: string;
begin
  Result := False;
  HashAuthentication := Trim(CustomConfig.HashAuthentication);

  if HashAuthentication = '' then
    Exit;

  URI := Format('%s/v1/users/hash-login/%s',
    [CustomConfig.APIServer, HashAuthentication]);

  dtmMainDataModule.restClient.BaseURL := URI;
  dtmMainDataModule.restRequest.Method := rmPOST;
  dtmMainDataModule.restRequest.Body.ClearBody;
  dtmMainDataModule.restRequest.Params.Clear;

  dtmMainDataModule.restRequest.Execute;

  Result := dtmMainDataModule.restResponse.StatusCode = 200;
end;


procedure CreateFormAndUpdateProgress(InstanceClass: TComponentClass; var Reference);
begin
  Application.CreateForm(InstanceClass, Reference);
  frmSplash.pgbProgress.Position := frmSplash.pgbProgress.Position + 1;
  Sleep(250);
end;

var
  Version: string;
  Author: string;
  FormLogin: TfrmLogin;
  LoginStatus: Integer;

begin
  LoginStatus := -1;
  Application.Initialize;

  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;
  frmSplash.Update;

  frmSplash.pgbProgress.Max := TOTAL_FORMS + TOTAL_ACTIONS;

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

  Application.CreateForm(TdtmMainDataModule, dtmMainDataModule);
  frmSplash.pgbProgress.Position := frmSplash.pgbProgress.Position + 1;

  // Action 1 - Login
  if not(TryAuthenticate) then
  begin
    FormLogin := TfrmLogin.Create(Application);
    frmSplash.Visible := False;
    LoginStatus := FormLogin.ShowModal;
    frmSplash.Visible := True;
    frmSplash.pgbProgress.Position := frmSplash.pgbProgress.Position + 1;
  end;

  if LoginStatus = mrCancel then
    Application.Terminate
  else
  begin
    CreateFormAndUpdateProgress(TfrmAbout, frmAbout);
    CreateFormAndUpdateProgress(TfrmNewProject, frmNewProject);
    CreateFormAndUpdateProgress(TfrmOpenProject, frmOpenProject);
    CreateFormAndUpdateProgress(TfrmConfiguration, frmConfiguration);

    frmSplash.Close;
    frmSplash.Free;

    frmMainForm.Show;

    Application.Run;
  end;


end.
