unit unConfiguration;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmConfiguration = class(TForm)
    lblSelectLanguage: TLabel;
    cboSelectLanguage: TComboBox;
    btnClose: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure cboSelectLanguageChange(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLanguage;
  public
    { Public declarations }
  end;

var
  frmConfiguration: TfrmConfiguration;

implementation

{$R *.dfm}

uses unMainForm, Language, Config;


procedure TfrmConfiguration.cboSelectLanguageChange(Sender: TObject);
var
  I: Integer;
begin
  try
    Cursor := crHourGlass;
    for I := 0 to AvailableLanguages.Count - 1 do
      if cboSelectLanguage.Items.Strings[cboSelectLanguage.ItemIndex] =
         AvailableLanguages.Items[I].Language then
      begin
        CustomConfig.Language := AvailableLanguages.Items[I].Code;
        SaveConfiguration;
        frmMainForm.Languages := BuildLanguageLabels(CustomConfig.Language);
        frmMainForm.LanguageCode := CustomConfig.Language;
        frmMainForm.UpdateLanguage;
        UpdateLanguage;
        Break;
      end;
  finally
    Cursor := crDefault;
  end;
end;

procedure TfrmConfiguration.FormActivate(Sender: TObject);
var
  I: Integer;
  SelectedLanguage: String;
begin
  cboSelectLanguage.Text := EmptyStr;
  cboSelectLanguage.Items.Clear;
  for I := 0 to AvailableLanguages.Count - 1 do
  begin
    cboSelectLanguage.items.Add(AvailableLanguages.Items[I].Language);
    if CustomConfig.Language = AvailableLanguages.Items[I].Code then
      SelectedLanguage := AvailableLanguages.Items[I].Language;
  end;

  for I := 0 to cboSelectLanguage.Items.Count - 1 do
    if cboSelectLanguage.Items.Strings[I] = SelectedLanguage then
      cboSelectLanguage.ItemIndex := I;

  UpdateLanguage;
end;

procedure TfrmConfiguration.UpdateLanguage;
begin
  lblSelectLanguage.Caption := frmMainForm.Languages.SelectLanguage;
  btnClose.Caption := frmMainForm.Languages.Close;
end;

end.
