clc;
clear;
%addpath(genpath('algoritmo'));
fprintf('Iniciar:\n\t1-Novo\n\t2-Carregar Save\n');
switch input('opcao:')
    case 1
        configuracao = mfile();
        dado = mgenerate(configuracao);
        network = mnetcreate(dado);
        network = mnettrain(network,dado);
        otimizacao = motmcreate(configuracao,dado);
        otimizacao = motmnet(otimizacao,network);
        resultado = motmexe(configuracao,dado,network,otimizacao,'ga');
        clc;
        nome_save = input('Nome do Save: ','s');
        msave;
    case 2
        nome_save = input('Nome do Save: ','s');
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
    fprintf('\t5 - Executar o Método de Otimização\n');
    fprintf('\t6 - Listar Redes Neurais\n');
    fprintf('\t7 - Resultado o Método de Otimização\n');
    fprintf('\t8 - Salvar um Novo\n');
    fprintf('\t9 - Carregar o Save\n');
    fprintf('\t0 - Sair\n');
    switch input('opcao:')
        case 1
            configuracao = mfile();
            dado = mgenerate(configuracao);
            network = mnetcreate(dado);
            network = mnettrain(network,dado);
            otimizacao = motmcreate(configuracao,dado);
            otimizacao = motmnet(otimizacao,network);
            resultado = motmexe(configuracao,dado,network,otimizacao,'ga');
        case 2
            network = mnetcreate(dado);
            network = mnettrain(network,dado);
        case 3
            network = mnettrain(network,dado);
        case 4
            otimizacao = motmcreate(configuracao,dado);
        case 5
            otimizacao = motmnet(otimizacao,network);
            resultado = motmexe(configuracao,dado,network,otimizacao,'ga');
        case 6
            op_listarnet(network,dado);
        case 7
            op_resultado(resultado);
        case 8
            nome_save = input('Nome do Save: ','s');
        case 9
            nome_save = input('Nome do Save: ','s');
            mload;
        otherwise
            break;
    end
    msave;
end