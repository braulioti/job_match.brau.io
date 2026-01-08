unit unProjectClass;

interface

type
  TProject = class
  public
    Id: Integer;
    Name: string;
    ProjectType: string;
    Description: string;
  end;

type
  TProjectType = class
  public
    Id: Integer;
    Code: string;
    Translation: string;
  end;

implementation

end.
