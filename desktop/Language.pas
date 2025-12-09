unit Language;

interface

type
  TLabelLanguages = record
    Version: string;
  end;

function BuildLanguageLabels: TLabelLanguages;

implementation

function BuildLanguageLabels: TLabelLanguages;
var
  Aux: TLabelLanguages;
begin
  Aux.Version := 'Version';

  BuildLanguageLabels := Aux;
end;

end.
