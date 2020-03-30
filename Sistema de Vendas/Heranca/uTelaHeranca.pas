unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls, uDtmConexao,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum;

type
  TfrmHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTop: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TButton;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnNavegator: TDBNavigator;
    btnFechar: TBitBtn;
    qryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ControlarBotoes(BtnNovo, BtnAlterar, BtnCancelar, BtnGravar,BtnApagar :TBitBtn;
                              Navigator : TDBNavigator; pgcControlPage : TPageControl; Flag: Boolean);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
  private
    EstadoDoCadastro : TEstadoDoCadastro;

    procedure ControlarIndicesTab(pgcControlPage: TPageControl; I: Integer);
    function RetornarCampoTraduzido(campo: String): String;
    procedure ExibirLabelIndice(campo: String; aLabel: Tlabel);

    { Private declarations }
  public
    { Public declarations }
    IndiceAtual : string;
    function Excluir : Boolean; virtual;
    function Gravar (EstadoDoCadastro:TEstadoDoCadastro): Boolean; virtual;
  end;

var
  frmHeranca: TfrmHeranca;

implementation

{$R *.dfm}

{$Region 'M�TODOS E FUN��ES'}
procedure TfrmHeranca.btnAlterarClick(Sender: TObject);
begin

     ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavegator,pgcPrincipal,false);


      EstadoDoCadastro:= ecAlterar;



end;

procedure TfrmHeranca.btnApagarClick(Sender: TObject);
begin
    if Excluir then
  begin

    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                    btnNavegator,pgcPrincipal,true);

    ControlarIndicesTab(pgcPrincipal, 0);

      EstadoDoCadastro := ecNenhum;
  end;
end;


procedure TfrmHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavegator,pgcPrincipal,true);
  ControlarIndicesTab(pgcPrincipal, 0);
end;

procedure TfrmHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

{$EndRegion}

procedure TfrmHeranca.btnGravarClick(Sender: TObject);
begin


   try
      if Gravar(EstadoDoCadastro) then
      begin
         ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavegator,pgcPrincipal,true);

      ControlarIndicesTab(pgcPrincipal, 0);
      end;



//     ACHO QUE N�O VAI SER NECESS�RIO UTILIZAR

//     if EstadoDoCadastro = ecInserir then
//        showmessage('Inserido')
//     else if EstadoDoCadastro = ecAlterar then
//        showmessage('Alterado')
//     else
//        showmessage('nada aconteceu');
  finally
      EstadoDoCadastro:= ecNenhum;
  end;


end;

procedure TfrmHeranca.btnNovoClick(Sender: TObject);
begin


     ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavegator,pgcPrincipal,false);


    EstadoDoCadastro:= ecInserir;

end;



procedure TfrmHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close;
end;

procedure TfrmHeranca.FormCreate(Sender: TObject);
begin
  qryListagem.Connection := dtmPrincipal.conexaoDB;
  dtsListagem.DataSet :=  qryListagem;
  grdListagem.DataSource := dtsListagem;
  grdListagem.Options := [dgTitles,dgIndicator,dgColumnResize,
                          dgColLines,dgRowLines,dgTabs,dgRowSelect,
                          dgAlwaysShowSelection,dgCancelOnExit,
                          dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmHeranca.FormShow(Sender: TObject);
begin
  if (qryListagem.SQL.Text<>EmptyStr) then
  begin
    qryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    qryListagem.Open;
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavegator,pgcPrincipal,true);
end;



{$Region 'M�TODOS VIRTUAIS'}

function TfrmHeranca.Excluir: Boolean;
begin
   ShowMessage('Deletado');
   Result := True;
end;

function TfrmHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
      ShowMessage('Inserir')
  else if
    EstadoDoCadastro = ecAlterar then
      ShowMessage('Alterado');
  Result := True;

end;


{$ENDREGION}

procedure TfrmHeranca.ControlarBotoes(BtnNovo, BtnAlterar, BtnCancelar,
  BtnGravar, BtnApagar: TBitBtn; Navigator: TDBNavigator;
  pgcControlPage: TPageControl; Flag: Boolean);
begin
  BtnNovo.Enabled := Flag;
  BtnAlterar.Enabled := Flag;
  BtnCancelar.Enabled := not(Flag);
  BtnGravar.Enabled := not(Flag);;
  BtnApagar.Enabled := Flag;
  Navigator.Enabled := Flag;
  pgcControlPage.Pages[0].TabVisible := Flag;

end;

function TfrmHeranca.RetornarCampoTraduzido(campo:String): String;
var
  I: Integer;
begin

  for I := 0 to qryListagem.Fields.Count-1 do begin


   if LowerCase(qryListagem.Fields[i].FieldName) = LowerCase(campo) then begin
    result := qryListagem.Fields[i].DisplayLabel;
    Break;
   end;
  end;
end;



procedure TfrmHeranca.ExibirLabelIndice(campo : String; aLabel:Tlabel);
begin
    aLabel.Caption := RetornarCampoTraduzido(campo)
end;

procedure TfrmHeranca.ControlarIndicesTab(pgcControlPage : TPageControl; I: Integer);
begin
   if pgcControlPage.Pages[I].TabVisible then
      pgcPrincipal.TabIndex :=I;

end;



procedure TfrmHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  qryListagem.IndexFieldNames := IndiceAtual;

  lblIndice.Caption := RetornarCampoTraduzido(IndiceAtual);

  lblIndice.Refresh;

  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmHeranca.mskPesquisarChange(Sender: TObject);
begin
  qryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey])
end;

end.