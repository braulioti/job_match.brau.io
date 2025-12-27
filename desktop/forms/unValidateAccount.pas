unit unValidateAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, System.UITypes;

type
  TfrmValidateAccount = class(TForm)
    lblValidateAccount: TLabel;
    btnSendEmail: TBitBtn;
    btnValidate: TBitBtn;
    btnClose: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btnValidateClick(Sender: TObject);
    procedure btnSendEmailClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
  public
    { Public declarations }
  end;

var
  frmValidateAccount: TfrmValidateAccount;

implementation

{$R *.dfm}

uses unMainForm, Config, unMainDataModule;

procedure TfrmValidateAccount.btnSendEmailClick(Sender: TObject);
var
  Sent: boolean;
begin
  Screen.Cursor := crHourGlass;
  try
    Sent := dtmMainDataModule.ResendValidateMail(CustomConfig.HashAuthentication);
    if Sent then
    begin
      Screen.Cursor := crDefault;
      MessageDlg(frmMainForm.Languages.SendEmailSuccess,
        TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], 0);
    end
    else
      raise Exception.Create(frmMainForm.Languages.SendEmailError);
  except
    Screen.Cursor := crDefault;
    MessageDlg(frmMainForm.Languages.SendEmailError,
      TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  end;
end;

procedure TfrmValidateAccount.btnValidateClick(Sender: TObject);
var
  AuthStatus: boolean;
begin
  Screen.Cursor := crHourGlass;
  try
    AuthStatus := dtmMainDataModule.ValidatedMail(CustomConfig.HashAuthentication);
    frmMainForm.ValidatedMail := AuthStatus;
    frmMainForm.UpdateStatusValidateAccount(AuthStatus);
    Screen.Cursor := crDefault;
    if AuthStatus then
    begin
      MessageDlg(frmMainForm.Languages.ValidateAccountSuccessful, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
      ModalResult := mrOk;
    end
    else
      MessageDlg(frmMainForm.Languages.ValidateAccountError, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmValidateAccount.FormActivate(Sender: TObject);
begin
  UpdateLanguage;
end;

procedure TfrmValidateAccount.UpdateLanguage;
begin
  lblValidateAccount.Caption :=  frmMainForm.Languages.ValidationMessage;
  frmValidateAccount.Caption :=  frmMainForm.Languages.Validation;

  btnSendEmail.Caption := frmMainForm.Languages.SendEmail;
  btnValidate.Caption := frmMainForm.Languages.Validate;
  btnClose.Caption := frmMainForm.Languages.Close;
end;

end.
