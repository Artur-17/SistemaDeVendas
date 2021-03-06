unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDtmConexao, Enter;

type
  TfrmPrincipal = class(TForm)
    mmPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrios1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produtos1: TMenuItem;
    N2: TMenuItem;
    Fechar1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    TeclaEnter : TMREnter;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadCategorias;


procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;

end;

procedure TfrmPrincipal.Fechar1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Application.MessageBox('Deseja realmente sair?', 'Informa��o',
                             MB_YESNO + MB_ICONQUESTION ) = mrYes then
    CanClose := True
  else
    CanClose := False;

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

// ESSE � UM C�DIGO UM POUCO MAIS FEIO ABAXIO EST� O CODIGO MAIS BONITO
  {
  dtmPrincipal := TdtmPrincipal.Create (Self);
  dtmPrincipal.conexaoDB.SQLHourGlass := True;
  dtmPrincipal.conexaoDB.Protocol := 'mssql';
  dtmPrincipal.conexaoDB.Database := 'vendas';
  dtmPrincipal.conexaoDB.Port := 1433;
  dtmPrincipal.conexaoDB.HostName := '.\ServerCurso';
  dtmPrincipal.conexaoDB.LibraryLocation := 'G:\Delphi\Sistema de Vendas\ntwdblib.dll';
  dtmPrincipal.conexaoDB.User := 'sa';
  dtmPrincipal.conexaoDB.Password := '123';
  dtmPrincipal.conexaoDB.Connected := True;
  }

// Essa seria a maneira mais certa de se fazer:


   dtmPrincipal := TdtmPrincipal.Create(self);
   with dtmPrincipal.conexaoDB do
   begin

    SQLHourGlass := False;
    Protocol := 'mssql';
    Database := 'vendas';
    Port := 1433;
    HostName := '.\ServerCurso';
    LibraryLocation := 'G:\Delphi\Sistema de Vendas\ntwdblib.dll';
    User := 'sa';
    Password := '123';
    Connected := True;

   end;

   TeclaEnter := TMREnter.Create(Self);
   TeclaEnter.FocusEnabled := True;
   TeclaEnter.FocusColor := clInfoBk;

   frmPrincipal.KeyPreview := True;



end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key= #27 then
    Close;

end;

end.
