function [ configuracao ] = mfile ()
clc;
fprintf('!!!Configuração do Arquivo!!!\n');
fprintf('Arquivo:\n');
fprintf('\t 1-Gerar Arquivo\n');
fprintf('\t 2-Ler Arquivo\n');
configuracao.data = datatime;
configuracao.file = input('(string) Nome do arquivo xlsx :','s');
if configuracao.tipo == 1
    mrandom(configuracao.file,input('(int) Quantidade de Dados:'));
else
    fprintf('Tipo de Arquivo:\n');
    fprintf('\t 1-Barco\n');
    fprintf('\t 2-Outro\n');
    configuracao.tipo = input('(int) Opção:');
end

end