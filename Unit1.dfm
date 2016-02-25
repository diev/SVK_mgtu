object Form1: TForm1
  Left = 249
  Top = 174
  Width = 945
  Height = 443
  Caption = #1074#1077#1088#1089#1080#1103' '#1076#1083#1103' '#1084#1075#1090#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 366
    Width = 929
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 929
    Height = 366
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1046#1091#1088#1085#1072#1083
      object SGIN: TStringGrid
        Left = 0
        Top = 0
        Width = 921
        Height = 338
        Align = alClient
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 50
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        ColWidths = (
          64
          64
          424
          117
          64)
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1055#1083#1072#1085#1080#1088#1086#1074#1097#1080#1082
      ImageIndex = 1
      object SGIN2: TStringGrid
        Left = 0
        Top = 0
        Width = 921
        Height = 338
        Align = alClient
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 50
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        ColWidths = (
          140
          43
          167
          117
          64)
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      ImageIndex = 2
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 921
        Height = 338
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Caption = #1087'/'#1087
            Title.Font.Charset = RUSSIAN_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Verdana'
            Title.Font.Style = []
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data'
            Title.Caption = #1076#1072#1090#1072
            Title.Font.Charset = RUSSIAN_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Verdana'
            Title.Font.Style = []
            Width = 105
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'file_name'
            Title.Caption = #1080#1084#1103' '#1092#1072#1081#1083#1072
            Title.Font.Charset = RUSSIAN_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Verdana'
            Title.Font.Style = []
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'kvit1_file'
            Title.Caption = #1050#1074#1080#1090#1072#1085#1094#1080#1103' '#8470'1'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'kvit2_file'
            Title.Caption = #1050#1074#1080#1090#1072#1085#1094#1080#1103' '#8470'2'
            Title.Font.Charset = RUSSIAN_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Verdana'
            Title.Font.Style = []
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'kvit3_file'
            Title.Caption = #1050#1074#1080#1090#1072#1085#1094#1080#1103' '#8470'3'
            Title.Font.Charset = RUSSIAN_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Verdana'
            Title.Font.Style = []
            Width = 200
            Visible = True
          end>
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 640
    Top = 8
  end
  object MainMenu1: TMainMenu
    Left = 672
    Top = 8
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N7: TMenuItem
        Caption = #1042#1099#1093#1086#1076
      end
    end
    object N5: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      object KLIKO1: TMenuItem
        Caption = #1054#1090#1095#1077#1090#1085#1086#1089#1090#1100' KLIKO'
        OnClick = Button2Click
      end
      object N364P1: TMenuItem
        Caption = '364'#1055' '#1060#1058#1057
        OnClick = Button4Click
      end
      object N3111: TMenuItem
        Caption = '311'#1055' '#1060#1053#1057
        OnClick = Button7Click
      end
      object N3651: TMenuItem
        Caption = '365'#1055' '#1082#1074#1080#1090#1072#1085#1094#1080#1080
        OnClick = Button8Click
      end
      object N3652: TMenuItem
        Caption = '365'#1055' '#1086#1090#1074#1077#1090
        OnClick = Button1Click
      end
      object N1231: TMenuItem
        Caption = '123'
        OnClick = N1231Click
      end
    end
    object N2: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      object N4: TMenuItem
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1082#1083#1102#1095#1080
        OnClick = Button3Click
      end
      object asrkeyw1: TMenuItem
        Caption = 'asrkeyw'
        OnClick = Button9Click
      end
    end
    object N3: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N6: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=d:\Verba\SVK_mgtu\' +
      'base.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 540
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 608
    Top = 8
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from docs')
    Left = 572
    Top = 8
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'f'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    SQL.Strings = (
      'select * from docs')
    Left = 572
    Top = 40
  end
end
