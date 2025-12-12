unit unNewProject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmNewProject = class(TForm)
    lblProjectName: TLabel;
    edtProjectName: TEdit;
    lblProjectDetails: TLabel;
    mmoProjectDetails: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
  public
    { Public declarations }
  end;

var
  frmNewProject: TfrmNewProject;

implementation

{$R *.dfm}

uses unMainForm;

procedure TfrmNewProject.FormActivate(Sender: TObject);
begin
  UpdateLanguage;
end;

procedure TfrmNewProject.UpdateLanguage;
begin
  frmNewProject.Caption := frmMainForm.Languages.NewProject;
  lblProjectName.Caption := frmMainForm.Languages.ProjectName;
  lblProjectDetails.Caption := frmMainForm.Languages.ProjectDetails;
  btnOK.Caption := frmMainForm.Languages.OK;
  btnCancel.Caption := frmMainForm.Languages.Cancel;
end;

end.
