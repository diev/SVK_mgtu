object Form1: TForm1
  Left = 186
  Top = 178
  Width = 945
  Height = 443
  Caption = #1074#1077#1088#1089#1080#1103' '#1076#1083#1103' '#1084#1075#1090#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 744
    Top = 0
    Width = 185
    Height = 386
    Align = alRight
    Caption = #1044#1077#1081#1089#1090#1074#1080#1103
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 328
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Button2: TButton
      Left = 16
      Top = 24
      Width = 129
      Height = 25
      Caption = #1054#1090#1095#1077#1090#1085#1086#1089#1090#1100' KLIKO'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 16
      Top = 56
      Width = 129
      Height = 25
      Caption = #1055#1072#1089#1087#1086#1088#1090#1072' '#1060#1058#1057' 364-'#1055
      TabOrder = 1
      WordWrap = True
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 16
      Top = 88
      Width = 129
      Height = 25
      Caption = #1050#1074#1080#1090#1072#1085#1094#1080#1080' '#1060#1058#1057' 406-'#1060#1047
      Enabled = False
      TabOrder = 2
    end
    object Button7: TButton
      Left = 16
      Top = 120
      Width = 129
      Height = 25
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103' '#1060#1053#1057' 311-'#1055
      TabOrder = 3
      OnClick = Button7Click
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 304
      Width = 97
      Height = 17
      Caption = #1051#1086#1075#1080
      TabOrder = 4
    end
    object Button1: TButton
      Left = 16
      Top = 184
      Width = 129
      Height = 25
      Caption = #1060#1053#1057' 365-'#1087' '#1086#1090#1074#1077#1090
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button8: TButton
      Left = 16
      Top = 152
      Width = 129
      Height = 25
      Caption = #1060#1053#1057' 365-'#1087' '#1082#1074#1080#1090#1072#1085#1094#1080#1080
      TabOrder = 6
      OnClick = Button8Click
    end
    object Button10: TButton
      Left = 32
      Top = 232
      Width = 75
      Height = 25
      Caption = 'Button10'
      TabOrder = 7
      OnClick = Button10Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 386
    Width = 929
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 744
    Height = 386
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #1046#1091#1088#1085#1072#1083
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 736
        Height = 358
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1050#1083#1102#1095#1077#1074#1072#1103' '#1087#1086#1076#1089#1080#1089#1090#1077#1084#1072
      ImageIndex = 1
      object Button9: TButton
        Left = 16
        Top = 32
        Width = 75
        Height = 25
        Caption = 'asrkeyw'
        TabOrder = 0
        OnClick = Button9Click
      end
      object Button3: TButton
        Left = 14
        Top = 64
        Width = 131
        Height = 25
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1082#1083#1102#1095#1080
        TabOrder = 1
        OnClick = Button3Click
      end
      object ListBox2: TListBox
        Left = 0
        Top = 168
        Width = 737
        Height = 177
        ItemHeight = 13
        TabOrder = 2
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 640
    Top = 128
  end
end
