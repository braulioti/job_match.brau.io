unit unOpenProject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmOpenProject = class(TForm)
    lblSelectProject: TLabel;
    lblProjectDetails: TLabel;
    mmoProjectDetails: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    cboSelectProject: TComboBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
  public
    { Public declarations }
  end;

var
  frmOpenProject: TfrmOpenProject;

implementation

{$R *.dfm}

uses unMainForm;

procedure TfrmOpenProject.FormActivate(Sender: TObject);
begin
  UpdateLanguage;
end;

procedure TfrmOpenProject.UpdateLanguage;
begin
  frmOpenProject.Caption := frmMainForm.Languages.OpenProject;
  lblSelectProject.Caption := frmMainForm.Languages.SelectProject;
  lblProjectDetails.Caption := frmMainForm.Languages.ProjectDetails;
  btnOK.Caption := frmMainForm.Languages.OK;
  btnCancel.Caption := frmMainForm.Languages.Cancel;
end;

end.
