unit unMainForm;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, Vcl.FormTabsBar, System.ImageList, System.Actions,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImageList,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.PlatformDefaultStyleActnCtrls,
  Language, System.UITypes;

type
  TfrmMainForm = class(TForm)
    mnuMenu: TMainMenu;
    tobToolBar: TToolBar;
    tobNewProject: TToolButton;
    vimlImageListToolBar: TVirtualImageList;
    imlImageCollection: TImageCollection;
    VirtualImageListMenu: TVirtualImageList;
    tobSeparator1: TToolButton;
    tobConfiguration: TToolButton;
    tobOpenProject: TToolButton;
    pnlStatus: TPanel;
    pnlValidateAccount: TPanel;
    lblValidateAccount: TLabel;
    tmrValidateAccount: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OpenNewProject(Sender: TObject);
    procedure OpenConfigurationDialog(Sender: TObject);
    procedure OpenOpenProject(Sender: TObject);
    procedure tmrValidateAccountTimer(Sender: TObject);
    procedure pnlValidateAccountClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConfigurateMenu;
  public
    Languages: TLabelLanguages;
    LanguageCode: string;
    ActionClients: TActionClients;
    ValidatedMail: boolean;
    procedure UpdateLanguage;
    procedure CloseMainForm(Sender: TObject);
    procedure OpenAboutDialog(Sender: TObject);
    procedure UpdateStatusValidateAccount(Valid: boolean);
    { Public declarations }
  end;

var
  frmMainForm: TfrmMainForm;

implementation

{$R *.dfm}

uses
  Constants, unConfiguration, Utils, Config, unAbout, unNewProject,
  unOpenProject, unValidateAccount;

var
  MenuProject: TMenuItem;
  MenuProjectNewProject: TMenuItem;
  MenuProjectOpenProject: TMenuItem;
  MenuProjectSeparator: TMenuItem;
  MenuProjectExit: TMenuItem;
  MenuTools: TMenuItem;
  MenuToolsConfiguration: TMenuItem;
  MenuHelp: TMenuItem;
  MenuHelpAbout: TMenuItem;

procedure TfrmMainForm.CloseMainForm(Sender: TObject);
begin
  frmMainForm.Close;
end;

procedure TfrmMainForm.ConfigurateMenu;
begin
  MenuProject := TMenuItem.Create(mnuMenu);

  MenuProjectNewProject := TMenuItem.Create(MenuProject);
  MenuProjectNewProject.OnClick := OpenNewProject;
  MenuProjectNewProject.ShortCut := ShortCut(Ord('N'), [ssCtrl]);
  MenuProjectNewProject.ImageIndex := 0;
  MenuProject.Add(MenuProjectNewProject);

  MenuProjectOpenProject := TMenuItem.Create(MenuProject);
  MenuProjectOpenProject.OnClick := OpenOpenProject;
  MenuProjectOpenProject.ShortCut := ShortCut(Ord('O'), [ssCtrl]);
  MenuProjectOpenProject.ImageIndex := 2;
  MenuProject.Add(MenuProjectOpenProject);

  MenuProjectSeparator := TMenuItem.Create(MenuProject);
  MenuProjectSeparator.Caption := SEPARATOR_MENU;
  MenuProject.Add(MenuProjectSeparator);


  MenuProjectExit := TMenuItem.Create(MenuProject);
  MenuProjectExit.OnClick := CloseMainForm;
  MenuProjectExit.ShortCut := ShortCut(Ord('X'), [ssCtrl]);
  MenuProject.Add(MenuProjectExit);

  MenuTools := TMenuItem.Create(mnuMenu);

  MenuToolsConfiguration := TMenuItem.Create(MenuTools);
  MenuToolsConfiguration.OnClick := OpenConfigurationDialog;
  MenuToolsConfiguration.ImageIndex := 1;
  MenuTools.Add(MenuToolsConfiguration);

  MenuHelp := TMenuItem.Create(mnuMenu);

  MenuHelpAbout := TMenuItem.Create(MenuHelp);
  MenuHelpAbout.OnClick := OpenAboutDialog;
  MenuHelp.Add(MenuHelpAbout);

  mnuMenu.Items.Clear;
  mnuMenu.Items.Add(MenuProject);
  mnuMenu.Items.Add(MenuTools);
  mnuMenu.Items.Add(MenuHelp);
end;

procedure TfrmMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg(Languages.MessageExit, mtConfirmation, mbYesNo, 0) = mrYes then
    Application.Terminate
  else
    Action := TCloseAction.caNone;
end;

procedure TfrmMainForm.FormCreate(Sender: TObject);
begin
  LoadConfiguration;
  Languages := BuildLanguageLabels(CustomConfig.Language);
  LanguageCode := CustomConfig.Language;
  LoadAvailableLanguages;
  ConfigurateMenu;
  UpdateLanguage;
  SaveConfiguration;
end;

procedure TfrmMainForm.OpenAboutDialog(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMainForm.OpenConfigurationDialog(Sender: TObject);
begin
  frmConfiguration.ShowModal;
end;

procedure TfrmMainForm.OpenNewProject(Sender: TObject);
begin
  frmNewProject.ShowModal;
end;

procedure TfrmMainForm.OpenOpenProject(Sender: TObject);
begin
  frmOpenProject.ShowModal;
end;

procedure TfrmMainForm.pnlValidateAccountClick(Sender: TObject);
begin
  if not ValidatedMail then
  begin  
    frmValidateAccount.ShowModal;
  end;
end;

procedure TfrmMainForm.tmrValidateAccountTimer(Sender: TObject);
begin
  lblValidateAccount.Visible := not lblValidateAccount.Visible;
end;

procedure TfrmMainForm.UpdateLanguage;
begin
  MenuProject.Caption := Languages.Project;
  MenuProjectNewProject.Caption := Format('%s...', [Languages.NewProject]);
  MenuProjectOpenProject.Caption := Format('%s...', [Languages.OpenProject]);
  MenuProjectExit.Caption := Languages.Exit;
  MenuTools.Caption := Languages.Tools;
  MenuToolsConfiguration.Caption := Format('%s...', [Languages.Configurations]);
  MenuHelp.Caption := Languages.Help;
  MenuHelpAbout.Caption := Format('%s...', [Languages.About]);

  tobNewProject.Hint := Languages.NewProject;
  tobOpenProject.Hint := Languages.OpenProject;
  tobConfiguration.Hint := Languages.Configurations;

  frmConfiguration.Caption := Languages.Configurations;
  frmMainForm.Caption := Format('%s - %s', [APPLICATION_NAME, CustomConfig.Version]);
end;

procedure TfrmMainForm.UpdateStatusValidateAccount(Valid: boolean);
begin
  if Valid then
  begin
    lblValidateAccount.Caption := Languages.ValidateAccountValid;
    lblValidateAccount.Font.Color := clGreen;
    pnlValidateAccount.Cursor := crDefault;
    tmrValidateAccount.Enabled := False;
    lblValidateAccount.Visible := True;
  end
  else 
  begin    
    lblValidateAccount.Caption := Languages.ClickToValidate;
    lblValidateAccount.Font.Color := clRed;
    pnlValidateAccount.Cursor := crHandPoint;
    tmrValidateAccount.Enabled := True;  
  end;
end;

end.
