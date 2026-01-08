object frmOpenProject: TfrmOpenProject
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Open Project'
  ClientHeight = 339
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 15
  object lblSelectProject: TLabel
    Left = 25
    Top = 24
    Width = 71
    Height = 15
    Caption = 'Select Project'
  end
  object lblProjectDetails: TLabel
    Left = 25
    Top = 90
    Width = 75
    Height = 15
    Caption = 'Project Details'
  end
  object lblProjectType: TLabel
    Left = 25
    Top = 218
    Width = 65
    Height = 15
    Caption = 'Project Type'
  end
  object mmoProjectDetails: TMemo
    Left = 25
    Top = 111
    Width = 321
    Height = 89
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object btnOK: TBitBtn
    Left = 86
    Top = 288
    Width = 89
    Height = 33
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 198
    Top = 288
    Width = 89
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object cboSelectProject: TComboBox
    Left = 25
    Top = 45
    Width = 321
    Height = 23
    Sorted = True
    TabOrder = 0
    OnChange = cboSelectProjectChange
  end
  object edtProjectType: TEdit
    Left = 25
    Top = 239
    Width = 321
    Height = 23
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
end
