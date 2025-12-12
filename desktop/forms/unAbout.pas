unit unAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmAbout = class(TForm)
    imgLogo: TImage;
    lblVersion: TLabel;
    lblAboutDetails: TLabel;
    lblAuthor: TLabel;
    btnClose: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

uses unMainForm, Config, Constants;

procedure TfrmAbout.FormActivate(Sender: TObject);
begin
  UpdateLanguage;
end;

procedure TfrmAbout.UpdateLanguage;
var
  Version: string;
  Author: string;
begin
  Version := Format('%s %s', [frmMainForm.Languages.VersionTitle, CustomConfig.Version]);
  Author := Format('%s %s', [frmMainForm.Languages.Author, AUTHOR_NAME]);

  frmAbout.Caption := frmMainForm.Languages.About;
  lblVersion.Caption := Version;
  lblAboutDetails.Caption := frmMainForm.Languages.AboutDetails;
  lblAuthor.Caption := Author;
  btnClose.Caption := frmMainForm.Languages.Close;
end;

end.
