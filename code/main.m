%code
parfor i = 1:1
end
clear;
clc;
fprintf('Iniciar:\n\t1-Novo\n\t2-Carregar Save\n');
switch input('opcao:')
    case 1
        configuracao = mfile();
        dado = mgenerate(configuracao);
        network = mnetcreate(dado);
        network = mnettrain(configuracao,network,dado);
        otimizacao = motmcreate(dado);
        resultado = motmexe(configuracao,dado,network,otimizacao);
        msave;
    case 2
        configuracao.save = input('(string) Nome do save :','s');
        mload;
end

%%Inicio
while true
    clc
    fprintf('!!!Menu Inicial!!!\n');
    fprintf('\t1 - Resetar as  Configurações\n');
    fprintf('\t2 - Criar e Treinar as Redes Neurais\n');
    fprintf('\t3 - Treinar as Redes Neurais\n');
    fprintf('\t4 - Resetar Parâmetros do Método de Otimização\n');
    fprintf('\t5 - Listar Redes Neurais e ver os Resultados\n');
    fprintf('\t6 - Salvar um Novo\n');
    fprintf('\t7 - Carregar o Save\n');
    fprintf('\t0 - Sair\n');
    switch input('opcao:')
        case 1
            configuracao = mfile();
            dado = mgenerate(configuracao);
            network = mnetcreate(dado);
            network = mnettrain(configuracao,network,dado);
            otimizacao = motmcreate(dado);
            resultado = motmexe(configuracao,dado,network,otimizacao);
        case 2
            network = mnetcreate(dado);
            network = mnettrain(configuracao,network,dado);
            otimizacao = motmcreate(dado);
            resultado = motmexe(configuracao,dado,network,otimizacao);
        case 3
            network = mnettrain(configuracao,network,dado);
            otimizacao = motmcreate(dado);
            resultado = motmexe(configuracao,dado,network,otimizacao);
        case 4
            otimizacao = motmcreate(dado);
            resultado = motmexe(configuracao,dado,network,otimizacao);
        case 5
            op_listarnet(configuracao,resultado,dado,network,otimizacao);
        case 6
            configuracao.data = datatime;
            configuracao.save = input('(string) Nome do save :','s');
            mkdir(configuracao.save);
        case 7
            configuracao.save = input('(string) Nome do save :','s');
            mload;
        otherwise
            break;
    end
    msave;
end