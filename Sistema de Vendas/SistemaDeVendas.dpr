program SistemaDeVendas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDtmConexao in 'DataModule\uDtmConexao.pas' {dtmPrincipal: TDataModule},
  uTelaHeranca in 'Heranca\uTelaHeranca.pas' {frmHeranca},
  Enter in 'terceiros\Enter.pas',
  uEnum in 'Heranca\uEnum.pas',
  uCadCategorias in 'Cadastro\uCadCategorias.pas' {frmCadCategorias};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
