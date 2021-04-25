clear;
clc;
nome_save = 'n1-caso1';
mload2;
[configuracao,dado,network,otimizacao,resultado] = update_save('Manaus-Itacoatiara',configuracao,dado,network,otimizacao,resultado);
msave;
index = net_select(network,4);%Listar por: 1 - TREINO |2 - VALIDA플O |3 - TESTE |4 - ALL');
op_exportar_net(index,[],network,dado,'Rede\');
path = sprintf('%s\\',configuracao.save);
op_exportar(index,[],configuracao,resultado,dado,network,otimizacao,path);


clc;
nome_save = 'n1-caso2';
mload2;
[configuracao,dado,network,otimizacao,resultado] = update_save('Manaus-Parintins',configuracao,dado,network,otimizacao,resultado);
msave;
index = net_select(network,4);%Listar por: 1 - TREINO |2 - VALIDA플O |3 - TESTE |4 - ALL');
path = sprintf('%s\\',configuracao.save);
op_exportar(index,[],configuracao,resultado,dado,network,otimizacao,path);


clc;
nome_save = 'n1-caso3';
mload2;
[configuracao,dado,network,otimizacao,resultado] = update_save('Manaus-Barcelos',configuracao,dado,network,otimizacao,resultado);
msave;
index = net_select(network,4);%Listar por: 1 - TREINO |2 - VALIDA플O |3 - TESTE |4 - ALL');
path = sprintf('%s\\',configuracao.save);
op_exportar(index,[],configuracao,resultado,dado,network,otimizacao,path);

nome_save = 'caso1';
mload2;
[configuracao,dado,network,otimizacao,resultado] = update_save('Manaus-Itacoatiara2',configuracao,dado,network,otimizacao,resultado);
msave;
index = net_select(network,4);%Listar por: 1 - TREINO |2 - VALIDA플O |3 - TESTE |4 - ALL');
op_exportar_net(index,[],network,dado,'Rede2\');
path = sprintf('%s\\',configuracao.save);
op_exportar(index,[],configuracao,resultado,dado,network,otimizacao,path);
