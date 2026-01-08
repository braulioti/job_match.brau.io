unit unOpenProject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, System.Generics.Collections, FireDAC.Comp.Client,
  System.UITypes, unProjectClass;

type
  TfrmOpenProject = class(TForm)
    lblSelectProject: TLabel;
    lblProjectDetails: TLabel;
    mmoProjectDetails: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    cboSelectProject: TComboBox;
    lblProjectType: TLabel;
    edtProjectType: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboSelectProjectChange(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
    function LoadProjects: TObjectList<TProject>;
    function FindProjectByProjectName(Name: String): TProject;
  public
    { Public declarations }
  end;

var
  frmOpenProject: TfrmOpenProject;
  Projects: TObjectList<TProject>;
  SelectedProject: TProject;

implementation

{$R *.dfm}

uses unMainForm, unMainDataModule, unProject, Language;

procedure TfrmOpenProject.btnOKClick(Sender: TObject);
begin
  if SelectedProject <> nil then
  begin
    frmProject := TfrmProject.Create(self);
    frmProject.Caption := SelectedProject.Name;
    frmProject.Show;
  end
  else
  begin
    ModalResult := mrNone;
    MessageDlg(frmMainForm.Languages.ErrorOpenProject, mtError, [mbOK], mrNone);
  end;
end;

procedure TfrmOpenProject.cboSelectProjectChange(Sender: TObject);
begin
  SelectedProject := FindProjectByProjectName(
    cboSelectProject.Items.Strings[cboSelectProject.ItemIndex]);

  if SelectedProject <> nil then
  begin
    mmoProjectDetails.Text := SelectedProject.Description;
    edtProjectType.Text := SelectedProject.ProjectType;
  end;
end;

function TfrmOpenProject.FindProjectByProjectName(Name: String): TProject;
var
  Project: TProject;
  I: Integer;
begin
  Project := nil;
  for I := 0 to Projects.Count - 1 do
    if Projects.Items[I].Name = Name then
      Project := Projects.Items[I];

  Result := Project;
end;

procedure TfrmOpenProject.FormActivate(Sender: TObject);
var
  I: Integer;
begin
  UpdateLanguage;
  Projects := LoadProjects;
  SelectedProject := nil;

  cboSelectProject.Clear;
  for I := 0 to Projects.Count - 1 do
    cboSelectProject.Items.Add(Projects.Items[I].Name);
end;

procedure TfrmOpenProject.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Projects.Free;
end;

function TfrmOpenProject.LoadProjects: TObjectList<TProject>;
var
  Query: TFDQuery;
  ProjectList: TObjectList<TProject>;
  Item: TProject;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dtmMainDataModule.fdcDatabase;

    Query.SQL.Clear;
    Query.Params.Clear;
    Query.SQL.Add('SELECT p.id,                                    ');
    Query.SQL.Add('       p.name,                                  ');
    Query.SQL.Add('       p.description,                           ');
    Query.SQL.Add('       pt.code                                  ');
    Query.SQL.Add('FROM project p                                  ');
    Query.SQL.Add('INNER JOIN project_type pt ON pt.id = p.type_id;');
    Query.Open;

    Query.First;
    ProjectList := TObjectList<TProject>.Create;
    while not(Query.Eof) do
    begin
      Item := TProject.Create;
      Item.Id := Query.FieldByName('id').AsInteger;
      Item.Name := Query.FieldByName('name').AsString;
      Item.Description := Query.FieldByName('description').AsString;
      Item.ProjectType := Language.GetLanguageLabel(
        frmMainForm.LanguageCode, Query.FieldByName('code').AsString);
      ProjectList.Add(Item);

      Query.Next;
    end;
    Result := ProjectList;

    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmOpenProject.UpdateLanguage;
begin
  frmOpenProject.Caption := frmMainForm.Languages.OpenProject;
  lblSelectProject.Caption := frmMainForm.Languages.SelectProject;
  lblProjectDetails.Caption := frmMainForm.Languages.ProjectDetails;
  lblProjectType.Caption := frmMainForm.Languages.ProjectType;
  btnOK.Caption := frmMainForm.Languages.OK;
  btnCancel.Caption := frmMainForm.Languages.Cancel;
end;

end.
