unit unLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  System.JSON, REST.Client, REST.Types, System.UITypes;

type
  TfrmLogin = class(TForm)
    lblEmail: TLabel;
    edtEmail: TEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lblPassword: TLabel;
    edtPassword: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses unMainForm, unMainDataModule, Config;

procedure TfrmLogin.btnOKClick(Sender: TObject);
var
  JsonBody: TJSONObject;
  JsonResponse: TJSONObject;
  URI: string;
begin
  JsonBody := TJSONObject.Create;
  try
    JsonBody.AddPair('email', edtEmail.Text);
    JsonBody.AddPair('password', edtPassword.Text);

    URI := Format('%s/v1/users/login', [CustomConfig.APIServer]);

    Screen.Cursor := crHourGlass;
    dtmMainDataModule.restClient.BaseURL := URI;
    dtmMainDataModule.restRequest.Method := rmPOST;
    dtmMainDataModule.restRequest.body.ClearBody;
    dtmMainDataModule.restRequest.Params.Clear;
    dtmMainDataModule.restRequest.AddBody(JsonBody.ToString, ctAPPLICATION_JSON);
    dtmMainDataModule.restRequest.Execute;

    JsonResponse := TJSONObject.ParseJSONValue(dtmMainDataModule.restResponse.Content)
      as TJSONObject;
    try
      Screen.Cursor := crDefault;

      if (dtmMainDataModule.restResponse.StatusCode >= 200) and
         (dtmMainDataModule.restResponse.StatusCode < 300) then
      begin
        CustomConfig.HashAuthentication := JsonResponse.GetValue('hash').Value;
        SaveConfiguration;
        ModalResult := mrOk;
      end
      else
        MessageDlg(JsonResponse.GetValue('error').Value, mtError, [mbOK], 0);
    finally
      JsonResponse.Free;
    end;
  finally
    JsonBody.Free;
  end;
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  UpdateLanguage;
end;

procedure TfrmLogin.UpdateLanguage;
begin
  lblEmail.Caption := frmMainForm.Languages.Email;
  lblPassword.Caption := frmMainForm.Languages.Password;
  btnOK.Caption := frmMainForm.Languages.OK;
  btnCancel.Caption := frmMainForm.Languages.Cancel;
end;

end.
