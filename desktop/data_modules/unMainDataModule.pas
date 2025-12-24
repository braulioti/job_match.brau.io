unit unMainDataModule;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdtmMainDataModule = class(TDataModule)
    restClient: TRESTClient;
    restRequest: TRESTRequest;
    restResponse: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmMainDataModule: TdtmMainDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
