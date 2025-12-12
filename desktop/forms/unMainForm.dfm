object frmMainForm: TfrmMainForm
  Left = 194
  Top = 111
  Caption = 'Job Match'
  ClientHeight = 395
  ClientWidth = 475
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mnuMenu
  Position = poDefault
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object stbStatusBar: TStatusBar
    Left = 0
    Top = 376
    Width = 475
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoHint = True
    Panels = <>
    SimplePanel = True
  end
  object mnuMenu: TMainMenu
    Left = 8
    Top = 8
  end
end
