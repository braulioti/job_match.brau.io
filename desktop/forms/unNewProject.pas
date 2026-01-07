unit unNewProject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, System.UITypes, FireDAC.Comp.Client,
  System.Generics.Collections, FireDAC.Stan.Param;

type
  TProjectType = class
  public
    Id: Integer;
    Code: string;
    Translation: string;
  end;

type
  TfrmNewProject = class(TForm)
    lblProjectName: TLabel;
    edtProjectName: TEdit;
    lblProjectDetails: TLabel;
    mmoProjectDetails: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lblProjectType: TLabel;
    cboProjectType: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
    function LoadProjectTypes: TObjectList<TProjectType>;
    function FindProjectTypeByTranslation(translation: string): TProjectType;
  public
    { Public declarations }
  end;

var
  frmNewProject: TfrmNewProject;
  ProjectTypesList: TObjectList<TProjectType>;

implementation

{$R *.dfm}

uses unMainForm, unProject, unMainDataModule, Language;

procedure TfrmNewProject.btnOKClick(Sender: TObject);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dtmMainDataModule.fdcDatabase;

    try
      Query.SQL.Clear;
      Query.Params.Clear;
      Query.SQL.Add('INSERT INTO project (name, type_id, description) VALUES (:pname, :ptype_id, :pdescription);');
      Query.Params.ParamByName('pname').Value := edtProjectName.Text;
      Query.Params.ParamByName('ptype_id').Value := FindProjectTypeByTranslation(cboProjectType.Text).Id;
      Query.Params.ParamByName('pdescription').Value := mmoProjectDetails.Text;
      Query.ExecSQL;
      Query.Close;

      frmProject := TfrmProject.Create(self);
      frmProject.Caption := edtProjectName.Text;
      frmProject.Show;
    except
      on E: Exception do
      begin
        ModalResult := mrNone;
        Query.Close;
        MessageDlg(frmMainForm.Languages.ErrorCreatingProject, mtError, [mbOK], mrNone);
      end;
    end;

  finally
    Query.Free;
  end;
end;

function TfrmNewProject.FindProjectTypeByTranslation(
  translation: string): TProjectType;
var
  I: Integer;
begin
  for I := 0 to ProjectTypesList.Count - 1 do
    if (ProjectTypesList.Items[I].Translation = translation) then
    begin
      Result := ProjectTypesList.Items[I];
      Exit;
    end;

  Result := nil;
end;

procedure TfrmNewProject.FormActivate(Sender: TObject);
var
  I: Integer;
begin
  UpdateLanguage;
  ProjectTypesList := LoadProjectTypes;

  cboProjectType.Items.Clear;
  for I := 0 to ProjectTypesList.Count - 1 do
    cboProjectType.Items.Add(ProjectTypesList.Items[I].Translation);
end;

procedure TfrmNewProject.FormCreate(Sender: TObject);
begin
  ProjectTypesList.Free;
  ProjectTypesList := nil;
end;

function TfrmNewProject.LoadProjectTypes: TObjectList<TProjectType>;
var
  Query: TFDQuery;
  Item: TProjectType;
  ProjectTypes: TObjectList<TProjectType>;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dtmMainDataModule.fdcDatabase;

    Query.SQL.Clear;
    Query.Params.Clear;
    Query.SQL.Add('SELECT * FROM project_type;');
    Query.Open;

    Query.First;
    ProjectTypes := TObjectList<TProjectType>.Create;
    while not(Query.Eof) do
    begin
      Item := TProjectType.Create;
      Item.Code := Query.FieldByName('code').AsString;
      Item.Id := Query.FieldByName('id').AsInteger;
      Item.Translation := Language.GetLanguageLabel(frmMainForm.LanguageCode, Item.Code);
      ProjectTypes.Add(Item);

      Query.Next;
    end;

    Query.Close;
    Result := ProjectTypes;
  finally
    Query.Free;
  end;
end;

procedure TfrmNewProject.UpdateLanguage;
begin
  frmNewProject.Caption := frmMainForm.Languages.NewProject;
  lblProjectName.Caption := frmMainForm.Languages.ProjectName;
  lblProjectDetails.Caption := frmMainForm.Languages.ProjectDetails;
  lblProjectType.Caption := frmMainForm.Languages.ProjectType;
  btnOK.Caption := frmMainForm.Languages.OK;
  btnCancel.Caption := frmMainForm.Languages.Cancel;
end;

end.
