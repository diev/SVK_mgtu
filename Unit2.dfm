object Form2: TForm2
  Left = 338
  Top = 197
  BorderStyle = bsDialog
  Caption = 'Info'
  ClientHeight = 302
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBEdit1: TDBEdit
    Left = 8
    Top = 272
    Width = 57
    Height = 21
    DataField = 'id'
    DataSource = Form1.DataSource1
    Enabled = False
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 328
    Top = 136
    Width = 313
    Height = 129
    Caption = #1050#1074#1080#1090#1072#1085#1094#1080#1103' 3'
    TabOrder = 1
    object DBText5: TDBText
      Left = 80
      Top = 48
      Width = 201
      Height = 17
      DataField = 'kvit3_file'
      DataSource = Form1.DataSource1
    end
    object DBText10: TDBText
      Left = 80
      Top = 96
      Width = 201
      Height = 17
      DataField = 'kvit3_tk'
      DataSource = Form1.DataSource1
    end
    object DBText13: TDBText
      Left = 80
      Top = 24
      Width = 201
      Height = 17
      DataField = 'kvit3_data'
      DataSource = Form1.DataSource1
    end
    object DBText16: TDBText
      Left = 80
      Top = 72
      Width = 201
      Height = 17
      DataField = 'kvit3_svod_arj'
      DataSource = Form1.DataSource1
    end
    object Label9: TLabel
      Left = 8
      Top = 24
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object Label10: TLabel
      Left = 8
      Top = 48
      Width = 29
      Height = 13
      Caption = #1060#1072#1081#1083
    end
    object Label11: TLabel
      Left = 8
      Top = 72
      Width = 45
      Height = 13
      Caption = #1057#1074'.'#1072#1088#1093#1080#1074
    end
    object Label12: TLabel
      Left = 8
      Top = 96
      Width = 57
      Height = 13
      Caption = #1058#1088'.'#1082#1086#1085#1074#1077#1088#1090
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 136
    Width = 313
    Height = 129
    Caption = #1050#1074#1080#1090#1072#1085#1094#1080#1103' 2'
    TabOrder = 2
    object DBText4: TDBText
      Left = 72
      Top = 48
      Width = 201
      Height = 17
      DataField = 'kvit2_file'
      DataSource = Form1.DataSource1
    end
    object DBText9: TDBText
      Left = 72
      Top = 96
      Width = 201
      Height = 17
      DataField = 'kvit2_tk'
      DataSource = Form1.DataSource1
    end
    object DBText12: TDBText
      Left = 72
      Top = 24
      Width = 201
      Height = 17
      DataField = 'kvit2_data'
      DataSource = Form1.DataSource1
    end
    object DBText15: TDBText
      Left = 72
      Top = 72
      Width = 201
      Height = 17
      DataField = 'kvit2_svod_arj'
      DataSource = Form1.DataSource1
    end
    object Label13: TLabel
      Left = 8
      Top = 24
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object Label14: TLabel
      Left = 8
      Top = 48
      Width = 29
      Height = 13
      Caption = #1060#1072#1081#1083
    end
    object Label15: TLabel
      Left = 8
      Top = 72
      Width = 45
      Height = 13
      Caption = #1057#1074'.'#1072#1088#1093#1080#1074
    end
    object Label16: TLabel
      Left = 8
      Top = 96
      Width = 57
      Height = 13
      Caption = #1058#1088'.'#1082#1086#1085#1074#1077#1088#1090
    end
  end
  object GroupBox3: TGroupBox
    Left = 328
    Top = 8
    Width = 313
    Height = 129
    Caption = #1050#1074#1080#1090#1072#1085#1094#1080#1103' 1'
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object Label6: TLabel
      Left = 8
      Top = 48
      Width = 29
      Height = 13
      Caption = #1060#1072#1081#1083
    end
    object Label7: TLabel
      Left = 8
      Top = 72
      Width = 45
      Height = 13
      Caption = #1057#1074'.'#1072#1088#1093#1080#1074
    end
    object Label8: TLabel
      Left = 8
      Top = 96
      Width = 57
      Height = 13
      Caption = #1058#1088'.'#1082#1086#1085#1074#1077#1088#1090
    end
    object DBText3: TDBText
      Left = 96
      Top = 48
      Width = 201
      Height = 17
      DataField = 'kvit1_file'
      DataSource = Form1.DataSource1
    end
    object DBText8: TDBText
      Left = 96
      Top = 96
      Width = 201
      Height = 17
      DataField = 'kvit1_tk'
      DataSource = Form1.DataSource1
    end
    object DBText11: TDBText
      Left = 96
      Top = 24
      Width = 201
      Height = 17
      DataField = 'kvit1_data'
      DataSource = Form1.DataSource1
    end
    object DBText14: TDBText
      Left = 96
      Top = 72
      Width = 201
      Height = 17
      DataField = 'kvit1_svod_arj'
      DataSource = Form1.DataSource1
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 8
    Width = 313
    Height = 129
    Caption = #1060#1072#1081#1083
    TabOrder = 4
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object Label3: TLabel
      Left = 8
      Top = 48
      Width = 29
      Height = 13
      Caption = #1060#1072#1081#1083
    end
    object Label4: TLabel
      Left = 8
      Top = 72
      Width = 45
      Height = 13
      Caption = #1057#1074'.'#1072#1088#1093#1080#1074
    end
    object Label5: TLabel
      Left = 8
      Top = 96
      Width = 57
      Height = 13
      Caption = #1058#1088'.'#1082#1086#1085#1074#1077#1088#1090
    end
    object DBText1: TDBText
      Left = 72
      Top = 48
      Width = 201
      Height = 17
      DataField = 'file_name'
      DataSource = Form1.DataSource1
    end
    object DBText2: TDBText
      Left = 72
      Top = 24
      Width = 201
      Height = 17
      DataField = 'data'
      DataSource = Form1.DataSource1
    end
    object DBText6: TDBText
      Left = 72
      Top = 72
      Width = 201
      Height = 17
      DataField = 'svod_arj'
      DataSource = Form1.DataSource1
    end
    object DBText7: TDBText
      Left = 72
      Top = 96
      Width = 65
      Height = 17
      DataField = 'tk'
      DataSource = Form1.DataSource1
    end
  end
  object Button1: TButton
    Left = 280
    Top = 272
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 5
  end
end
