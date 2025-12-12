unit Utils;


interface

uses
  System.Net.HttpClient, System.Classes, System.Net.HttpClientComponent,
  System.SysUtils, Vcl.StdCtrls;

procedure DownloadFile(const URL, Destino: string);
procedure CreateFolderInApplicationPath(FolderName: string);
procedure ChangeAndRefreshLabel(LabelComponent: TLabel; NewCaption: string);
function ExePath: string;

implementation

procedure DownloadFile(const URL, Destino: string);
var
  HTTP: TNetHTTPClient;
  FileStream: TFileStream;
begin
  HTTP := TNetHTTPClient.Create(nil);
  try
    FileStream := TFileStream.Create(Destino, fmCreate);
    try
      HTTP.Get(URL, FileStream);
    finally
      FileStream.Free;
    end;
  finally
    HTTP.Free;
  end;
end;

function ExePath: string;
begin
  ExePath := ExtractFilePath(ParamStr(0));
end;

procedure CreateFolderInApplicationPath(FolderName: string);
var
  Folder: string;
begin
  Folder := Format('%s%s', [ExePath, FolderName]);

  if not DirectoryExists(Folder) then
    ForceDirectories(Folder);
end;

procedure ChangeAndRefreshLabel(LabelComponent: TLabel; NewCaption: string);
begin
  LabelComponent.Caption := NewCaption;
  LabelComponent.Repaint;
  LabelComponent.Refresh;
end;


end.
