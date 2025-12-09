unit unUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.IniFiles;

type
  TfrmUpdate = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

{$R *.dfm}

uses
  Utils, Constants;

procedure TfrmUpdate.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(Format('%s%s', [ExePath + CONFIG_FILE]));
  DownloadFile('https://github.com/braulioti/job_match.brau.io/raw/refs/heads/feature/create-the-desktop-update-tool/docs/version_info.ini', 'version.ini')
end;

end.
