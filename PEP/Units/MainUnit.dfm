object frmMain: TfrmMain
  Left = 201
  Top = 139
  CustomHint = blnhnt1
  AlphaBlendValue = 250
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Private exe Protector'
  ClientHeight = 421
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  GlassFrame.Left = 2
  GlassFrame.Top = 2
  GlassFrame.Right = 2
  GlassFrame.Bottom = 2
  KeyPreview = True
  Menu = mainMnu
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object eProjectName: TStatusBar
    Left = 0
    Top = 402
    Width = 574
    Height = 19
    CustomHint = blnhnt1
    Panels = <
      item
        Width = 435
      end
      item
        Alignment = taRightJustify
        Text = 'Engine version'
        Width = 75
      end>
    SizeGrip = False
  end
  object panelMenu: TCategoryButtons
    AlignWithMargins = True
    Left = 3
    Top = 28
    Width = 160
    Height = 371
    Margins.Right = 0
    CustomHint = blnhnt1
    Align = alLeft
    BackgroundGradientColor = clBtnFace
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ButtonFlow = cbfVertical
    ButtonHeight = 59
    ButtonWidth = 130
    ButtonOptions = [boFullSize, boGradientFill, boShowCaptions]
    Categories = <
      item
        Caption = 'Menu'
        Color = 16771818
        Collapsed = False
        Items = <
          item
            Caption = 'Application info'
            ImageIndex = 0
            OnClick = btnAppInfo2Click
          end
          item
            Caption = 'Protection options'
            ImageIndex = 1
            OnClick = btnOptionsClick
          end
          item
            Caption = 'Licensing'
            ImageIndex = 3
            OnClick = btnLicClick
          end
          item
            Caption = 'Configure dialogs'
            ImageIndex = 2
            OnClick = btnDialogsClick
          end>
      end>
    HotButtonColor = 15855072
    Images = immButtons
    RegularButtonColor = clWhite
    SelectedButtonColor = 15790320
    TabOrder = 1
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 166
    Top = 28
    Width = 405
    Height = 371
    CustomHint = blnhnt1
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object Pages: TPageControl
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 405
      Height = 365
      Margins.Left = 0
      Margins.Right = 0
      CustomHint = blnhnt1
      ActivePage = shNag
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      HotTrack = True
      ParentFont = False
      TabOrder = 0
      object shGeneral: TTabSheet
        CustomHint = blnhnt1
        Caption = 'App'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblInputFile: TLabel
          Left = 8
          Top = 6
          Width = 72
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Input file name:'
        end
        object lblAppNameVer: TLabel
          Left = 8
          Top = 48
          Width = 85
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Application name:'
        end
        object lblHomePage: TLabel
          Left = 8
          Top = 88
          Width = 57
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Home page:'
        end
        object lblResult: TLabel
          Left = 8
          Top = 133
          Width = 33
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Result:'
        end
        object lblVersion: TLabel
          Left = 198
          Top = 48
          Width = 95
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Application version:'
        end
        object btnReadVersion: TSpeedButton
          Left = 366
          Top = 60
          Width = 23
          Height = 23
          Cursor = crHandPoint
          CustomHint = blnhnt1
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E5
            E5A6A6A6B1B1B1F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFF6F6F6888888C4C4C47E7E7ED6D6D6FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0A0A0B0B1
            B17D7D7D898A8AE4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFCBCBCB999A9A868686878888CCCDCDFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E59090908C8C8C8081
            81CCCDCDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDCA0A0A07B7776817B7A8F
            8A8AA8A8A88889898F8F8F797A7ACCCDCDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            DCDCDC6C6C6C848484BAB8BACFCECEB7B5B6939092807F80707070CCCDCDFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E5696969C4C0BCFEFCF8FEFCFAFFFCFAFF
            FCFBFBFAF8B1ACAD878687E2E1E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9B9B
            928C86FEF3E7FEF7EFFEF7EFFEF7F0FEF8F0FEF8F2FAF4EEA49F9FA9A7A8FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF5B5A59D4C4B2FCEFE0FCF2E5FCF2E6FCF3E6FC
            F3E7FEF3E7FEF3E9D3CAC5919091FFFFFFFFFFFFFFFFFFFFFFFFE5E5E5625E5B
            E1CAB0FCEAD5FCEDDCFCEEDCFCEEDDFCEEDDFCEEDEFCEEDDDED1C68C8A8BFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF5C5957CEB497FAE2C7FBE5CCFBE5CCFBE5CEFB
            E6CFFBE7D1FBEAD5D7C9BDA09FA0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF868686
            8C7B69FAE0C2FBE9D3FBE9D3FBE9D3FBE9D3FBE9D3F8E6D1AFA5A0BFBFBFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFD3D3D3655F5CB49E87FBE9D3FBE9D3FBE9D3FB
            E9D3F8E6D1C6B8AB868385F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            B9B9B96C686597897BCABAA6D9C9B4C9B8A6A3978E878383E5E5E5FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDCA0A0A07B7776817B7A8F
            8A8AA8A8A8EDEDEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnReadVersionClick
        end
        object btnSelectFN: TSpeedButton
          Left = 366
          Top = 19
          Width = 23
          Height = 23
          Cursor = crHandPoint
          CustomHint = blnhnt1
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000608CA02D6782
            2D67822D67822D67822D67822D67822D6782132D3C1E48631E48631F4157212F
            38284151FFFFFFFFFFFF3D7E9A51A3C651A3C651A3C651A3C651A3C651A3C651
            A3C61E4A623387B53387B52A546CE995662A4252FFFFFFFFFFFF41829F54A7CA
            54A7CA54A7CA54A7CA54A7CA54A7CA54A7CA527383BDBDBDBDBDBD2F637EE995
            662E4F65FFFFFFFFFFFF4687A357ACCE57ACCE57ACCE57ACCE57ACCE57ACCE57
            ACCE5D7F8FDCDCDCBDBDBD387290DCDCDC34586FFFFFFFFFFFFF4B8BA65AB1D1
            5AB1D15AB1D15AB1D15AB1D15AB1D15AB1D1637A80E2C2A7BDBDBD3C7593DCDC
            DC385F75FFFFFFFFFFFF5091AA5DB6D55DB6D55DB6D55DB6D55DB6D55DB6D55D
            B6D5658695E0E0E0BDBDBD3F7997DCDCDC3E667AFFFFFFFFFFFF5596AF60BBD9
            60BBD960BBD960BBD960BBD960BBD95DB6D5697F84E2C2A7BDBDBD427E9ADCDC
            DC446C80FFFFFFFFFFFF5A9CB264C1DD64C1DD64C1DD64C1DD64C1DD64C1DD64
            C1DD547B8E759FB2BDBDBD4992B54F839C557687FFFFFFFFFFFF5FA0B667C6E1
            67C6E167C6E167C6E167C6E167C6E167C6E16AB1CA5F899A7896A35BA3C55680
            92E9EDF0FFFFFFFFFFFF65A5BA6ACBE56ACBE56ACBE56ACBE56ACBE56ACBE56A
            CBE56ACBE569BBD177909A64A0BB568092FFFFFFFFFFFFFFFFFF6AABBF6DD0E9
            6DD0E96DD0E96DD0E96DD0E96DD0E96DD0E96DD0E96DD0E97A919C6EA7C25680
            92FFFFFFFFFFFFFFFFFF6EB0C270D5ED70D5ED70D5ED70D5ED70D5ED70D5ED70
            D5ED70D5ED70D5ED6E8A9678AFC7568092FFFFFFFFFFFFFFFFFF74B5C674DAF0
            74DAF074DAF074DAF074DAF074DAF074DAF074DAF074DAF0728B9781B6CE5680
            92FFFFFFFFFFFFFFFFFF79BACB77E0F677E0F677E0F677E0F677E0F677E0F677
            E0F677E0F677E0F6758E988ABCD3568092FFFFFFFFFFFFFFFFFF7FC0CF7AE5FA
            7AE5FA7AE5FA7AE5FA7AE5FA7AE5FA7AE5FA7AE5FA7AE5FA54778792C1D75680
            92FFFFFFFFFFFFFFFFFFA2D3DD84C5D384C5D384C5D384C5D384C5D384C5D384
            C5D384C5D384C5D36E89957BA8B6AABFC8FFFFFFFFFFFFFFFFFF}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSellAppClick
        end
        object lblPurchasePage: TLabel
          Left = 197
          Top = 88
          Width = 76
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Purchase page:'
        end
        object eAppName: TEdit
          Left = 8
          Top = 62
          Width = 163
          Height = 20
          CustomHint = blnhnt1
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 1
        end
        object bsSkinPanel1: TPanel
          Left = 0
          Top = 306
          Width = 397
          Height = 30
          Margins.Left = 1
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 5
          object btnProtect: TSpeedButton
            AlignWithMargins = True
            Left = 7
            Top = 3
            Width = 112
            Height = 24
            Margins.Left = 7
            CustomHint = blnhnt1
            Align = alLeft
            Caption = 'Protect now!'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000C8C8C8BCC1C5
              5695DB398AE03A86DF3982DD397FDC397BD93978D73977D73977D73977D73977
              D65884D2BFC1C5C8C8C8C8C8C86DA4DA3FBFEF42CAF040C6F03FC5F03FC5F03F
              C5F03FC5F03FC5F03FC5F03FC5F040C5F03BABE87394CFC8C8C8C8C8C85C9FDE
              47D4F12EB9EF29ABEE28A3ED279EEB279BEA2699E92699E92699E92699E929A0
              EA3FBBEC6189D1C8C8C8C8C8C85CA2DF4BDEF238CFF231C0F02EB5EE2BAAED29
              A2EB289EEA289CEA289CEA289CEA29A3EB3FBBEC6189D1C8C8C8C8C8C85CA4E0
              4EE4F33AD9F335CBF231C1F02DB6EE2AABED28A2EB279BEA2699E92699E9289F
              EA3FBBEC6189D1C8C8C8C8C8C85CA5E04DE4F33DE1F23ADAF239D6F337CDF133
              C2F02FB6ED2CABEB29A2EB289DEA29A2EB3FBBED6189D1C8C8C8C8C8C85CA5E1
              4AE0F33ADAF337D6F238D6F237D4F336CDF132C2F02FB6EE2BABEB28A1EA29A0
              EB3FBCED618AD1C8C8C8C8C8C85CA5E147DBF235D5F236D4F338D7F339DAF33A
              DBF23AD6F238CEF135C3EF30B7EC2FB2EC41C0ED618CD3C8C8C8C8C8C86EABDD
              40CAF247E2F34AE6F34DEBF34FEEF451F1F352F2F352F1F451EDF34EE6F24ADE
              F23EB6EB7399D3C8C8C8C8C8C8BCC2C659A2DE40A3ED3FA3EC3B9DE73C9EE83C
              9CE83C99E63C95E5398FDF3C90E23C8CE1578BCFBFC2C6C8C8C8C8C8C8C8C8C8
              B8B9BAE1DCDCDDD8D8B2B6BBC8C8C8C8C8C8C8C8C8C8C8C8A8ADB2CFCBCBCFCB
              CBADADAEC8C8C8C8C8C8C8C8C8C8C8C8BBB9B9E3DEDEE1DCDCBEBBBBC8C8C8C8
              C8C8C8C8C8C8C8C8B1AFAFD2CECECFCBCBB0AEAEC8C8C8C8C8C8C8C8C8C8C8C8
              BCBABADFDAD9F0EBEABDB8B8C6C6C6C8C8C8C8C8C8C5C5C5ABA7A7E6E0E0C8C4
              C4B4B3B3C8C8C8C8C8C8C8C8C8C8C8C8C5C5C5CDC7C7F9F3F3E5E1E0C3BEBEBB
              B6B6B7B3B3BAB5B5DDD9D9F0EAEAB0ABABC3C3C3C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C6C4C3D6D0D0F4EEEEFBF6F6FAF6F6F9F5F5F7F2F2EDE9E9C4C0C0B7B4
              B4C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C4C3C2C5C0C0C4BFBFC2
              BEBDBEBABABBB6B6B6B3B2BEBCBCC8C8C8C8C8C8C8C8C8C8C8C8}
            Spacing = 5
            OnClick = btnProtectClick
          end
          object btnRestore: TSpeedButton
            Left = 129
            Top = 3
            Width = 135
            Height = 24
            CustomHint = blnhnt1
            Caption = 'Restore from backup'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C7C1B6C6B79EC6B89FC6B89FC6B89FC6B89FC6B89FC6
              B89FC6B69BC8C5C0C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C3B295BE892C
              BE882BBE882BBE882BBE882BBE882BBF892DBD8C39C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C08B2DC28E32C28E33C28E32C28E33C28E32C0
              8B2FC8C5C0C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C6C2C8BAA2C8C8C8CA9E52
              C69339C69339C69339C69339C6933AC4A875C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C9C4BAC48D30C7C4BFC8C8C8CDB384CA9842C89740C9973FC89740C99840CA
              973EC9A96FC9C5BFC8C8C8C9C4BCCCAF7BCA963CCBA460C8C8C8C8C8C8CBC3B6
              CF9D45CF9E48CF9E48CF9E48CF9E48CF9E48CF9E4ACF9D43D19D41CF9D43CF9E
              49CF9C44CAC4B8C8C8C8C8C8C8C8C8C8D5A54ED2A451D3A247D2A34DD2A450D1
              A44FD3A44FD2A44FD3A44FD1A450D2A34ECFB68AC8C8C8C8C8C8C8C8C8C8C8C8
              D7B679D8A953CBC0ACCEC0A6D7AA57D8A854D6A958D6A958D6A957D8A74FD1B9
              8CC8C8C8C8C8C8C8C8C8C8C8C8C8C8C8D4C2A0D5B881C8C8C8C8C8C8C8C8C8CF
              C4B1D8BD8DDBBD84D7BE91CAC7C1C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8}
            Spacing = 3
            OnClick = btnRestoreClick
          end
          object btnTest: TSpeedButton
            AlignWithMargins = True
            Left = 274
            Top = 3
            Width = 112
            Height = 24
            Margins.Right = 11
            CustomHint = blnhnt1
            Align = alRight
            Caption = 'Run application !'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000C8C8C8C8C8C8
              C8C8C8C8C8C8C5C6C56DB26D49AC4D8BB88BC8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C86AB36A52D47A72F4A53C
              B74FB0BFB0C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C873B6724BCD6D74F09777F08D63E69258AD59C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C7C7C76FB76E4ACC6B6FEB9476EE8A77F08C72
              F19244C5619ABB9AC8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C6C7C667B766
              4BCE6F69E48B70E78573F19C74F39C72EF8865EA9444AD48C3C5C3C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C879BC794ACE6E61DA7F68DE7D68E8973FBA4E44C55D70
              F19468E9824DD2747BB67AC8C8C8C8C8C8C8C8C8C8C8C8C8C8C84AB94E5CD887
              5FD47362E39140B94BA7C1A765B56460E48E68E87D5FE6863BB64BB0BFB0C8C8
              C8C8C8C8C8C8C8C8C8C867BB674ED27555D88042B94AABC1ABC8C8C8B3C0B33E
              BC4E67EC8F5BDF6F53DC814FAE51C6C7C6C8C8C8C8C8C8C8C8C8C0C4C07EBE7E
              77BC76B6C3B6C8C8C8C8C8C8C8C8C877B97752D87B5BE07351D96A44CA687FB7
              7FC8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C2
              C5C246B44B5BE3894ED55F4DD9733AB74BA8BEA8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8A2BEA23EC25553DC7644CE554DD8
              7A43AF48BFC4BFC8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C875B97549D16F47D15F44CE5749D2745FB15FC8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C5C6C550B4524DD87A43CD
              5547D26241C66185B985C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8B7C2B740B6474DD97A42CC524EDA7948B14CC8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8A6BFA63CBA
              4A4FDB7E49D3745FB360C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
              C8C8C8C8C8C8C8C8C8C8C8C8C8C8A0BFA059B5596EB76DBDC4BD}
            Spacing = 5
            OnClick = btnTestClick
          end
        end
        object eResult: TMemo
          AlignWithMargins = True
          Left = 8
          Top = 150
          Width = 377
          Height = 155
          Margins.Bottom = 1
          CustomHint = blnhnt1
          DoubleBuffered = True
          ParentDoubleBuffered = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 4
        end
        object eAppVer: TEdit
          Left = 197
          Top = 62
          Width = 163
          Height = 20
          CustomHint = blnhnt1
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 2
        end
        object eHomePage: TEdit
          Left = 8
          Top = 102
          Width = 163
          Height = 20
          CustomHint = blnhnt1
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 3
        end
        object eFileName: TEdit
          Left = 8
          Top = 21
          Width = 352
          Height = 20
          CustomHint = blnhnt1
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 0
        end
        object eBuyPage: TEdit
          Left = 197
          Top = 102
          Width = 163
          Height = 20
          CustomHint = blnhnt1
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
      end
      object shMsg: TTabSheet
        CustomHint = blnhnt1
        Caption = 'Msg'
        object eMsgList: TTreeView
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 391
          Height = 308
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          HotTrack = True
          Images = immMsg
          Indent = 19
          ParentFont = False
          ReadOnly = True
          RowSelect = True
          ShowLines = False
          ShowRoot = False
          TabOrder = 0
          OnDblClick = eMsgListDblClick
        end
        object pAllowMsg: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 311
          Width = 391
          Height = 25
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alBottom
          Caption = 'Allow show messages at errors'
          TabOrder = 1
        end
      end
      object shLic: TTabSheet
        CustomHint = blnhnt1
        Caption = 'Lic'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblKeyPath: TLabel
          Left = 7
          Top = 43
          Width = 239
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Key path: ( default {$APP_name  $APP_version} )'
        end
        object lblPPKey: TLabel
          Left = 7
          Top = 5
          Width = 179
          Height = 14
          CustomHint = blnhnt1
          Caption = 'Private data for keys and code crypt:'
        end
        object btnGenPrivateD: TSpeedButton
          Left = 317
          Top = 18
          Width = 23
          Height = 23
          Cursor = crHandPoint
          Hint = 'Generate...'
          CustomHint = blnhnt1
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000000000000000000000000000000000007F807886877F
            85867FC0C0BFCACACACCCCCCD3D3D3DDDDDDE6E6E6FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF898A83898A82A5A699888981DFDFDDFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D8E86C8C9C1
            898A82A7A89B888982DFDFDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF8D8E86868780CBCCC6898A82A8A99C888982DFDFDDFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEEED
            8C8D86EEEEEC898A82AAAB9F888982DFDFDDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D8E8685867FFFFFFF898A82AEAFA389
            8A82C0C0BC92938C8F908990918AAFB0ABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFD8D8D68D8E87FAFAF9898A82B0B1A7989990B0B1A6CECEC6CECEC69293
            8BC9C9C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D8E86A1A29ABCBDB2BC
            BDB2BCBDB2BCBDB2BDBEB3BDBEB3CECEC78C8D84E0E0DFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFDFDFD82837BBBBCB1BFC0B6BFC0B6BFC0B6C0C1B6C0C1B6C0C1
            B6C6C7BF8C8D85F2F2F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B8B84CCCDC6C3
            C4BAC3C4BAC3C4BAC3C4BABABBB3A0A19AC2C3BAA9AAA1BABAB6FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF999A93E1E2DDC6C7BEC6C7BEC6C7BEB9B9B2909189C2C2
            BF969790B8B9B0A1A29CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0A19AEAEAE7C9
            C9C2C9C9C2B5B5AE90918AEAEAE9969790A1A29A8C8D86E5E5E3FFFFFFFFFFFF
            FFFFFFFFFFFFF9F9F9B7B8B2ACADA6EBEBE8CCCCC5868780E3E3E1969790A2A2
            9B8C8D86E3E3E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F7A2A39D9F
            A098ECECE9B2B2AB84847DA3A49D8C8D86E3E3E2FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEBCBCB892938BFFFFFFC5C5BE8D8E87E3E3
            E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFD8D8D691928C91928CE4E4E3FFFFFFFFFFFFFFFFFFFFFFFF}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnGenPrivateDClick
        end
        object btnExportKey: TSpeedButton
          Left = 340
          Top = 18
          Width = 23
          Height = 23
          Cursor = crHandPoint
          Hint = 'Export...'
          CustomHint = blnhnt1
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000626060201F1E
            006DCA006DCA006DCA006DCA006DCA006DCA006DCA006DCA006DCA006DCA006D
            CA006DCA22212061606022221F3432300380EE0380EE0380EE0380EE0380EE03
            80EE0380EE0380EE0380EE0380EE0380EE0380EE343230222220242321262322
            0380EE0380EE0380EE0380EE0380EE0380EE0380EE0380EE0380EE0380EE0380
            EE0380EE252422242321272624282725FCE9D3FCE9D4FCE9D4FCE9D4FBE9D4FC
            E9D4FBE9D5FCE9D5FBEAD5FCE9D5FCEAD5FBEAD52827252726242928262B2A28
            FBE9D5FCE9D5FCE9D5FCEAD5FCEAD6FCEAD6FCE9D5FCEAD6FCEAD6FCEAD6FBEA
            D6FCEAD62B2A282928262C2A282F2D2BC5D3DBC5D3DBC5D3DCC5D3DBC5D3DCC5
            D3DBC5D3DBC5D3DCC5D3DCC5D3DBC5D3DBC5D3DC2F2D2B2D2A282F2C2C333030
            FCEBD7FCEBD7FCEBD7FCEAD7FBEBD8FBEBD7FCEBD7FCEBD7FCEBD7FCEAD8FCEB
            D7FCEBD83330302F2D2B32302D363433C5D4DDC5D3DDC5D4DDC5D4DCC5D4DDC5
            D4DDC5D4DDC5D4DDC5D4DDC5D4DDC5D4DDC5D4DD37353331302E35322F3B3736
            B0A498FCEBD8FCEBD8FCEBD8FCEBD8FCEBD8FCEBD8FCEBD8FCEBD8FCEBD8FCEB
            D8B0A4973B38363532303734333E3B3A3E3B3A3F3B3A3E3B3A3F3B3A3F3B3A3E
            3B3A3E3B3A3F3B3A3F3B3A3F3B3A3F3B3A3F3B3A3E3B3A373433383634423F3D
            5552514E4C4B3B39383B39383B3A383B39383B39383B39383B39383B39383A39
            37393635423F3D3836343B37374642414E4C4B403C3A403C3AEAEACEEAEACDE8
            E8CDE8E8C9E8E8C3E8E8C3F0F0D7E8E8C33532314642403B37363C3A38494543
            514E4C403C3A494644F0F0D4F0F0D4EFEFD3ECECCFE8E8CCE8E8C84C4947E8E8
            C32F2D2C4946443C3A373E3A394C494652504E403C3A4C4847F2F2DBF2F2DDF2
            F2DBF1F1D6EEEED3EAEACB4C4947E8E8C32928274C49463E3B3A3F3B3A6E6C6B
            3B3938403C3A6E6C6BF6F6E9F8F8EBF8F8EAF6F6E8F5F5E4F4F4E14C4947F0F0
            D92423223F3B3A757170777371403C3A433F3E403C3A514C4AB3B3A7B3B3A7B3
            B3A7B3B3A7B3B3A7B3B3A7B3B3A7B3B3A7201F1E777371E0E0DF}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnExportKeyClick
        end
        object btnImportKey: TSpeedButton
          Left = 363
          Top = 20
          Width = 23
          Height = 21
          Cursor = crHandPoint
          Hint = 'Import...'
          CustomHint = blnhnt1
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000DE9A3EDE9A3E
            DE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A
            3EDE9A3EDE9A3EDE9A3E59AFF557B3F659B7F759BAF859BEF959C1FA59C3FC59
            C6FC59C9FD59CAFE59CBFE59CAFE59CAFE59CAFE56C9FE58C9FE2A95F1A3EFFD
            B6F1FDB8F3FDBAF5FDBBF8FEBDFAFEBEFBFEBEFCFEBEFDFEBDFCFEBDFBFEBBFA
            FEBAF9FEA3F8FD29B9FE2792F072E3FC70DEFC72E2FC75E7FC79EBFD7CF0FD7F
            F5FD81F9FE84FCFE83FCFE82FCFE81FAFE7EF8FE7AF7FD26B9FE2591F04FDAFC
            3CCEFC3DD1FC41D6FD45DCFD49E3FD4EEAFD53F1FE56F7FE58FBFF59FCFF58FB
            FF56FAFF60F8FD25B9FE248FF04AD8FB36CCFC37CCFC38CFFC3BD5FC40DBFC45
            E1FD49EAFD4EEFFD52F6FE54F9FE54FCFE53FBFE5FFAFD25B9FE228CF050D2F9
            4CCEF94CCFF94DD0F94DD2FA4FD5FA54E0FC46E1FD48E9FD4DEEFE50F4FE54F9
            FE54FCFF60FBFD25B8FD3C8BD94E9FD6509FD652A0D653A3D654A5D655A7D733
            A3ED55E2FC47E2FD4BE8FD50EEFD54F4FD56F8FE62FAFD25B5FC5AA4E788D1E8
            8BD0E88ED3E891D7E992DAE88DD4E265B3D735ACF340BCF641C0F740C2F841C4
            FA41C8FA41CBFB21ACF965AFF49EEBFCA2E9FCA6EDFCA9F2FCAAF5FC9CE5EF8B
            D3E27DC6DC7AC4DB79C2DB78C2DC76C0DC74BEDC71BEDB4FABE366AFF4A0ECFD
            A3E9FEA6EDFEA9F1FEACF6FFACF6FCA1ECF3A0ECF2A0EBF29FE9F29DE9F29BE6
            F298E4F294E3F15FBFF366AFF4A0ECFDA2E7FEA4EAFEA7EEFEAAF4FEAEF8FFB0
            FCFFB1FEFFB1FFFFB0FDFFAEFCFFACF9FFA9F7FFA4F6FD66C7FC66AFF4B3ECF8
            BDE8F6BEE9F6C0ECF6C1EEF6BBF2F9AEF9FEABFCFDABFDFDABFDFDAAFCFDA8FB
            FDA7F9FDA3F8FD66C5FB66AFF4D7F1F4F9F9F9F9F9F9F9F9F9F9F9F9D8F1F596
            EBFC5FB5F666B8F766BAF866BCF866BEF966C0F966C2FADE9A3EDE9A3E66AFF4
            C0EEF5C0EEF5C0EEF5C1EFF5B6F1F764BBF6DE9A3EDE9A3EDE9A3EDE9A3EDE9A
            3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3E66AFF466AFF466AFF466B0F466B0F4DE
            9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3E}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnImportKeyClick
        end
        object HwidGrup: TGroupBox
          Left = 7
          Top = 249
          Width = 379
          Height = 78
          CustomHint = blnhnt1
          Caption = 'License ID depends of:'
          TabOrder = 0
          object eHwidMode1: TRadioButton
            AlignWithMargins = True
            Left = 9
            Top = 17
            Width = 365
            Height = 17
            Margins.Left = 7
            Margins.Top = 1
            Margins.Bottom = 0
            CustomHint = blnhnt1
            Align = alTop
            Caption = 'Hardware and platform (default)'
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object eHwidMode2: TRadioButton
            AlignWithMargins = True
            Left = 9
            Top = 35
            Width = 365
            Height = 17
            Margins.Left = 7
            Margins.Top = 1
            Margins.Bottom = 0
            CustomHint = blnhnt1
            Align = alTop
            Caption = 'Hardware'
            TabOrder = 1
          end
          object eHwidMode3: TRadioButton
            AlignWithMargins = True
            Left = 9
            Top = 53
            Width = 365
            Height = 17
            Margins.Left = 7
            Margins.Top = 1
            CustomHint = blnhnt1
            Align = alTop
            Caption = 'Independent'
            TabOrder = 2
          end
        end
        object edtKeyPath: TEdit
          Left = 7
          Top = 58
          Width = 379
          Height = 20
          CustomHint = blnhnt1
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ePrivateData: TEdit
          Left = 7
          Top = 20
          Width = 309
          Height = 20
          CustomHint = blnhnt1
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object eUseEDate: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 84
          Width = 363
          Height = 30
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Caption = 'Use application expiration date'
          TabOrder = 3
        end
        object chkUseExecCount: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 114
          Width = 363
          Height = 30
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Caption = 'Use limitations of executions count'
          TabOrder = 4
        end
        object chkUseDaysLimit: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 144
          Width = 363
          Height = 30
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Caption = 'Use limitations of days count'
          TabOrder = 5
        end
        object chkUseExecLimit: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 175
          Width = 363
          Height = 30
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Caption = 'Use application execution time limit, seconds'
          TabOrder = 6
        end
        object eExitIfNoKey: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 204
          Width = 363
          Height = 31
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Caption = 'Do not start application without a valid activation key'
          TabOrder = 7
        end
        object eEDate: TDateTimePicker
          Left = 286
          Top = 87
          Width = 100
          Height = 22
          CustomHint = blnhnt1
          Date = 41131.000000000000000000
          Time = 41131.000000000000000000
          TabOrder = 8
        end
        object seExecCount: TSpinEdit
          Left = 286
          Top = 116
          Width = 100
          Height = 23
          CustomHint = blnhnt1
          MaxValue = 0
          MinValue = 0
          TabOrder = 9
          Value = 60
        end
        object seDaysCount: TSpinEdit
          Left = 286
          Top = 146
          Width = 100
          Height = 23
          CustomHint = blnhnt1
          MaxValue = 0
          MinValue = 0
          TabOrder = 10
          Value = 15
        end
        object seExecLimit: TSpinEdit
          Left = 286
          Top = 177
          Width = 100
          Height = 23
          CustomHint = blnhnt1
          MaxValue = 0
          MinValue = 0
          TabOrder = 11
          Value = 120
        end
      end
      object shExcl: TTabSheet
        CustomHint = blnhnt1
        Caption = 'Options'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pStolenRC: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 143
          Width = 387
          Height = 25
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Stolen resources, convert resources to self format '
          TabOrder = 5
        end
        object pAntiDebug: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 92
          Width = 387
          Height = 26
          Margins.Left = 7
          Margins.Top = 7
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Debug and trace block'
          TabOrder = 3
        end
        object oAntiDump: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 118
          Width = 387
          Height = 25
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Use "anti dump" mode'
          TabOrder = 4
        end
        object eReqAdminR: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 35
          Width = 387
          Height = 25
          Margins.Left = 7
          Margins.Top = 7
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Request  of administrator rights'
          TabOrder = 1
        end
        object oSameSize: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 3
          Width = 387
          Height = 25
          Margins.Left = 7
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Same file size  (as origin file)'
          TabOrder = 0
        end
        object eUseOneCopy: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 60
          Width = 387
          Height = 25
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Only one executed process in memory'
          TabOrder = 2
        end
        object chkDisableCompression: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 175
          Width = 387
          Height = 26
          Margins.Left = 7
          Margins.Top = 7
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Disable file compression'
          TabOrder = 6
        end
        object chkIncreaseSize: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 201
          Width = 387
          Height = 25
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alTop
          Caption = 'Increase loader size and file size'
          TabOrder = 7
        end
      end
      object shNag: TTabSheet
        CustomHint = blnhnt1
        Caption = 'NAG'
        object pnlNag: TPanel
          Left = 0
          Top = 0
          Width = 397
          Height = 336
          CustomHint = blnhnt1
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object lblNagText: TLabel
            Left = 7
            Top = 87
            Width = 23
            Height = 14
            CustomHint = blnhnt1
            Caption = 'Text:'
          end
          object lblNagHlp: TLabel
            Left = 7
            Top = 263
            Width = 101
            Height = 14
            CustomHint = blnhnt1
            Caption = 'Button [help] caption:'
          end
          object lblNagOk: TLabel
            Left = 143
            Top = 263
            Width = 92
            Height = 14
            CustomHint = blnhnt1
            Caption = 'Button [ok] caption:'
          end
          object lblNagBuy: TLabel
            Left = 277
            Top = 263
            Width = 99
            Height = 14
            CustomHint = blnhnt1
            Caption = 'Button [buy] caption:'
          end
          object lblNagcaption: TLabel
            Left = 7
            Top = 4
            Width = 70
            Height = 14
            CustomHint = blnhnt1
            Caption = 'Dialog caption:'
          end
          object lblLidcaption: TLabel
            Left = 199
            Top = 3
            Width = 91
            Height = 14
            CustomHint = blnhnt1
            Caption = 'License ID caption:'
          end
          object lblNagUName: TLabel
            Left = 199
            Top = 41
            Width = 93
            Height = 14
            CustomHint = blnhnt1
            Caption = 'User name caption:'
          end
          object lblActivationKey: TLabel
            Left = 7
            Top = 42
            Width = 109
            Height = 14
            CustomHint = blnhnt1
            Caption = 'Activation key caption:'
          end
          object nagBackColor: TLabel
            Left = 368
            Top = 312
            Width = 16
            Height = 16
            Cursor = crHandPoint
            Hint = 'Back color'
            CustomHint = blnhnt1
            AutoSize = False
            Color = clBlack
            ParentColor = False
            ParentShowHint = False
            ShowHint = True
            Transparent = False
            OnClick = nagBackColorClick
          end
          object nagFontColor: TLabel
            Left = 344
            Top = 312
            Width = 16
            Height = 16
            Cursor = crHandPoint
            Hint = 'Font color'
            CustomHint = blnhnt1
            Alignment = taCenter
            AutoSize = False
            Caption = 'A'
            Color = clBlack
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Transparent = False
            OnClick = nagFontColorClick
          end
          object eNAGText: TMemo
            Left = 7
            Top = 105
            Width = 378
            Height = 148
            CustomHint = blnhnt1
            Alignment = taCenter
            Lines.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '0')
            TabOrder = 0
            OnChange = eNAGTextChange
          end
          object eNAGHelp: TEdit
            Left = 7
            Top = 277
            Width = 108
            Height = 20
            CustomHint = blnhnt1
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object eNAGOK: TEdit
            Left = 143
            Top = 277
            Width = 108
            Height = 20
            CustomHint = blnhnt1
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object eNAGBuy: TEdit
            Left = 277
            Top = 277
            Width = 108
            Height = 20
            CustomHint = blnhnt1
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object eNAGDlgCaption: TEdit
            Left = 7
            Top = 18
            Width = 174
            Height = 20
            CustomHint = blnhnt1
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object eNAGLicCaption: TEdit
            Left = 199
            Top = 18
            Width = 185
            Height = 22
            CustomHint = blnhnt1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object eNagUserName: TEdit
            Left = 199
            Top = 56
            Width = 185
            Height = 22
            CustomHint = blnhnt1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object eNAGKeyCaption: TEdit
            Left = 7
            Top = 56
            Width = 174
            Height = 20
            CustomHint = blnhnt1
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object chkTextAlign: TCheckBox
            Left = 84
            Top = 87
            Width = 301
            Height = 17
            CustomHint = blnhnt1
            Caption = 'Align text to Left'
            TabOrder = 8
            OnClick = chkTextAlignClick
          end
          object chkDelay: TCheckBox
            Left = 269
            Top = 312
            Width = 73
            Height = 17
            CustomHint = blnhnt1
            Caption = 'Delay'
            TabOrder = 9
            OnClick = chkDelayClick
          end
        end
        object oCustomNAG: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 305
          Width = 260
          Height = 31
          Margins.Left = 7
          Margins.Top = 0
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Caption = 'Use standard registration dialog'
          TabOrder = 1
        end
      end
      object shBlack: TTabSheet
        CustomHint = blnhnt1
        Caption = 'Black list'
        ImageIndex = 9
        OnShow = shBlackShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object eBlack: TListView
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 391
          Height = 330
          CustomHint = blnhnt1
          Align = alClient
          Columns = <
            item
              Caption = 'User'
              Width = 100
            end
            item
              Caption = 'Reason'
              Width = 150
            end
            item
              Caption = 'Key'
              Width = 120
            end>
          ColumnClick = False
          DoubleBuffered = True
          FlatScrollBars = True
          GridLines = True
          HotTrackStyles = [htUnderlineCold]
          ReadOnly = True
          RowSelect = True
          ParentDoubleBuffered = False
          PopupMenu = popBlack
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = eBlackDblClick
        end
      end
      object tsKG: TTabSheet
        CustomHint = blnhnt1
        Caption = 'KG'
        ImageIndex = 7
        object tvKgMsg: TTreeView
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 391
          Height = 333
          Margins.Bottom = 0
          CustomHint = blnhnt1
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          HotTrack = True
          Images = immMsg
          Indent = 19
          ParentFont = False
          ReadOnly = True
          RowSelect = True
          ShowLines = False
          ShowRoot = False
          TabOrder = 0
          OnDblClick = tvKgMsgDblClick
        end
      end
    end
  end
  object bvvccb: TCoolBar
    Left = 0
    Top = 0
    Width = 574
    Height = 25
    CustomHint = blnhnt1
    AutoSize = True
    BandMaximize = bmNone
    Bands = <
      item
        Control = mnuPanel
        ImageIndex = -1
        Width = 572
      end>
    EdgeInner = esNone
    EdgeOuter = esNone
    FixedSize = True
    FixedOrder = True
    object mnuPanel: TPanel
      Left = 2
      Top = 0
      Width = 69
      Height = 25
      CustomHint = blnhnt1
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      object btnNew: TSpeedButton
        Left = 0
        Top = 0
        Width = 23
        Height = 25
        CustomHint = blnhnt1
        Align = alLeft
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000949090D79C9898F59A9696F5999595F5989494F5979393F5969292F59591
          91F5949191F5949090F5938F8FF5938F8FF5898585D200000000000000000000
          00009B9797EFFAF6F4FFF7EFECFFF6EDEAFFF6ECE8FFF5EAE7FFF5E9E5FFF4E8
          E4FFF4E8E3FFF4E8E3FFF4E8E3FFF8F1EFFF8D8989E900000000000000000000
          00009D9898EFF9F3F0FFF5E8E3FFF3E5E0FFF2E2DDFFF1DFD9FFF0DDD6FFEFDA
          D3FFEED9D1FFEED8D0FFEED8D0FFF5EAE5FF8E8A8AE900000000000000000000
          00009E9A9AEFFAF5F3FFF6ECE8FFF5EAE5FFF4E7E2FFF3E4DFFFF2E1DBFFF1DE
          D8FFEFDCD5FFEEDAD2FFEED8D0FFF5EAE5FF8E8A8AE900000000000000000000
          00009F9B9BEFFAF6F4FFF8EFECFFF7EEEAFFF6EBE7FFF5E9E4FFF4E6E1FFF3E3
          DEFFF1E0DAFFF0DDD7FFEFDBD4FFF5EAE7FF8F8B8BE900000000000000000000
          0000A09C9CEFFAF6F4FFF9F1EEFFF8F0EDFFF8EFEBFFF7EDE9FFF6EAE6FFF5E8
          E3FFF3E5E0FFF2E2DCFFF1DFD9FFF6ECE9FF908C8CE900000000000000000000
          0000A19D9DEFFAF6F4FFF9F1EEFFF9F1EEFFF9F0EDFFF8F0EDFFF7EEEBFFF6EC
          E8FFF5E9E5FFF4E7E2FFF3E4DEFFF7EFECFF918D8DE900000000000000000000
          0000A39E9EEFFAF6F4FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF8F0EDFFF8EF
          ECFFF7EDEAFFF6EBE7FFF5E8E4FFF8F1EFFF928E8EE900000000000000000000
          0000A49F9FEFFAF6F4FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
          EEFFF8F0EDFFF8EFEBFFF7EDE9FFF9F3F1FF938F8FE900000000000000000000
          0000A5A0A0EFFAF6F4FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
          EEFFF9F1EEFFF9F0EDFFF8F0ECFFFAF5F3FF949090E900000000000000000000
          0000A6A1A1EFFAF6F4FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
          EEFFF9F1EEFFF8F0EDFFF8F0EDFFFAF6F4FF959191E900000000000000000000
          0000A6A2A2EFFAF6F4FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
          EEFFF8F0EDFFEEE6E3FFE4DCDAFFE7E4E2FF928E8EE900000000000000000000
          0000A7A3A3EFFAF6F4FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
          EEFFF7EFECFFA5A0A0FF9E9A9AFF999595FF938E8EE100000000000000000000
          0000A8A3A3EFFAF6F4FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
          EEFFF7EFECFFA19D9DFFD3D1D2FF9A9696EE9C98983400000000000000000000
          0000A9A4A4EFFBF9F8FFFAF6F4FFFAF6F4FFFAF6F4FFFAF6F4FFFAF6F4FFFAF6
          F4FFFAF5F4FFA19C9CFF9C9898EE9D9999340000000000000000000000000000
          0000A49F9FD2A9A4A4EFA8A3A3EFA7A3A3EFA6A2A2EFA6A1A1EFA5A0A0EFA49F
          9FEFA39E9EEF9A9595E1A39E9E34000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnNewClick
        ExplicitHeight = 22
      end
      object btnOpen: TSpeedButton
        Left = 23
        Top = 0
        Width = 23
        Height = 25
        CustomHint = blnhnt1
        Align = alLeft
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000DE9A3EDE9A3E
          DE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A
          3EDE9A3EDE9A3EDE9A3E59AFF557B3F659B7F759BAF859BEF959C1FA59C3FC59
          C6FC59C9FD59CAFE59CBFE59CAFE59CAFE59CAFE56C9FE58C9FE2A95F1A3EFFD
          B6F1FDB8F3FDBAF5FDBBF8FEBDFAFEBEFBFEBEFCFEBEFDFEBDFCFEBDFBFEBBFA
          FEBAF9FEA3F8FD29B9FE2792F072E3FC70DEFC72E2FC75E7FC79EBFD7CF0FD7F
          F5FD81F9FE84FCFE83FCFE82FCFE81FAFE7EF8FE7AF7FD26B9FE2591F04FDAFC
          3CCEFC3DD1FC41D6FD45DCFD49E3FD4EEAFD53F1FE56F7FE58FBFF59FCFF58FB
          FF56FAFF60F8FD25B9FE248FF04AD8FB36CCFC37CCFC38CFFC3BD5FC40DBFC45
          E1FD49EAFD4EEFFD52F6FE54F9FE54FCFE53FBFE5FFAFD25B9FE228CF050D2F9
          4CCEF94CCFF94DD0F94DD2FA4FD5FA54E0FC46E1FD48E9FD4DEEFE50F4FE54F9
          FE54FCFF60FBFD25B8FD3C8BD94E9FD6509FD652A0D653A3D654A5D655A7D733
          A3ED55E2FC47E2FD4BE8FD50EEFD54F4FD56F8FE62FAFD25B5FC5AA4E788D1E8
          8BD0E88ED3E891D7E992DAE88DD4E265B3D735ACF340BCF641C0F740C2F841C4
          FA41C8FA41CBFB21ACF965AFF49EEBFCA2E9FCA6EDFCA9F2FCAAF5FC9CE5EF8B
          D3E27DC6DC7AC4DB79C2DB78C2DC76C0DC74BEDC71BEDB4FABE366AFF4A0ECFD
          A3E9FEA6EDFEA9F1FEACF6FFACF6FCA1ECF3A0ECF2A0EBF29FE9F29DE9F29BE6
          F298E4F294E3F15FBFF366AFF4A0ECFDA2E7FEA4EAFEA7EEFEAAF4FEAEF8FFB0
          FCFFB1FEFFB1FFFFB0FDFFAEFCFFACF9FFA9F7FFA4F6FD66C7FC66AFF4B3ECF8
          BDE8F6BEE9F6C0ECF6C1EEF6BBF2F9AEF9FEABFCFDABFDFDABFDFDAAFCFDA8FB
          FDA7F9FDA3F8FD66C5FB66AFF4D7F1F4F9F9F9F9F9F9F9F9F9F9F9F9D8F1F596
          EBFC5FB5F666B8F766BAF866BCF866BEF966C0F966C2FADE9A3EDE9A3E66AFF4
          C0EEF5C0EEF5C0EEF5C1EFF5B6F1F764BBF6DE9A3EDE9A3EDE9A3EDE9A3EDE9A
          3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3E66AFF466AFF466AFF466B0F466B0F4DE
          9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3EDE9A3E}
        ParentShowHint = False
        PopupMenu = recentPop
        ShowHint = True
        OnClick = btnOpenClick
      end
      object btnSave: TSpeedButton
        Left = 46
        Top = 0
        Width = 23
        Height = 25
        CustomHint = blnhnt1
        Align = alLeft
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000A56E64A76A61
          A36458A76D64A66D64A56B64A36964A168659F66659E66659E65659C64659B63
          659356589C5F619A6567AB6C62FEA7A7C08B7EF5EAE5F5E9E5F5E9E5F5E9E5F5
          E9E5F5E9E5F5E9E5F5E9E5F5E9E5F6EBE7B37172FEA5A59C5F61AC6D62FEA1A1
          C18C7EE5D9D5C8BBB7C8BBB7C8BBB7C8BBB7C8BBB7C8BBB7C8BBB7C8BBB7E9DD
          D9B47071FE9F9F9D6061AD6F62FEA5A5C38E7FF4E9E5EFE3DFEFE3DFEFE3DFEF
          E3DFEFE3DFEFE3DFEFE3DFEFE3DFF5EBE8B57171FEA1A19E6162AE7062FEA9A9
          C48F7FE6DCD8C4B9B5C4B9B5C4B9B5C4B9B5C4B9B5C4B9B5C4B9B5C4B9B5E9E0
          DDB67372FEA5A59E6262AE7162FEADADC59180F8F0EDF5EDEAF5EDEAF5EDEAF5
          EDEAF5EDEAF5EDEAF5EDEAF5EDEAF8F1EEB77573FEA9A99E6362AF7262FEB1B1
          C79280E6DFDCC0B7B3C0B7B3C0B7B3C0B7B3C0B7B3C0B7B3C0B7B3C0B7B3EAE3
          E0B87774FEADAD9F6462B07362FEB6B6C79380FAF4F2FAF4F2FAF4F2FAF4F2FA
          F4F2FAF4F2FAF4F2FAF4F2FAF4F2FAF5F3BA7974FEB1B1A06562B17462FEBABA
          BC7D66D7B4A6D6B3A6D6B3A6D5B2A6D4B1A6D3B0A6D2B0A6D1AFA7D0AEA7CFAD
          A7B46F68FEB5B5A16663B27562FEBEBEF1AAA5E39A90E0978CE0968CDF958CDF
          958BDF948BDE938BDE938BDD928AE0958EF2A6A5FEBABAA26663B37662FEC2C2
          FFBCBCD57D6DEB7D74D0A399D1A79DD0A69CCAA198CAA197CF988EEC7C73D57E
          70FFB7B7FEBEBEA36762B47762FEC6C6FFC0C0DE8174FD7C78DBC1BBDBC8C0DA
          C6BFB78069AD6447D7ADA6FF7B77DE8477FFBBBBFEC2C2A56962B57762FEC9C9
          FFC3C3DE8578FD847FE1CBC7E4D6D0E2D4CFB8836EAC664BDAB3ADFF837EDE87
          7AFFBFBFFEC5C5A56A62B57862FECCCCFFC7C7DE897BFD8C86E8D7D3EEE5E1EC
          E3DFBA8A77AD6E55DDBAB5FF8C86DE8B7EFFC2C2FECACAA56A61B67962FED2D2
          FECECEDE8E80FD968FE9D8D4EFE5E2EDE4E1D0B7AECCADA1E0BFBAFF958FDE90
          83FDCDCDC38A83AE8882C8C8C8B47861B37761B6745FBE7C68B77B67B67B67B6
          7B67B67A67B57966B67966BB7B68B1705EA86B5FB3938DC8C8C8}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnSaveClick
        ExplicitLeft = 56
        ExplicitTop = -3
      end
    end
  end
  object Timer: TTimer
    Interval = 500
    OnTimer = TimerTimer
    Left = 704
    Top = 156
  end
  object immMsg: TImageList
    BkColor = clWhite
    Left = 704
    Top = 378
    Bitmap = {
      494C01010400A000840110001000FFFFFF00FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC8C7D00E2B49500DBAC
      8E00DBAA8B00D9A98700D9A78500D9A68100D9A37E00D9A17B00DEA67900B27E
      6A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E2E6F72399A6E27D4B60CBDB344DC3F3334BC2F3455BC6DB94A0DD7DE0E4
      F523FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008A8A8AFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00BF4D15FFD28A6F9BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DDB09900FFFFCF00FFF6
      C300FFF3BD00FFF0B700FFEDB200FFEAAC00FFE6A600FFE3A000FFE89B00D69F
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BEC7
      EF534A62D1E65163D4FF838FE7FF949FEEFF949EEDFF828DE5FF4B5CCEFF3C52
      C2E6B8C0E853FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008B8B8BFF8A8A8AFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C35817FFCC703AFFD2896BA0FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DBB09E00FFFFD900FFFF
      D900B6D4A5009EC18D00FFE3A000FFE3A000FFE3A000FFE3A000FFEAAA00D4A0
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1C9F153465F
      D4F47483E3FFA0ABF4FF7E8AECFF5B66E4FF5A65E3FF7C86EAFF9EA7F1FF6E7B
      DDFF314AC0F4B8C0E953FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008C8C8CFFFFFFFFFF8A8A8AFFFFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C96119FFDFA274FFCF733BFFD48B6AA2FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCB4A500FFFFE5005F5C
      45005B543E00C4A28A00CAA78C00C9A58800C7A18400DFB69200FFF2BA00D5A3
      8A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6EAFA22576FDDE57787
      E6FFA2AFF5FF5666E7FF5564E6FF8891EDFF8791ECFF525EE2FF515CE1FF9EA8
      F2FF6E7CDDFF3F56C5E5E2E5F622FFFFFF00FFFFFF00FFFFFF00949494998D8D
      8DFF8D8D8DFF8D8D8DFFFFFFFFFFFFFFFFFF8A8A8AFF888888FF878787FF8686
      86FF94949499FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CD6D22FFE1A77DFFE0A578FFD0763CFFD28A64A9FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCB6AA00FFFFE5007094
      6500528E5200FFF8D600FFFDD900FFFAD500FFF8CF00FFF6C900FFFAC900D6A7
      9100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A7B3F07E5F72E0FFA3B2
      F7FF596DEBFF586BEAFF5768E8FFFFFFFFFFFFFFFFFF5461E5FF5360E3FF525E
      E2FF9EA8F2FF4F60D1FF96A3E07EFFFFFF00FFFFFF00949494FFD8D8D8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFD8D8D8FF949494FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D27634FFE4AE86FFDFA071FFE1A87BFFD0793EFFD38A62ACFDFCFB04FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DDBAAF00FFFFFE00FFFF
      F300B6D4A5009EC18D00FFFFE500FFFFE100FFFEDC00FFFCD600FFFFD700D6AA
      9700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006980E8DB8D9EF0FF8398
      F4FF5B72EEFF5A6FECFF596DEBFF8F9CF1FFA5AEF3FF5666E7FF5564E6FF5461
      E5FF7C88EBFF8490E7FF4D62CDDBFFFFFF0094949499D8D8D8FFF7F7F7FFF1F1
      F1FFE9E9E9FFE0E0E0FFDCDCDCFFDBDBDBFFDADADAFFD8D8D8FFD6D6D6FFE5E5
      E5FFF2F2F2FFD8D8D8FF94949499FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D68342FFE7B48FFFE0A273FFE0A376FFE2AA80FFD37E42FFD6895CB3FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DDBCB500FFFFFF008781
      700058564500B69E9200BEA69800BEA59400BDA29100CBAF9B00FADEC100D7AE
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005B75E9F69FB2F7FF647F
      F2FF5E77F0FF5C75EFFF5B72EEFFD3D9FAFFFFFFFFFF586BEAFF5768E8FF5666
      E7FF5C6BE7FF98A4F1FF3B54CBF6FFFFFF00919191FFFFFFFFFFFFFFFFFFFBFB
      FBFFF3F3F3FFECECECFFE8E8E8FFE7E7E7FFE6E6E6FFE2E2E2FFDEDEDEFFDBDB
      DBFFE3E3E3FFFBFBFBFF868686FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DB8D52FFEABA98FFE3A97FFFE3AA80FFE4B089FFD6874AFFCB7233E2FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEC0BA00FFFFFF00729C
      70004C864F00FFFFF000FFFFFD00FFFFF900FFFFF500FFFFF000FFFFF200D8B0
      A200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005F79EDF6A0B5F8FF6683
      F4FF5F7BF3FF5E79F1FF5E77F0FFFFFFFFFFFFFFFFFF5A6FECFF596DEBFF586B
      EAFF5E6EE9FF9AA7F1FF3F58CFF6FFFFFF00919191FFFFFFFFFFFFFFFFFFFFFF
      FFFFFDFDFDFFF6F6F6FFF2F2F2FFF2F2F2FFF1F1F1FFEDEDEDFFE8E8E8FFE3E3
      E3FFDFDFDFFFFFFFFFFF878787FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E19661FFECC0A0FFE8B691FFE9BA98FFDD9660FFDEA376A4FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFC2C000FFFFFF00FFFF
      FF00CAF3C8007DA97D00FFFFFF00FFFFFF00FFFFFF00FFFFFD00FFFFFF00D9B4
      A900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00748BF2DB90A5F3FF87A0
      F8FF617FF4FF607DF3FF5F7BF3FFFFFFFFFFFFFFFFFF5C75EFFF5B72EEFF5A6F
      ECFF8192F1FF8897ECFF586ED8DBFFFFFF00929292FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFEFEFEFFFBFBFBFFFBFBFBFFFBFBFBFFF7F7F7FFF1F1F1FFEBEB
      EBFFE6E6E6FFFFFFFFFF888888FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E29F6DFFEEC7A7FFEDC1A2FFE3A374FFE5B28C9EFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFC4C300FFFFFF00A9A0
      9A00555D4900A28F8C00B9A7A200B7A59F00B7A39C00B9A59C00F7F1E200DCBB
      B200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B1BEFA7E6B80ECFFA8BC
      FBFF6281F5FF6180F5FF617FF4FFFFFFFFFFFFFFFFFF5E79F1FF5E77F0FF5C75
      EFFFA4B4F8FF5C6FDDFFA1AEEB7EFFFFFF00929292FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFF4F4
      F4FFEDEDEDFFFFFFFFFF888888FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E6A678FFEFC8ACFFE8AF86FFECC3A58EFFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFC6C600FFFFFF007893
      77004C945600E2E4DD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCEDE500C7A3
      9F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EAEEFE22738BF6E58296
      F0FFA8BCFBFF6281F5FF6281F5FFFFFFFFFFFFFFFFFF607DF3FF5F7BF3FFA5B8
      F9FF7A8CEAFF5B72E1E5E6E9FA22FFFFFF00939393FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
      FEFFF6F6F6FFFFFFFFFF888888FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EAAA7FFFE8A87BFEEFCDB487FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFC6C600FFFFFF00FFFF
      FF00F8FFFD0059956000BCD2BE00FFFFFF00FFFFFF00FFECE600B27F71008D5E
      5D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CDD6FD536B85
      F8F48396F1FFA8BCFBFF89A2F8FF6A88F6FF6A88F6FF88A1F8FFA7BBFAFF7E91
      ECFF5871E5F4C5CDF553FFFFFF00FFFFFF0094949499D8D8D8FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFD7D7D7FF94949499FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E8AD84F4F2D0BA87FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFC6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFCFA0099696200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CDD6
      FD53758DF9E66D82EEFF91A5F4FF9FB3F8FF9FB3F8FF90A5F3FF677CE9FF687F
      ECE6C7D0F753FFFFFF00FFFFFF00FFFFFF00FFFFFF00949494FFD8D8D8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFD8D8D8FF949494FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B9918F00D7BBBB00D1B5
      B400D1B4B400D1B4B400D0B4B300D0B3B300D2B6B500BE9B9B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EAEEFE23B4C2FC7D7B92F9DB6B85F7F36983F5F3768DF4DBB0BDF87DE8EC
      FC23FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00949494999494
      94FF939393FF929292FF929292FF919191FF919191FF909090FF8F8F8FFF8E8E
      8EFF94949499FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF800FF00FFBFF
      F3FF800FE007F9FFF1FF800FC003F8FFF0FF800F8001C007F07F800F80018003
      F01F800F80010001F01F800F80010001F01F800F80010001F03F800F80010001
      F07F800F80010001F0FF800F80010001F1FF800FC0030001F3FF801FE0078003
      FFFF803FF00FC007FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object mainMnu: TMainMenu
    Images = immMenu
    Left = 714
    Top = 480
    object mnuMFile: TMenuItem
      Caption = 'File'
      object mnuNewProject: TMenuItem
        Caption = 'New project'
        ImageIndex = 0
        ShortCut = 16462
        OnClick = mnuNewProjectClick
      end
      object mnuOpenProject: TMenuItem
        Caption = 'Open project'
        ImageIndex = 2
        ShortCut = 16463
        OnClick = mnuOpenProjectClick
      end
      object mnuSaveProject: TMenuItem
        Caption = 'Save project'
        ImageIndex = 1
        ShortCut = 16467
        OnClick = mnuSaveProjectClick
      end
      object mniSaveprojectas: TMenuItem
        Caption = 'Save project as...'
        OnClick = mniSaveprojectasClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object mnuLng: TMenuItem
        Caption = 'Language'
        object Submenu1: TMenuItem
          Caption = 'Sub menu!'
        end
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuExit: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object mnuOptions: TMenuItem
      Caption = 'Options'
      object mnuKG: TMenuItem
        Caption = 'Create project "keygen.exe"'
      end
    end
    object mnuMHelp: TMenuItem
      Caption = 'Help'
      object mnuHelp: TMenuItem
        Caption = 'Help'
        ShortCut = 16496
        OnClick = Help2Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object btnHomePage: TMenuItem
        Caption = 'Home page'
        ImageIndex = 4
        OnClick = btnHomePageClick
      end
      object btnOrderNow: TMenuItem
        Caption = 'Order now !'
        OnClick = btnOrderNowClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnuAbout: TMenuItem
        Caption = 'About...'
        ImageIndex = 3
        ShortCut = 112
        OnClick = mnuAboutClick
      end
    end
  end
  object recentPop: TPopupMenu
    OnPopup = recentPopPopup
    Left = 704
    Top = 432
  end
  object popBlack: TPopupMenu
    Images = immUI
    Left = 32
    Top = 330
    object mnuPopBlackAdd: TMenuItem
      Caption = 'Add'
      ImageIndex = 5
      OnClick = btnNewBlackClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object mnuPopBlackDel: TMenuItem
      Caption = 'Delete'
      ImageIndex = 6
      OnClick = btnDelBlackClick
    end
  end
  object immButtons: TImageList
    Height = 32
    Width = 32
    Left = 4
    Top = 176
    Bitmap = {
      494C010105000C00700120002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000004000000001002000000000000080
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ACB3B3B3BAB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BAB9B9B9ACD1D1
      D171FEFEFE020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D8D8D8629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D8D8D862989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D762000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF979797FF939393FF909090FF8E8E8EFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8E8E8EFF8E8E8EFF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8E8E8EFF909090FF949494FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D0720000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF959595FF878787FFA8A8A8FFC5C5C5FFD4D4D4FFD8D8
      D8FFD9D9D9FFD8D8D8FFD8D8D8FFD5D5D5FFD5D5D5FFD8D8D8FFD8D8D8FFD9D9
      D9FFD8D8D8FFD2D2D2FFC4C4C4FFA4A4A4FF868686FF969696FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9AD0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B3B3B3BA989898FF989898FF9898
      98FF989898FF959595FF979797FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFF919191FF969696FF9898
      98FF989898FF989898FF989898FFB3B3B3BA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF979797FF878787FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FF888888FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF949494FFA3A3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF979797FF9696
      96FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF939393FFAEAEAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4FF9494
      94FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF949494FFA3A3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF999999FF9595
      95FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF979797FF898989FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF878787FF8B8B8BFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF878787FF9797
      97FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF8B8B8BFFE8E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFADADADFF919191FF909090FFB1B1B1FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9FF8B8B8BFF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF939393FFA4A4A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFDFDFDFF848484FF989898FF989898FF848484FFFDFDFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEAEAEFF929292FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF898989FFE1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB7B7B7FF919191FF989898FF989898FF919191FFB7B7B7FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FF868686FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF979797FF858585FFF2F2F2FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF838383FF8D8D8DFF8B8B8BFF8B8B8BFF8F8F8FFF838383FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D8D8DFF969696FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF979797FF868686FFBFBFBFFFF4F4F4FFFCFC
      FCFF909090FF979797FFD9D9D9FFF0F0F0FFEEEEEEFFCFCFCFFF8D8D8DFF9494
      94FFFFFFFFFFFFFFFFFFD2D2D2FF8A8A8AFF959595FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF979797FF919191FF8B8B8BFF7C7C
      7CFFC4C4C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAAA
      AAFF808080FF898989FF8E8E8EFF979797FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF919191FFB8B8
      B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF9D9D9DFF949494FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF979797FF888888FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF1F1F1FF8A8A8AFF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF949494FFA7A7A7FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF8B8B8BFF979797FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF929292FFB6B6B6FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF999999FF969696FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF949494FFA4A4A4FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF8A8A8AFF979797FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF979797FF878787FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE9E9E9FF8B8B8BFF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF929292FFAFAF
      AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF989898FF959595FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF8B8B
      8BFFB9B9B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1A1
      A1FF919191FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF8F8F8FFF919191FFCBCBCBFFE5E5E5FFE2E2E2FFC2C2C2FF898989FF9393
      93FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9AD0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF969696FF8F8F8FFF8C8C8CFF8D8D8DFF909090FF979797FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D0720000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D7D7D762989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D762000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D7D7D7629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ABB3B3B3BBB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BBB9B9B9ABD1D1
      D171FEFEFE020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ACB3B3B3BAB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BAB9B9B9ACD1D1
      D171FEFEFE02000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ACB3B3B3BAB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BAB9B9B9ACD1D1
      D171FEFEFE02000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ACB3B3B3BAB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BAB9B9B9ACD1D1
      D171FEFEFE02000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ACB3B3B3BAB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BAB9B9B9ACD1D1
      D171FEFEFE020000000000000000000000000000000000000000D8D8D8629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000D8D8D8629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000D8D8D8629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000D8D8D8629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D762000000000000000000000000D8D8D862989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D7620000000000000000D8D8D862989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D7620000000000000000D8D8D862989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D7620000000000000000D8D8D862989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D76200000000FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE02FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE02FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE02FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE02D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF959595FF939393FF939393FF939393FF9393
      93FF939393FF939393FF939393FF939393FF939393FF939393FF939393FF9393
      93FF939393FF939393FF939393FF939393FF959595FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF969696FF8E8E8EFF888888FF888888FF8F8F8FFF979797FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF959595FF959595FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF969696FF919191FF8D8D8DFF8B8B8BFF8A8A8AFF8A8A8AFF8C8C
      8CFF8E8E8EFF919191FF969696FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072B9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF8A8A8AFF9F9F9FFFA9A9A9FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA9A9A9FF9F9F9FFF8A8A8AFF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADB9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF919191FF8E8E8EFFD9D9D9FFFFFFFFFFFFFFFFFFCFCFCFFF888888FF9393
      93FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADB9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9595
      95FF9C9C9CFFA6A6A6FF959595FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADB9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9797
      97FF8D8D8DFF8C8C8CFFBDBDBDFFDEDEDEFFEFEFEFFFF3F3F3FFF1F1F1FFE6E6
      E6FFD5D5D5FFBCBCBCFF929292FF8A8A8AFF969696FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADB3B3B3BA989898FF989898FF9898
      98FF989898FF8A8A8AFFDEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDEFF8A8A8AFF9898
      98FF989898FF989898FF989898FFB3B3B3BAB3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF8C8C
      8CFFAAAAAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9B
      9BFF909090FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BAB3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF979797FF8787
      87FFFFFFFFFFE4E4E4FF8D8D8DFF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BAB3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF969696FF8686
      86FFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAFF989898FF969696FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BAB4B4B4B9989898FF989898FF9898
      98FF959595FF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FFF9595
      95FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF8D8D8DFFB2B2
      B2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF9F9F9FFF919191FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF898989FFDADA
      DAFFFFFFFFFFD4D4D4FF8E8E8EFF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF979797FF888888FFF8F8
      F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECECEFF909090FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA9A9A9FFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E5FFC7C7C7FFCACA
      CAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACA
      CAFFCACACAFFC7C7C7FFE5E5E5FFFFFFFFFFFFFFFFFFFFFFFFFFA9A9A9FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF919191FFA3A3A3FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF929292FF949494FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF929292FFA6A6A6FFFFFF
      FFFFFFFFFFFFC9C9C9FF8F8F8FFF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF888888FFE4E4E4FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E5FFC8C8C8FFC2C2C2FFCACA
      CAFFDEDEDEFFFFFFFFFFFFFFFFFFE6E6E6FF858585FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFE5E5E5FF808080FF8F8F8FFF8F8F
      8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F
      8FFF8F8F8FFF8F8F8FFF808080FFE5E5E5FFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF969696FF8E8E8EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF868686FF979797FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF949494FF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8C8C8CFF848484FFFFFFFFFFFFFF
      FFFFFFFFFFFFB6B6B6FF868686FF8D8D8DFF8D8D8DFF939393FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF949494FFA4A4A4FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF919191FF898989FF8F8F8FFF909090FF8F8F
      8FFF8C8C8CFF848484FFBDBDBDFF8D8D8DFF979797FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFC7C7C7FF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFC7C7C7FFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF878787FFEFEFEFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFD6D6D6FF8C8C8CFF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF939393FFA4A4A4FFDEDEDEFFDBDBDBFFDADADAFFDADADAFFDADA
      DAFFDADADAFFDADADAFFDADADAFFDADADAFFD7D7D7FFF6F6F6FFFFFFFFFFFFFF
      FFFFFFFFFFFFECECECFFD7D7D7FFDBDBDBFFDEDEDEFFADADADFF919191FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF969696FF959595FF8A8A8AFFE1E1E1FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF8C8C8CFF909090FF959595FF959595FF969696FF9898
      98FF989898FF979797FF929292FF979797FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFCACACAFF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFCACACAFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF939393FFA9A9A9FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF949494FF959595FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF979797FF8A8A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF959595FF9696
      96FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF969696FF9C9C9CFF9C9C9CFF8D8D8DFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFDFDFDFFF8E8E8EFF9A9A9AFF9A9A9AFF9C9C9CFF959595FF9696
      96FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFCACACAFF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFCACACAFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF898989FFEEEEEEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D5D5FF8E8E8EFF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF989898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9494
      94FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF939393FFB4B4B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEBEBFF8A8A
      8AFF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFCACACAFF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFCACACAFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF969696FF919191FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF868686FF979797FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9797
      97FF969696FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFCACACAFF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFCACACAFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF919191FFBBBBBBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA5A5A5FF949494FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF929292FF999999FFC3C3C3FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB1B1B1FFA8A8A8FFAAAAAAFFAAAAAAFFAAAAAAFFADADADFF9E9E
      9EFF959595FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFCACACAFF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFCACACAFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF8D8D8DFFDDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C6C6FF909090FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF959595FFA5A5A5FFA7A7A7FFC0C0C0FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFAEAEAEFFA5A5A5FFA7A7A7FFA7A7A7FFA7A7A7FFA7A7A7FFAEAE
      AEFF939393FF979797FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFCACACAFF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFCACACAFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF8A8A8AFFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E1E1FF8C8C8CFF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF949494FFABABABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFBBBBBBFF919191FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFC7C7C7FF8F8F8FFF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF8F8F8FFFC7C7C7FFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF878787FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3FF8A8A8AFF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF868686FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF8A8A8AFF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFE5E5E5FF808080FF8F8F8FFF8F8F
      8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F
      8FFF8F8F8FFF8F8F8FFF808080FFE5E5E5FFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF979797FF8A8A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF888888FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF969696FF979797FF939393FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFDADADAFF949494FF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E
      9EFFA5A5A5FF959595FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E5FFC7C7C7FFCACA
      CAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACA
      CAFFCACACAFFC7C7C7FFE5E5E5FFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF969696FF929292FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF878787FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF969696FF898989FFE5E5E5FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF858585FF929292FF959595FF959595FF959595FF9595
      95FF959595FF989898FF969696FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA8A8A8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF969696FF919191FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF878787FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF939393FFAAAAAAFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFF2F2F2FF848484FF8F8F8FFF949494FF959595FF9494
      94FF919191FF8A8A8AFF9B9B9BFF8E8E8EFF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF939393FFA9A9A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9A9FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF979797FF878787FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF898989FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF979797FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9393
      93FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF878787FFEEEEEEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2C2C2FFA2A2A2FF9D9D9DFFA5A5
      A5FFBABABAFFE0E0E0FFFFFFFFFFC4C4C4FF8C8C8CFF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF959595FF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FFF9595
      95FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF8C8C8CFFE9E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D5D5FF8E8E8EFF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF969696FF959595FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FF9494
      94FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF969696FF8A8A8AFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9A9FF949494FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF8A8A8AFFDEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDEFF8A8A8AFF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF8C8C8CFF868686FF878787FF9C9C9CFFC4C4
      C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6
      E6FFAFAFAFFF8D8D8DFF868686FF878787FF8E8E8EFF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF898989FFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8C8C8CFF9797
      97FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF959595FF8C8C
      8CFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FF929292FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF8A8A8AFF9F9F9FFFA9A9A9FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA9A9A9FF9F9F9FFF8A8A8AFF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF979797FF959595FF8F8F
      8FFF838383FFC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0A0A0FF8888
      88FF929292FF969696FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF979797FF8A8A8AFFA7A7A7FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FF8A8A8AFF969696FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B4B4B4B9989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9696
      96FF878787FFAAAAAAFFE2E2E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFAFAFAFFDEDEDEFFB7B7B7FF888888FF919191FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB4B4B4B9B3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF989898FF959595FF939393FF939393FF939393FF9393
      93FF939393FF939393FF939393FF939393FF939393FF939393FF939393FF9393
      93FF939393FF939393FF939393FF939393FF959595FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BAB3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF979797FF8C8C8CFF9C9C9CFFFFFFFFFFF8F8F8FF878787FF929292FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BAB3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF979797FF949494FF939393FF939393FF939393FF9393
      93FF939393FF939393FF939393FF939393FF939393FF939393FF939393FF9393
      93FF939393FF939393FF939393FF939393FF949494FF979797FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BAB3B3B3BA989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF939393FF8C8C8CFF878787FF8C8C8CFF949494FF8F8F8FFF8686
      86FF898989FF8D8D8DFF929292FF979797FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB3B3B3BAB9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADB9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF949494FF888888FF8B8B8BFF969696FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADB9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADB9B9B9AC989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF979797FF969696FF979797FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFB9B9B9ADD0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072D0D0D072989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFD0D0D072FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE02FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE02FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE02FEFEFE02989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FFFEFEFE0200000000D7D7D762989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D7620000000000000000D7D7D762989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D7620000000000000000D7D7D762989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D7620000000000000000D7D7D762989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FFD7D7D762000000000000000000000000D7D7D7629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000D7D7D7629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000D7D7D7629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D76200000000000000000000000000000000D7D7D7629898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FF989898FF989898FF989898FF989898FF989898FF989898FF9898
      98FF989898FFD7D7D7620000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ABB3B3B3BBB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BBB9B9B9ABD1D1
      D171FEFEFE02000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ABB3B3B3BBB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BBB9B9B9ABD1D1
      D171FEFEFE02000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ABB3B3B3BBB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BBB9B9B9ABD1D1
      D171FEFEFE02000000000000000000000000000000000000000000000000FEFE
      FE02D1D1D171B9B9B9ABB3B3B3BBB4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4
      B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B4B4B4B9B3B3B3BBB9B9B9ABD1D1
      D171FEFEFE02000000000000000000000000424D3E000000000000003E000000
      2800000080000000400000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF00E0000007000000000000000000000000
      C000000300000000000000000000000080000001000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      80000001000000000000000000000000C0000003000000000000000000000000
      E0000007000000000000000000000000E0000007E0000007E0000007E0000007
      C0000003C0000003C0000003C000000380000001800000018000000180000001
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      80000001800000018000000180000001C0000003C0000003C0000003C0000003
      E0000007E0000007E0000007E000000700000000000000000000000000000000
      000000000000}
  end
  object immMenu: TImageList
    Left = 6
    Top = 234
    Bitmap = {
      494C010107001000980110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DED2C6007949160079491600794916007949
      1600794916007949160079491600C1AB9500000000000000000000000000EFF6
      F9000A91B4000A91B400CFE6ED0000000000000000009FCEDC000A91B4000A91
      B400EFF6F9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A0000B3358000B3358000B3358000B33
      58000B3358000B335800A0A0A000FCFCFC000000000000000000000000000000
      000000000000000000000000000079491600C9966B00C7966B0079491600D0AA
      900079491600AA7D5500A6795200794916000000000000000000000000000A91
      B40058CCDE005CD7E6000A91B4000A91B4000A91B4000D99BA0021C9DE0015B8
      D1000A91B4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000E7E7E700E7E7
      E700E9E9E900E9E9E900E9E9E900E7E7E700E6E6E6000E5390003596D4003596
      D4000E539000DDDDDD00A0A0A000FCFCFC000000000000000000000000000000
      000000000000000000000000000079491600CF9D7000CF9C700079491600E9C7
      BA0079491600B2835B00A77A5300794916000000000000000000000000000A91
      B40080E3EF006FE0ED0059D5E60052D8E7003FCEE10036D0E30029CCE1001EC7
      DE000A91B4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000EAEAEA00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EAEAEA000E5390003596D4003596
      D4000E539000E1E1E100A0A0A000FCFCFC0088B1910013652400136524001365
      240013652400136524001365240079491600D5A57800D5A5780079491600F2D3
      C70079491600BA896000AB7D5500794916000000000000000000000000000A91
      B40088E5F00072DCE9004FC6DA0059CADD0052C9DC0033BFD5002EC9DE0021C1
      D8000A91B4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000EEEEEE002057
      7E0020577E0020577E0020577E0020577E00EDEDED000E5390003596D400004B
      82000E539000E3E3E300A0A0A000FCFCFC001365240028764100418964001365
      2400779A7200136524003477540079491600DEB08200D7A7790079491600F2D3
      C70079491600A3734300AD7F570079491600AFD6E2000A91B4000A91B40050C6
      DA006DD5E50075D5E3000A91B4000A91B4000A91B4000A91B40046C9DD0028C2
      D90013A7C5000A91B4000A91B400DFEEF3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000F0F0F0002057
      7E00F2F2F20020577E00F0F0F00020577E00EFEFEF000E5390003492D0004BBD
      FF000E539000E6E6E600A0A0A000FCFCFC001365240047926C0048936D001365
      2400BDBBA30013652400367B58006B6A3C0079491600B48451000F2843000F28
      43000F28430083592C00794916009C734A000A91B40036BFD70046C7DC006ADE
      EB0063CCDE000A91B400919191009191910091919100919191000A91B40040C2
      D8002DCCE10018B5D00011B0CB000A91B4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000F2F2F2002057
      7E0020577E0020577E0020577E0020577E00F2F2F2000E5390002C83C000247D
      B6000E539000E7E7E700A0A0A000FCFCFC00136524004F9D7500509E77001365
      2400F2D3C700136524003A805B0035785500635F2700794916000F2843001634
      54000F284300794916009A714600EDE8E1000A91B40047D5E60054D8E90049C9
      DC000A91B40091919100FEFEFE00FCFCFC00F4F4F400DDDDDD00919191000A91
      B4002DC5DA002ACCE1001EC7DE000A91B4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000F4F4F4002057
      7E00F6F6F60020577E00F6F6F60020577E00F4F4F4000E5390002373AF00277A
      B6000E539000EAEAEA00A0A0A000FCFCFC001365240055A57D0057A77F001365
      2400C7BBC00013652400317A4F0035785500136524006A7A8A000F2843000F28
      43000F28430030465C0000000000000000000A91B4002CBCD4004AD5E6003AC0
      D7000A91B40091919100F7F7F700F7F7F700F0F0F000DDDDDD00919191000A91
      B4002BBCD40034CFE20015ACC9000A91B4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000F6F6F6002057
      7E0020577E0020577E0020577E0020577E00F6F6F6000E5390000E5390000E53
      90000E539000EBEBEB00A0A0A000FCFCFC0097BB9E00136524002D6B5B003E65
      87003E6587003E6587001F5A48001365240087A893000F2843003E6491003559
      8400264870000F2843007E8C990000000000000000000A91B4002EBCD40034BF
      D5000A91B40091919100E1E1E100E9E9E900E2E2E200CFCFCF00919191000A91
      B40033BDD5001FABC7000A91B400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EAEEF10074828E00F7F7F700F8F8
      F800F8F8F800FAFAFA00F8F8F800F8F8F800F7F7F700EFF0F200EDEEEF00EBED
      EE00E9EAEB00EDEDED0074828E00E7EBEE0000000000214C6000235065003E65
      87005E86B6003E658700214C6000214C60006A7A8A000F284300557EAD00486F
      9E00365B87000F284300253D54000000000000000000DFEEF3000A91B40044D4
      E6000A91B40091919100AAAAAA00C9C9C900C5C5C500A6A6A600919191000A91
      B40056D8E9000A91B40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000007396300073963005B7A9300E7EB
      EE00FAFAFA00FAFAFA00FAFAFA00F8F8F800F8F8F800F6F6F600F4F4F400F2F2
      F200DEE2E6005A799200073963000739630000000000214C6000345D7A006891
      C2006C97C900668FC100345C7A00214C60008F8F8F000F28430053769F003B57
      780037577D000F284300404346000000000000000000AFD6E2000A91B4003BD1
      E30035C4D9000A91B400919191009191910091919100919191000A91B40055CB
      DE0062DCEA000A91B400CFE6ED00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B2BFCA0016406500043F6D001945
      6A00B2C2CF00FBFBFB00FBFBFB00FAFAFA00F8F8F800F7F7F700F6F6F600ACBC
      C90018456A00053D6A00153F6500B2BFCA0000000000214C6000658BB80080AB
      D5007DA9D400729CCE006389BB00214C6000A8A8A800050505000D0D0D001516
      16000D0E0E00050505003F3F3F0000000000000000000A91B40028CBE10033CF
      E2003ED3E50038C4D9000A91B4000A91B4000A91B4000A91B40072D7E6007DE2
      EE006CDEEB005DDAEA000A91B400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFF2F40057738C00063C
      6800063C68003E627E00E9EDEF00FAFAFA00F8F8F800E5E9ED003F627F00063C
      6800063C68000B335800EFF2F4000000000000000000214C600051799D009DC7
      E50096C1E2007EA9D4004E769E00214C60000000000019191900050505000505
      05000505050006060600E0E0E00000000000000000000A91B4001EC0D80024C2
      D9000A91B40041D3E5004DD7E70059D9E90067DDEB0074E1ED0077DDEA000A91
      B40078E1EE0060D7E6000A91B400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C1CB
      D500264E7000053D6A00103C6300809AAD007B96AB00103C6300053D6A002965
      8A0029658A0029658A00215C830000000000000000004A6D7D00214C60003E65
      87003E6587003E658700214C600045697A000000000000000000A8A8A8008F8F
      8F008F8F8F0000000000000000000000000000000000EFF6F9000A91B4000A91
      B400AFD6E2000A91B4000A91B40050D7E7005CDAEA000A91B4000A91B400AFD6
      E2000A91B4000A91B400EFF6F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFF2F40052708B0007396300073D6900053D6A00073963000D4772000D47
      7200165179001B567E00215C830000000000000000008FA5AF00214C6000214C
      6000214C6000214C6000214C60008FA5AF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000A91B40047D4E60053D8E7000A91B400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C1CBD500284E6F00284E6F00C1CBD500000000000000
      00000000000000000000000000000000000000000000000000008FA5AF005778
      870057788700577887008FA5AF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000054AFC8000A91B4000A91B4008FC5D700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000068686800686868006868
      6800676767006767670067676700676767006767670066666600666666006666
      66006666660066666600000000000000000000000000C7B0A100823909008239
      0900604629006C6C6C006D6D6D00666666007B7B7B006D6D6D00646464005353
      5300604629007E2801006528030093685200000000002D6782002D6782002D67
      82002D6782002D6782002D6782002D678200132D3C001E4863001E4863001F41
      5700212F380028415100FFFFFF00FFFFFF000000000000000000000000000000
      0000F3EEEC13CFA4926DB46D4EB1AB5630D3AB5630D3B46D4EB1CFA3916EF3EE
      EC13000000000000000000000000000000000000000076767600FCFCFC00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F6F6F600F6F6F600F6F6
      F600FCFCFC0074747400000000000000000000000000843A0900B6510D00B751
      0E0060462900696969007E2801007E280100A4A4A400AAAAAA00909090006D6D
      6D00604629007E2801007D2F0300782C04003D7E9A0051A3C60051A3C60051A3
      C60051A3C60051A3C60051A3C60051A3C6001E4A62003387B5003387B5002A54
      6C00E99566002A425200FFFFFF00FFFFFF00000000000000000000000000D0A4
      926DA8481CF1C55F2CFFD16731FFD0642DFFD0642DFFD06630FFC35D29FFA847
      1BF1D0A4926D0000000000000000000000000000000081818100F7F7F700E0E0
      E000E1E1E100E1E1E100E1E1E100E1E1E100E0E0E000E0E0E000DEDEDE00DDDD
      DD00F6F6F6007F7F7F0000000000000000000000000090410A00BB560F00BC56
      0F0060462900646464007E2801007E280100B6B6B600C1C1C100A1A1A1007979
      7900604629007E2801007D300400782C040041829F0054A7CA0054A7CA0054A7
      CA0054A7CA0054A7CA0054A7CA0054A7CA0052738300BDBDBD00BDBDBD002F63
      7E00E99566002E4F6500FFFFFF00FFFFFF000000000000000000BF816798C05B
      2BFFDF7441FFCE5D29FFBE511CFFC68E73FFC48B6FFFB94A15FFC04F18FFCE62
      2BFFBA5322FFBF8167980000000000000000000000008B8B8B00F8F8F800E3E3
      E300E5E5E500E5E5E500E5E5E500E5E5E500E3E3E300E2E2E200E1E1E100E0E0
      E000F7F7F7008A8A8A0000000000000000000000000093440C00C05B1100C15C
      1100604629005E5E5E007E2801007E280100C6C6C600DADADA00B8B8B8008686
      8600604629007E2801007F320400792D04004687A30057ACCE0057ACCE0057AC
      CE0057ACCE0057ACCE0057ACCE0057ACCE005D7F8F00DCDCDC00BDBDBD003872
      9000DCDCDC0034586F00FFFFFF00FFFFFF0000000000CFA3906FC45E2FFFEA7E
      50FFDF6F40FFD66634FFC4714CFFFFFFFFFFFFFFFFFFB66036FFBF4D16FFBF4D
      16FFC95A23FFBA5422FFCFA3906F000000000000000095959500F8F8F800E7E7
      E700E7E7E700E9E9E900E9E9E900E7E7E700E7E7E700E6E6E600E5E5E500E3E3
      E300F8F8F8009292920000000000000000000000000097480D00C5621500C664
      160060462900595959005959590059595900C9C9C900F3F3F300D0D0D0009696
      9600604629007E280100803304007B2E05004B8BA6005AB1D1005AB1D1005AB1
      D1005AB1D1005AB1D1005AB1D1005AB1D100637A8000E2C2A700BDBDBD003C75
      9300DCDCDC00385F7500FFFFFF00FFFFFF00F3EDEB14AB4A1FF2F0865CFFEC7D
      54FFE7784CFFE07142FFCD7F5DFFFFFFFFFFFFFFFFFFBA6841FFBF4D16FFBF4D
      16FFBF4D16FFCE622BFFA8461AF2F3EDEB14000000009A9A9A00FAFAFA00EAEA
      EA00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EAEAEA00EAEAEA00E9E9E900E6E6
      E600F8F8F800999999000000000000000000000000009A501600CA6E2300CB70
      260092561F006046290060462900604629006046290060462900604629006046
      29006A371100772E0300893A07007D2F05005091AA005DB6D5005DB6D5005DB6
      D5005DB6D5005DB6D5005DB6D5005DB6D50065869500E0E0E000BDBDBD003F79
      9700DCDCDC003E667A00FFFFFF00FFFFFF00CEA08D72D16B3FFFEB7D58FFED7E
      58FFEC7E55FFE8794DFFD48767FFFFFFFFFFFFFFFFFFBF6D46FFC15019FFBF4D
      16FFBF4D16FFC04F18FFC45D2AFFCFA18D7200000000A1A1A100FBFBFB00EDED
      ED00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EDEDED00EBEBEB00EAEA
      EA00FAFAFA00A0A0A0000000000000000000000000009E592000BB6A2C00C495
      6F00C1926D00BF8F6A00BC8C6700BA886200B6835C00B5815A00B4805900B27F
      5900B17E5800B07D5800A3460F007E3005005596AF0060BBD90060BBD90060BB
      D90060BBD90060BBD90060BBD9005DB6D500697F8400E2C2A700BDBDBD00427E
      9A00DCDCDC00446C8000FFFFFF00FFFFFF00B26949B6E57B53FFE57553FFEA7B
      57FFED7E58FFED7E55FFD98C6EFFFFFFFFFFFFFFFFFFC6744FFFC95722FFC250
      1AFFBF4D16FFBF4D16FFD16630FFB26949B600000000A5A5A500FBFBFB00EFEF
      EF00F0F0F000F2F2F200F2F2F200F0F0F000F0F0F000EFEFEF00EEEEEE00EDED
      ED00FAFAFA00A5A5A500000000000000000000000000A1632D00C4865300EBEB
      EB00E7E7E700E2E2E200DDDDDD00D9D9D900D4D4D400D0D0D000CBCBCB00CACA
      CA00CACACA00CACACA00A95D2B007F3205005A9CB20064C1DD0064C1DD0064C1
      DD0064C1DD0064C1DD0064C1DD0064C1DD00547B8E00759FB200BDBDBD004992
      B5004F839C0055768700FFFFFF00FFFFFF00AB542ED8DF734FFFDD6B4CFFE474
      52FFEA7A56FFED7E58FFDB8F73FFFFFFFFFFFFFFFFFFCD7C59FFD2622FFFCA59
      24FFC3511BFFBF4D16FFCF632CFFAB532CD800000000A9A9A900FBFBFB00F2F2
      F200F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F2F2F200F0F0F000EEEE
      EE00FBFBFB00A7A7A700000000000000000000000000A56B3800C2885A00DCDC
      DC00D8D8D800D4D4D400D1D1D100CECECE00CACACA00C7C7C700C4C4C400C0C0
      C000BDBDBD00BBBBBB00A65B28007F3306005FA0B60067C6E10067C6E10067C6
      E10067C6E10067C6E10067C6E10067C6E1006AB1CA005F899A007896A3005BA3
      C50056809200E9EDF000FFFFFF00FFFFFF00AA532DD9D86948FFD36043FFDC6A
      4BFFE37351FFE97A56FFDB8E74FFFFFFFFFFFFFFFFFFD48463FFDC6D3DFFD463
      31FFCB5A25FFC4521CFFCF632CFFAA532BD900000000ABABAB00FCFCFC00F4F4
      F400F6F6F600F6F6F600F6F6F600F6F6F600F4F4F400F3F3F300F2F2F200F0F0
      F000FBFBFB00ABABAB00000000000000000000000000A9734300CC966A00FEFE
      FE00FBFBFB00F7F7F700F2F2F200EEEEEE00E9E9E900E5E5E500E0E0E000DADA
      DA00D7D7D700D1D1D100AB5F2D008033060065A5BA006ACBE5006ACBE5006ACB
      E5006ACBE5006ACBE5006ACBE5006ACBE5006ACBE50069BBD10077909A0064A0
      BB0056809200FFFFFF00FFFFFF00FFFFFF00B16847B8D16542FFC85339FFD25E
      42FFDB694AFFE27251FFD7795BFFF6EFEDFFF5EDEAFFDA7B56FFE57649FFDE6E
      3EFFD56432FFCC5B27FFD56B35FFB26847B800000000ACACAC00FCFCFC00F6F6
      F600F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F6F6F600F3F3F300F2F2
      F200FBFBFB00ACACAC00000000000000000000000000AA784C00C7936B00E1E1
      E100E1E1E100E1E1E100E0E0E000DDDDDD00D9D9D900D7D7D700D3D3D300CFCF
      CF00CCCCCC00C9C9C900AA5E2B00803306006AABBF006DD0E9006DD0E9006DD0
      E9006DD0E9006DD0E9006DD0E9006DD0E9006DD0E9006DD0E9007A919C006EA7
      C20056809200FFFFFF00FFFFFF00FFFFFF00CD9E8A75C25931FFBE4931FFC752
      38FFD15D41FFDA6749FFDF6F4FFFC77D66FFCA8168FFEB7D57FFEC7D53FFE677
      4BFFDF6F40FFD76735FFCA6431FFCD9E8A7500000000ADADAD00FCFCFC00F7F7
      F700F8F8F800F8F8F800FAFAFA00F8F8F800F8F8F800F7F7F700F6F6F600F3F3
      F300FCFCFC00ADADAD00000000000000000000000000AB7A5000CF9D7500FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FCFCFC00F8F8F800F4F4F400EFEF
      EF00EBEBEB00E6E6E600B1653000813406006EB0C20070D5ED0070D5ED0070D5
      ED0070D5ED0070D5ED0070D5ED0070D5ED0070D5ED0070D5ED006E8A960078AF
      C70056809200FFFFFF00FFFFFF00FFFFFF00F2EBE817A7441AF5C55437FFBB45
      2EFFC55037FFCF5B40FFC9735DFFFCFBFBFFFCFBFBFFD98569FFED7E58FFEC7D
      54FFE7784CFFE67C4BFFAA481CF5F2EBE81700000000AFAFAF00FEFEFE00F8F8
      F800FAFAFA00FAFAFA00FAFAFA00FAFAFA00F8F8F800F7F7F700AFAFAF00BCBC
      BC00D0D0D000B2B2B200000000000000000000000000AB794D00C7956C00E1E1
      E100E1E1E100E1E1E100E1E1E100E1E1E100E1E1E100E1E1E100E1E1E100DEDE
      DE00DCDCDC00D8D8D800AD622D008034060074B5C60074DAF00074DAF00074DA
      F00074DAF00074DAF00074DAF00074DAF00074DAF00074DAF000728B970081B6
      CE0056809200FFFFFF00FFFFFF00FFFFFF0000000000CD9D8976B85026FFBC49
      2FFFBA432DFFC44E36FFC16955FFFCFBFAFFFCFBFBFFD48066FFEB7C57FFED7E
      58FFEF8358FFC66131FFCD9D89760000000000000000AFAFAF00FEFEFE00FAFA
      FA00FAFAFA00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F8F8F800BCBCBC00D9D9
      D900B4B4B400EFEFEF00000000000000000000000000AB794D00BB835A00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FAFAFA00AA603000762D040079BACB0077E0F60077E0F60077E0
      F60077E0F60077E0F60077E0F60077E0F60077E0F60077E0F600758E98008ABC
      D30056809200FFFFFF00FFFFFF00FFFFFF0000000000FEFEFE01BB7B5FA0B850
      26FFC35235FFBA442DFFC04C34FFBF6854FFC7705AFFDC6C4CFFE67653FFEE84
      5BFFC76234FFBB7B5FA0FEFEFE010000000000000000AFAFAF0000000000FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F8F8F800D0D0D000B4B4
      B400EFEFEF0000000000000000000000000000000000AB794D00BB835A002A16
      79002A1679002A1679002A1679002A1679002A1679002A1679002A1679002A16
      79002A1679002A167900AA603000762D04007FC0CF007AE5FA007AE5FA007AE5
      FA007AE5FA007AE5FA007AE5FA007AE5FA007AE5FA007AE5FA005477870092C1
      D70056809200FFFFFF00FFFFFF00FFFFFF000000000000000000FEFEFE01CD9D
      8877A74319F6C15830FFCD5F3EFFD16242FFD86A48FFDF754FFFD16A3FFFAC49
      1DF6CD9D8877FEFEFE01000000000000000000000000AFAFAF00AFAFAF00AFAF
      AF00AFAFAF00AFAFAF00AFAFAF00AFAFAF00AFAFAF00AFAFAF00B4B4B400EFEF
      EF000000000000000000000000000000000000000000986D4E0074352500340D
      5900340D5900340D5900340D5900340D5900340D5900340D5900340D5900340D
      5900340D5900340D59006B261400905D4000A2D3DD0084C5D30084C5D30084C5
      D30084C5D30084C5D30084C5D30084C5D30084C5D30084C5D3006E8995007BA8
      B600AABFC800FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000F2EAE718CC9B8679B06443BCA95029DEAA5029DEB06443BCCC9B8679F2EA
      E71800000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFE00E18700008000FE00E0070000
      8000FE00E007000080000000E007000080000000000000008000000000000000
      8000000000000000800000030000000080000001800100000000800180030000
      000080018001000000008001800100008001808180010000E00180C780010000
      F00180FFFC3F0000FC3FC1FFFC3F0000800380008000F00F800380000000E007
      800380000000C003800380000000800180038000000000008003800000000000
      8003800000000000800380000000000080038000000000008003800000000000
      8003800000000000800380000000000080038000000080018003800000008001
      A00780000000C003800F80000000F00F00000000000000000000000000000000
      000000000000}
  end
  object immUI: TImageList
    Left = 10
    Top = 120
    Bitmap = {
      494C010107001000700110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      000000000000000000000000000000000000FCF9F60AE8D7B94EE9D9BC4B0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EDE0C83EBC8528FFBD872AFFBA83
      24FFC79A4ACDECDABB4D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000339A36CE0E8E18FF0B8A15FF0A8814FF098512FF38943AC70000
      000000000000000000000000000000000000000000000000000000000000CDCD
      FA41F8F8FE08000000000000000000000000000000000000000000000000F8F7
      FE08C5C4F7410000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EEE1CA3CBE882BFFBF8A2EFFBF8A
      2EFFBF8A2EFFBC8627FD00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000349D38CE51DA7BFF3ACF69FF39CD67FF32C25BFF38973BC70000
      0000000000000000000000000000000000000000000000000000D0CFFB414E4B
      F2FF403EEDFDF8F8FE0800000000000000000000000000000000F8F8FE082523
      E4FC302EEAFFC5C5F74100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1AA67B0C18C30FFC18D
      32FDC18D31FFBF8B2DF8DFC3947BECD5AD600000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000359E39CE5CE084FF3ED46EFF3DD36DFF34C55FFF39983BC70000
      00000000000000000000000000000000000000000000D3D2FB415755F5FF6260
      FAFF5754F6FF4240EDFCF8F8FE080000000000000000F8F8FE082D2BE6FC403E
      F1FF4B49F6FF302EEAFFC5C5F741000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D2AC68B0C38F
      33FFC39035FFC39035FFC39136FFCC9E4DD60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000359F3ACE64E48AFF41D771FF3FD56FFF37C861FF39993CC70000
      00000000000000000000000000000000000000000000E2E2FD2B5A57F6FF6461
      FAFF706FFFFF5855F6FF4341EEFCF8F8FE08F8F8FE083633E9FC4644F2FF6261
      FFFF4947F4FF2E2CE9FFD9D9FA2B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D4AE
      6AB0C59237FFC6933AFDC69339FFC99741E50000000000000000000000000000
      0000000000000000000000000000000000000000000031A538D431A439D430A2
      38D430A137D416941EF056E282FF44DA74FF41D872FF39CB64FF158B1BEC3396
      36CE339535CE329335CE319134CE000000000000000000000000E3E2FD2B5A58
      F6FF6562FAFF7370FFFF5957F6FF4442EEFC3E3CECFD4F4CF4FF6766FFFF4F4D
      F5FF3533EBFFDADAFA2B00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D7B26EAFC8953DFFC9963DFFC8963EFFD4AB62BEE6CC9D76DCB36BB6DEB8
      75A9EEDBB6590000000000000000000000000000000021A72DFF60E487FF4BDD
      79FF4ADC78FF49DC77FF4AE07AFF46DD77FF44DB75FF40D670FF3BCD67FF39CB
      65FF36C862FF33C45EFF0A8413FF00000000000000000000000000000000E3E2
      FD2B5B59F6FF6663FAFF7371FFFF726FFFFF6F6DFFFF6D6BFFFF5654F7FF3E3C
      EEFFDCDBFB2B0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DAB370AFCB9941FFCB9943FDCB9941FFCB9942FFCB9943FFCB99
      43FFCB9840FFD1A352D600000000000000000000000022A92FFF76F099FF5EEA
      8AFF5AE888FF56E684FF53E481FF4EE17DFF47DE78FF44DB75FF41D872FF3FD5
      6FFF3DD36DFF39CD67FF0B8715FF000000000000000000000000000000000000
      0000E3E2FD2B5C5AF7FF7875FFFF5855FFFF5653FFFF716FFFFF4745F0FFDDDD
      FB2B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DDB776ABCE9C44FFCE9D46FFCE9D46FFCE9D46FFCE9D
      46FFCE9D46FFCC9D47FFDBB46FB4000000000000000024AB30FF7EF39FFF68EE
      91FF64ED8EFF60EA8BFF59E886FF54E482FF4EE17DFF46DD77FF44DA74FF41D7
      71FF3ED46EFF3ACF69FF0C8916FF000000000000000000000000000000000000
      0000FAF9FE085D5AF6FD7C78FFFF5D5AFFFF5A57FFFF7573FFFF4643EFFDF9F8
      FE08000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EDD4A86FCFA04AFFCF9F4AFFCF9F4AFDCFA04AFFCFA0
      4BFFCFA04BFFD0A04BFDCF9E43FFFCF8F2100000000025AD32FF91F7ABFF8DF6
      A8FF8BF5A6FF89F4A5FF7AF09BFF59E886FF53E481FF4ADF7AFF5BE486FF67E5
      8CFF5EE186FF53DB7CFF0F8D1AFF00000000000000000000000000000000FAFA
      FE086663F9FC6F6CFBFF7F7DFFFF7D7AFFFF7B78FFFF7876FFFF5D5BF7FF4845
      EFFCF9F8FE080000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E9C27FABD3A451FFD3A44FFFD3A44FFFD3A148FFE5C6
      8E93E0B976B2D3A24DFFD2A24DFFF3E4C9450000000038AF41CE39AE41CE38AC
      40CE38AA40CE1A9C23EF89F4A5FF60EA8BFF56E684FF45D872FF199520EC359F
      3BCE359D3ACE359B39CE349A38CE000000000000000000000000FAFAFE086E6B
      FCFC7673FDFF8581FFFF7572FCFF6361F8FF5F5CF7FF6C69FAFF7A78FFFF5F5C
      F7FF4946EFFCF9F9FE0800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ECC98A9DD4A755FFD5A753FFD4A755FFE6C58B9A0000
      000000000000DBAE5ADFD6A54FFFF6EAD5360000000000000000000000000000
      00000000000038AA40CE8BF5A6FF64ED8EFF5AE888FF45D771FF3CA442C70000
      00000000000000000000000000000000000000000000FAFAFF087471FEFD7C79
      FEFF8986FFFF7B78FDFF6B68FBFFE4E4FD2BE3E3FD2B605DF8FF6D6BFAFF7C79
      FFFF605EF7FF4A47F0FCFBFBFE05000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7E7CA48D8A853FFD6AA56FFD6AA57FFE2B96FC20000
      000000000000DAA950F6D9A64AFE000000000000000000000000000000000000
      00000000000039AC41CE8DF6A8FF68EE91FF5EEA8AFF46D872FF3CA642C70000
      00000000000000000000000000000000000000000000EEEDFF1F7976FFFF807D
      FFFF807DFEFF7370FDFFE6E5FE2B0000000000000000E4E3FD2B615EF8FF6E6C
      FBFF7D7BFFFF615EF8FFAFAEF86FFDFDFE020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E3BB70C2D8AB59FFD8AC5CFED9AB59FFDDAD
      56ECDBAA50FAD9AA55FFF2DFBC5B000000000000000000000000000000000000
      00000000000039AD41CE91F7ABFF7FF39FFF76F099FF58DF7FFF3DA743C70000
      0000000000000000000000000000000000000000000000000000EEEDFF1F7976
      FFFF7875FEFFE7E6FE2B00000000000000000000000000000000E4E3FD2B6360
      F8FF6967F9FF8D8BF7A8E2E2FC29000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E9C98B9FDCAB51FFDCAD59FFDBAC
      57FFDDAB50FCF3E0BF5800000000000000000000000000000000000000000000
      00000000000039AF42CE26AD33FF25AB32FF23A930FF21A62EFF3DA944C70000
      000000000000000000000000000000000000000000000000000000000000EEED
      FF1FE7E7FF2B000000000000000000000000000000000000000000000000E4E3
      FD2BB8B7FB6FD6D5FC3E00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFDFC04F7ECD637F9F1
      E129000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8FE0A0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5E4E43AA6A6A6FFA6A6A6FFA6A6A6FFA6A6A6FFA6A6A6FFA6A6
      A6FFA6A6A6FFA6A6A6FFA6A6A6FFE4E3E3350000000000000000000000000000
      00000000000000000000CAC7C79CB2B2B2FFB2B2B2FFB2B2B2FFB2B2B2FFB2B2
      B2FFB2B2B2FFB2B2B2FFB2B2B2FFE3E3E3330000000000000000000000000000
      000000000000FEFEFE01E9D7B94FDEC49775DEC49775E9D7B94FFDFCFA050000
      0000000000000000000000000000000000000000000000000000FAF7F010FAF7
      F10FFAF7F10FFAF7F10FFAF7F10FFAF7F10FFAF7F010FAF6EF11FAF7F10FFAF7
      F10FFCFBF7080000000000000000000000000000000000000000000000000000
      000000000000A6A6A6FFFAF6F5FFF7F0EDFFF7EEEAFFF6ECE8FFF5EAE6FFF4E9
      E5FFF4E8E4FFF4E8E4FFF8F3F1FFA6A6A6FFE1ECF41F4C9BDBB73D92D9D13D91
      D9D13D8FD9D1408FD8D1B2B2B2FFF6ECE9FEF4E9E5FEF3E6E2FEF2E4DEFEF1E1
      DCFEF1E0DAFEF1E0DAFEF2EBE8FEB2B2B2FF000000000000000000000000FEFD
      FC03D5B170A2C08C35E5EFE3CE36F9F4EC15FAF5EC15F0E0C641D7B67C94D6B3
      769BFEFDFB0400000000000000000000000000000000CA9F55C3BE8627FFBD85
      27FFBD8527FFBD8527FFBD8527FFBE8727FFBB8425F8BE892DEEBD8728FFBE86
      27FFBE8626FFE2C89A7400000000000000000000000000000000000000000000
      000000000000A6A6A6FFF9F4F2FFF5E9E5FFF4E6E1FFF2E2DCFFF1DFD8FFEFDB
      D4FFEED9D1FFEED8D0FFF5EBE7FFA6A6A6FF70B0E19671DCF6FF71EAFFFF6ADF
      FFFF64D5FFFF60CDFFFFB2B2B2FFF6ECE8FFF2E6E2FFF0E2DDFFEEDFD9FFEDDB
      D5FFECD8D1FEEDD7D0FEF0E7E4FEB2B2B2FF0000000000000000F9F2E61CCEA5
      5FB6EEE1CA3BBE882BFFD6B4799900000000000000000000000000000000FBF8
      F20ECDA35BBAF9F4EA180000000000000000EEE0C83EE0C89D6FBF8A2EFFC08A
      2FFDC08A2EFFC08A2FFDC08A2EFFBE8728FFF5EEE122EFE3CD38D5B2769CBF89
      2EFFC08A30FFC29038E80000000000000000E8E8E824E0DFDF31E0DFDF31E0DF
      DF31DFDFDF31A6A6A6FFFAF6F4FFE6DEDBFFD8CFCDFFD5CBC8FFD4C9C5FFD3C6
      C2FFD1C3BFFFDBCAC5FFF6ECE8FFA6A6A6FF62AADEA47AEFFCFF67F4FFFF5FE7
      FFFF56D8FFFF4DCAFFFFB2B2B2FFF1E9E6FFDDD5D3FFDAD1CFFFD9CECBFFD7CB
      C8FFD5C8C4FEE3D2CCFEF1E8E5FEB2B2B2FF00000000FEFDFB04CFA660B80000
      000000000000C69844DCC18D31FFD1AA65B30000000000000000000000000000
      0000FEFDFC03BE8525FD0000000000000000E7D1AD5EECDCBF49C18B2EFFC28E
      32FFC18E31FFC28E31FFC28D33FFD8B87F94D9B98192C18B30FFE6D2AF5CE3CC
      A469C18B2FFFC18B2FFFF8F0E22200000000CCCCCCFFCCCCCCFFCCCCCCFFCCCC
      CCFFCCCCCCFFA6A6A6FFFAF6F5FFEFE8E5FFE8E0DDFFEFE5E2FFE7DDD9FFE3D7
      D3FFE2D4CFFFE6D6D1FFF6EEEBFFA6A6A6FF62ACDEA47CF0FCFF6DFCFFFF67F4
      FFFF5FE7FFFF56D8FFFFB2B2B2FFF0E9E6FFDCD5D3FFE4DDDAFFE1D8D5FFDDD3
      D0FFDBD0CCFEE4D6D1FEF2EBE8FEB2B2B2FF00000000DBB97B9BFCF9F40C0000
      0000F3E9D72FC18C30FFC39036FFC39036FFE7CD9F7100000000000000000000
      0000FDFCF907C28D30FFDBBA7E9800000000E8D5B25ADFC4937ECB9F50D3C391
      37FFC59037FFC39138FDC28F32FFF7F0E320C38E2FFFC49138FEC49035FFDBBC
      8590F0E3CC3BC38E32FFE4C7957F00000000CCCCCCFFECE3DFFFEADCD8FFE8D9
      D4FFE7D6D0FFA6A6A6FFFAF6F5FFF0E8E6FFE9E2DFFFF1E9E6FFDBD4D1FFEDE4
      E1FFECE1DDFFDBCFCBFFF8F0EEFFA6A6A6FF62ADDEA47CEFFCFF6FFEFFFF6DFC
      FFFF67F4FFFF5FE7FFFFB2B2B2FFF5EEEBFFECE5E3FFF0E9E6FFE1DAD8FFF7EF
      EBFFF6ECE8FEDFD4D1FEF3EDEBFEB2B2B2FFFDFCF906DDBC8195000000000000
      0000E0BD7E9BC6943CFFC59137FFDCBD8491FAF2E4200000000000000000F8EE
      DC2AE6CFA767C59237FFC59032FF00000000EBD8B756CC9D48E1E5CCA170C895
      3CFFC8953CFFC8953DFFD6AE6AB4E5CCA26FC7953DFFC8953CFFC8953CFFC795
      3CFFD3A85EC4F3E9D631CC9B44E000000000CCCCCCFFEEE7E4FFD7CECBFFD3C9
      C6FFD0C5C2FFA6A6A6FFFAF6F5FFE7DFDDFFD8D1CFFFE8E0DEFFDFD8D6FFF8F0
      EDFFF7EEEBFFDFD5D2FFF9F3F1FFA6A6A6FF62AFDEA47BEBFCFF6FFAFFFF6FFE
      FFFF6DFCFFFF67F4FFFFB2B2B2FFF3ECE9FFE7E0DEFFECE5E2FFE1DAD8FFF8F0
      EDFFF8F0EDFEE1D9D6FEF5F0EEFEB2B2B2FFEDDBBC50F2E4CB3E000000000000
      0000E5CB9D76D0A14EDBE8CEA172000000000000000000000000F3E3C448C894
      39FFC8953CFFC8963EFFC8953DFFEFE0C545EDDBBA53CA963CFFF2E5CF3AC997
      3CFFCB9942FFC9973EFFF4EAD730CB973CF8CB9942FFCB9942FDCB9941FFCF9E
      48E6E1C38E8AF8F2E61EC89333FFFAF5ED16CCCCCCFFEFE8E6FFE7DFDDFFE4DC
      D9FFE5DBD7FFA6A6A6FFFAF6F5FFF0E8E6FFE9E2DFFFF1E9E6FFDCD5D3FFEFE7
      E5FFEFE7E4FFDED6D4FFFAF6F4FFA6A6A6FF62B0DEA47AE7FCFF6EF3FFFF6FFA
      FFFF6FFEFFFF6DFCFFFFB2B2B2FFF0E9E6FFDCD5D3FFE5DDDBFFDFD8D6FFDFD8
      D6FFDED7D5FEE6DFDCFEF5F1F0FEB2B2B2FFE5CC9D77FCF9F40DF8F1E322DDB8
      79A4FAF6EF130000000000000000000000000000000000000000F6E8CF3BCB97
      3EFFCB9943FFCB973BFFC99638FFE8D1A86AEEDCBB53CE9D47FFEAD3AB68D7AF
      64C4CE9B42FFCC9939FFF5EBD92FDAB36DB9DFBC809CCE9C45FFCE9D47FFE3C5
      908BE2C38C8FCD9737FFCE9B42FFECD7B35ECCCCCCFFEFE8E6FFD6CFCDFFD1CA
      C8FFDDD6D3FFA6A6A6FFFAF6F5FFEFE8E5FFE8E1DEFFF0E8E5FFEAE2E0FFE7DF
      DDFFE6DEDCFFE9E2DFFFF7F3F2FFA6A6A6FF62B1DEA479E1FCFF6CEAFFFF6EF3
      FFFF6FFAFFFF6FFEFFFFB2B2B2FFF8F0EDFFF8F0EDFFF8F0EDFFF8F0EDFFF8F0
      EDFFF2EAE7FED8D1CEFED9D5D4FEB2B2B2FFE8CEA274F4E8D237D3A24EE0E8D0
      A371EFDCBB54000000000000000000000000000000000000000000000000EBD5
      AE65DEBA7BA7F6EDDC2BFCFAF60BE8CDA075EFDDBC54D1A24CFFD19F46FAECD5
      AD68EED9B55DEED9B55DF1E1C34BF1E1C44BF7EEDE29D19F46FFD1A14DFFEAD1
      A473F5EBD732FDFAF50CFDFAF40D00000000CCCCCCFFEFE8E6FFD9D2D0FFD5CF
      CDFFDED7D4FFA6A6A6FFFAF6F5FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
      EEFFE8E0DEFFBFB9B7FFC2BFBEFFA6A6A6FF62B2DEA477DCFCFF68E0FFFF6CEA
      FFFF6EF3FFFF6FFAFFFFB2B2B2FFF8F0EDFFF8F0EDFFF8F0EDFFF8F0EDFFF8F0
      EDFFDCD5D3FEC9C7C8FEB2B2B2FFECECEC1DF2E3C844D09C3CFFD09F4AFFD09F
      4BFFCF9E45FFF0DCBA570000000000000000000000000000000000000000F4E0
      BD54DBB066C2DDB773B4D09C3FFFF2E3C845F0DDBC56D3A451FFD4A551FFD4A5
      52FFD4A450FFD4A450FFD3A54FFFDDB264CAF5E8D13BD4A44FFFD3A34BFFF8EF
      E028FAECD23B000000000000000000000000CCCCCCFFEFE8E6FFE7DFDDFFE5DD
      DBFFE1DAD8FFA6A6A6FFFAF6F5FFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
      EEFFD6CFCDFFDAD8D9FFA6A6A6FFF3F3F31262B3DEA475D8FCFF66D6FFFF69E0
      FFFF6CEAFFFF6EF3FFFFB2B2B2FFF9F5F3FFF9F5F3FFF9F5F3FFF9F5F3FFF9F5
      F3FFDFDAD9FEB2B2B2FFEBEAEA220000000000000000D3A048FFD1A34EFFD1A3
      4EFFD3A24DFFD2A149FFE1BA74B2FEF8EF150000000000000000000000000000
      0000E7C8928CDEB66EBFD7A750E6FEFEFD02F3E3C54BD6A650FFD7A74FFFD7A7
      4FFFD7A750FFD6A751FFD8A549FF00000000E8C99192D4A959FFE0B86DC50000
      000000000000000000000000000000000000CCCCCCFFEFE8E6FFD5CECCFFCFC9
      C7FFE2DAD8FFA6A6A6FFFBF9F9FFFBF7F6FFFBF7F6FFFBF7F6FFFBF7F6FFFBF7
      F6FFD9D6D5FFA6A6A6FFF3F3F3120000000062B3DEA474D5FCFF63CFFFFF65D5
      FCFF64D6F3FF66DFF2FF89C6CDFFB2B2B2FFB2B2B2FFB2B2B2FFB2B2B2FFB2B2
      B2FFB2B2B2FFEFEEEE21000000000000000000000000EAC98D98D4A654FFD4A4
      4CFFF1DEBE55DDB263CEE4C386A100000000000000000000000000000000FEFD
      FB04FCF8F111FEFEFD02E8C78B970000000000000000FDF4E623FCF3E426FCF3
      E326FCF3E326FBF2E227FCF9F30FFBF5EA1BD9A952FFDDAE57ECFEFCF8090000
      000000000000000000000000000000000000CCCCCCFFEFE8E6FFEFE7E4FFEFE7
      E4FFEFE7E4FFE1DAD7FFA6A6A6FFA6A6A6FFA6A6A6FFA6A6A6FFA6A6A6FFA6A6
      A6FFA6A6A6FFF5F5F512000000000000000062B3DEA474D4FCFF62CAFFFF6AB5
      D7FF6699ABFF659BA8FF659EA7FF65A0A5FF65A3A5FF58B6B6FF69F3F5FF51BA
      E8FFBDD4E7460000000000000000000000000000000000000000DAA952F1DBAF
      5CE300000000F0DDB75EF1DEBA5BF6EAD439DEAD57E3FBF4E622000000000000
      000000000000E3BB72BBFEFDFC04000000000000000000000000000000000000
      00000000000000000000FCF2E02BDFAA4BF7ECCD9396FEFEFE01000000000000
      000000000000000000000000000000000000CCCCCCFFEFE8E6FFEFE7E4FFEFE7
      E4FFEFE7E4FFEFE7E4FFEEE6E3FFBCB7B7FFBEBBBCFFCCCCCCFFF7F7F70A0000
      0000000000000000000000000000000000006AB7DF9C73D3F9FF69CEFFFF9FA8
      AEFFBCBABAFFB0AFAFFFAFADADFFAEACACFFB1AFAFFF76A8AAFF74F7FAFF4DB5
      E5FFC5D9E93E0000000000000000000000000000000000000000FDF8EF16DCA9
      4DF5EDD1A07FF6E9D13DF9F0E029F3E1C054D8AB59FFD9AA55FFF2DEBA5DFDFC
      F809E5BD74BBFCF5EA1C00000000000000000000000000000000000000000000
      00000000000000000000FFFCF80A000000000000000000000000000000000000
      000000000000000000000000000000000000CCCCCCFFEFEAE8FFEFE9E7FFEFE9
      E7FFEFE9E7FFEFE9E7FFEFE9E7FFC0BBBBFFCCCCCCFFF3F3F312000000000000
      000000000000000000000000000000000000CFE6F23234A0D6DC30A3D9F74F98
      BDF8C7C5C5FFDADADAFFDADADAFFDCDCDCFF9C9EA1FE2F85B7F7319CD8F554A4
      DCAFFBFCFD040000000000000000000000000000000000000000000000000000
      0000EDCA8C9DECCC9491F1DAAF6CDDAF5AF0D8AD5FFFDAAD5DFFDEAC50F5EDCD
      9294FEFDFC040000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CCCCCCFFCCCCCCFFCCCCCCFFCCCC
      CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFF4F4F41200000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECEF
      F11DB6B2B2DFB9B6B5E7B6B2B2E7B2AFAFE7AAA7A7B5FAFAFA05000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFDFB05F5E5C84BF1DAB26AF1DBB368F6E7CD44000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF001FFFFFFFFFFF000003FFF81FE7E70000
      03FFF81FC3C3000080FFF81F81810000C0FFF81F80010000E0FF8001C0030000
      F0078001E0070000F8038001F00F0000FC018001F00F0000FC008001E0070000
      FC008001C0030000FC18F81F80010000FC19F81F81800000FE01F81FC3C10000
      FF03F81FE7E30000FF8FFFFFFFF70000FFFFF800FC00F81FC007F8000000E007
      8003F8000000C1E300030000000098F300010000000090710001000000003061
      00010000000031C000000000000007C000000000000007E000010000000003E0
      00070000000180F0011F0001000381E1801F00030007C839FC3F001F0007C003
      FDFF003F0007F007FFFF007FE03FF83F00000000000000000000000000000000
      000000000000}
  end
  object dlgColor: TColorDialog
    Options = [cdFullOpen]
    Left = 76
    Top = 322
  end
  object blnhnt1: TBalloonHint
    Delay = 1000
    HideAfter = 3000
    Left = 250
    Top = 170
  end
end
