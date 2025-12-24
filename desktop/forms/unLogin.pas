unit unLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmLogin = class(TForm)
    lblEmail: TLabel;
    edtEmail: TEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lblPassword: TLabel;
    edtPassword: TEdit;
    procedure FormActivate(Sender: TObject);
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

uses unMainForm;

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
