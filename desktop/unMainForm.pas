unit unMainForm;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, Vcl.FormTabsBar, System.ImageList, System.Actions,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImageList,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.PlatformDefaultStyleActnCtrls,
  Language;

type
  TfrmMainForm = class(TForm)
    stbStatusBar: TStatusBar;
    mnuMenu: TMainMenu;
    procedure FileNew1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure WindowCascade1Execute(Sender: TObject);
    procedure WindowTileHorizontal1Execute(Sender: TObject);
    procedure WindowTileVertical1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
    procedure UpdateLanguage;
    procedure ConfigurateMenu;
  public
    Languages: TLabelLanguages;
    ActionClients: TActionClients;
    procedure CloseMainForm(Sender: TObject);
    procedure OpenConfigurationDialog(Sender: TObject);
    { Public declarations }
  end;

var
  frmMainForm: TfrmMainForm;

implementation

{$R *.dfm}

uses CHILDWIN, About, Constants, unConfiguration;
var
  MenuProject: TMenuItem;
  MenuProjectExit: TMenuItem;
  MenuTools: TMenuItem;
  MenuToolsConfiguration: TMenuItem;

procedure TfrmMainForm.CloseMainForm(Sender: TObject);
begin
  frmMainForm.Close;
end;

procedure TfrmMainForm.ConfigurateMenu;
begin
  MenuProject := TMenuItem.Create(mnuMenu);

  MenuProjectExit := TMenuItem.Create(MenuProject);
  MenuProjectExit.OnClick := CloseMainForm;
  MenuProject.Add(MenuProjectExit);

  MenuTools := TMenuItem.Create(mnuMenu);

  MenuToolsConfiguration := TMenuItem.Create(MenuTools);
  MenuToolsConfiguration.OnClick := OpenConfigurationDialog;
  MenuTools.Add(MenuToolsConfiguration);

  mnuMenu.Items.Clear;
  mnuMenu.Items.Add(MenuProject);
  mnuMenu.Items.Add(MenuTools);

end;

procedure TfrmMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
  if FileExists(Name) then Child.Memo1.Lines.LoadFromFile(Name);
end;

procedure TfrmMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild('NONAME' + IntToStr(MDIChildCount + 1));
end;

procedure TfrmMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg(Languages.MessageExit, mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    Application.Terminate;
  end
  else
  begin
    Action := TCloseAction.caNone;
  end;
end;

procedure TfrmMainForm.FormCreate(Sender: TObject);
begin
  Languages := BuildLanguageLabels(DEFAULT_LANGUAGE);
  ConfigurateMenu;
  UpdateLanguage;
end;

procedure TfrmMainForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TfrmMainForm.OpenConfigurationDialog(Sender: TObject);
begin
  frmConfiguration.ShowModal;
end;

procedure TfrmMainForm.UpdateLanguage;
var
  MenuItems: TActionClients;
  I: Integer;
begin
  MenuProject.Caption := Languages.Project;
  MenuProjectExit.Caption := Languages.Exit;
  MenuTools.Caption := Languages.Tools;
  MenuToolsConfiguration.Caption := Format('%s...', [Languages.Configuration]);

  frmConfiguration.Caption := Languages.Configuration;
end;

procedure TfrmMainForm.WindowCascade1Execute(Sender: TObject);
begin
  Cascade;
end;

procedure TfrmMainForm.WindowTileHorizontal1Execute(Sender: TObject);
begin
  TileMode := tbHorizontal;
  Tile;
end;

procedure TfrmMainForm.WindowTileVertical1Execute(Sender: TObject);
begin
  TileMode := tbVertical;
  Tile;
end;

procedure TfrmMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

end.
