function configuracao = mfile()
clc;
fprintf('!!!Configuração do Arquivo!!!\n');
configuracao.data = datetime;
configuracao.save = input('(string) Nome do save :','s');
mkdir(configuracao.save);
fprintf('Arquivo:\n');
fprintf('\t 1-Gerar Arquivo\n');
fprintf('\t 2-Ler Arquivo\n');
tipo = input('(int) Opção:');
mkdir('DATABASE');
configuracao.file = ['DATABASE/',input('(string) Nome do arquivo xlsx :','s')];
if tipo == 1
    mrandom(configuracao.file,input('(int) Quantidade de Dados:'));   
end

end