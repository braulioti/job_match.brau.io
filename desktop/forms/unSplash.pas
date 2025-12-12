unit unSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TfrmSplash = class(TForm)
    imgLogo: TImage;
    pgbProgress: TProgressBar;
    lblProgressStatus: TLabel;
    lblVersion: TLabel;
    lblAboutDetails: TLabel;
    lblAuthor: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

end.
