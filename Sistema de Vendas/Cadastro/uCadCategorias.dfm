inherited frmCadCategoria: TfrmCadCategoria
  ActiveControl = pgcPrincipal
  Caption = 'Cadastro de categorias'
  ClientHeight = 448
  ClientWidth = 871
  ExplicitWidth = 887
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 871
    Height = 407
    ExplicitWidth = 871
    ExplicitHeight = 407
    inherited tabListagem: TTabSheet
      ExplicitWidth = 863
      ExplicitHeight = 379
      inherited pnlListagemTop: TPanel
        Width = 863
        ExplicitWidth = 863
      end
      inherited grdListagem: TDBGrid
        Width = 863
        Height = 308
        ReadOnly = True
        Columns = <
          item
            Expanded = False
            FieldName = 'idcategoria'
            Width = 92
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 540
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 863
      ExplicitHeight = 379
    end
  end
  inherited pnlRodape: TPanel
    Top = 407
    Width = 871
    ExplicitTop = 407
    ExplicitWidth = 871
    inherited btnNavegator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnFechar: TBitBtn
      Left = 792
      ExplicitLeft = 792
    end
  end
  inherited qryListagem: TZQuery
    Active = True
    SQL.Strings = (
      'select * from categorias;')
    Left = 720
    object qryListagemidcategoria: TIntegerField
      DisplayLabel = 'c'#243'digo'
      FieldName = 'idcategoria'
      ReadOnly = True
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'descri'#231#227'o'
      FieldName = 'descricao'
      Size = 50
    end
  end
  inherited dtsListagem: TDataSource
    Left = 776
  end
end
