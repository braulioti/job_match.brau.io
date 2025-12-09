unit Utils;


interface

uses
  System.Net.HttpClient, System.Classes, System.Net.HttpClientComponent,
  System.SysUtils;

procedure DownloadFile(const URL, Destino: string);
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


end.
