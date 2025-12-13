object frmConfiguration: TfrmConfiguration
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 158
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object lblSelectLanguage: TLabel
    Left = 16
    Top = 24
    Width = 86
    Height = 15
    Caption = 'Select Language'
  end
  object cboSelectLanguage: TComboBox
    Left = 16
    Top = 45
    Width = 345
    Height = 23
    Sorted = True
    TabOrder = 0
    Text = 'cboSelectLanguage'
    OnChange = cboSelectLanguageChange
  end
  object btnClose: TBitBtn
    Left = 146
    Top = 96
    Width = 89
    Height = 33
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 1
  end
end
