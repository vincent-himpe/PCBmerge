object PCBmerge: TPCBmerge
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'PCB Merge V2.0 '
  ClientHeight = 342
  ClientWidth = 600
  Color = clWindowFrame
  Constraints.MinHeight = 200
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindow
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  FormKind = fkNormal
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 568
    Top = 328
    Width = 30
    Height = 13
    Alignment = taRightJustify
    Caption = 'Ready'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 328
    Width = 18
    Height = 13
    Caption = '---'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
  end
  object lockpart: TCheckBox
    Left = 288
    Top = 144
    Width = 72
    Height = 24
    Caption = 'Lock All'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clActiveCaption
    Font.Height = 15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 144
    Height = 96
    ParentCustomHint = False
    BiDiMode = bdLeftToRight
    Caption = 'Components'
    Color = clWindowFrame
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentBiDiMode = False
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 6
    object Label4: TLabel
      Left = 30
      Top = 40
      Width = 95
      Height = 13
      Caption = 'Retain Target Locks'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 30
      Top = 56
      Width = 91
      Height = 13
      Caption = 'Force Target Locks'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 30
      Top = 72
      Width = 45
      Height = 13
      Caption = 'Unlock All'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 30
      Top = 24
      Width = 90
      Height = 13
      Caption = 'Copy Source Locks'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 6
      Top = 0
      Width = 60
      Height = 13
      Caption = 'Components'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object RadioButton1: TRadioButton
      Left = 8
      Top = 24
      Width = 16
      Height = 16
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = 'tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 40
      Width = 16
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = 'tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object RadioButton3: TRadioButton
      Left = 8
      Top = 56
      Width = 16
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = 'tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object RadioButton4: TRadioButton
      Left = 8
      Top = 72
      Width = 16
      Height = 16
      Caption = ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = 'tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object Endrun: TButton
    Left = 520
    Top = 80
    Width = 72
    Height = 24
    Caption = 'Exit'
    TabOrder = 1
    OnClick = EndrunClick
  end
  object GetComponents: TButton
    Left = 520
    Top = 8
    Width = 72
    Height = 24
    Caption = 'Get'
    TabOrder = 2
    OnClick = GetComponentsClick
  end
  object SetComponents: TButton
    Left = 520
    Top = 40
    Width = 72
    Height = 24
    Caption = 'Restore'
    TabOrder = 3
    OnClick = SetComponentsClick
  end
  object Button1: TButton
    Left = 392
    Top = 144
    Width = 72
    Height = 24
    Caption = 'Button1'
    TabOrder = 4
    Visible = False
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 112
    Width = 600
    Height = 208
    Color = clWindowFrame
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Note:'
      'For the selection of "Copy locked objects" to work, the option '
      '"Protect locked objects" must be turned OFF'
      'in the preferences !')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    OnClick = Memo1Click
    OnKeyUp = Memo1KeyDown
  end
  object GroupBox2: TGroupBox
    Left = 160
    Top = 8
    Width = 152
    Height = 96
    Caption = 'Designators'
    TabOrder = 7
    object Label3: TLabel
      Left = 6
      Top = 0
      Width = 57
      Height = 13
      Caption = 'Designators'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 38
      Top = 24
      Width = 37
      Height = 13
      Caption = 'Position'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 38
      Top = 40
      Width = 71
      Height = 13
      Caption = 'Size and Width'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 40
      Width = 16
      Height = 16
      Caption = 'Size and width'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 24
      Width = 16
      Height = 16
      Caption = 'Position'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 320
    Top = 8
    Width = 152
    Height = 96
    Caption = 'Mode'
    TabOrder = 8
    object Label11: TLabel
      Left = 38
      Top = 40
      Width = 57
      Height = 13
      Caption = 'Designators'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 38
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Components'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 6
      Top = 0
      Width = 26
      Height = 13
      Caption = 'Mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 24
      Width = 16
      Height = 16
      Caption = 'Components'
      TabOrder = 0
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 40
      Width = 16
      Height = 16
      Caption = 'Designators'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
end
