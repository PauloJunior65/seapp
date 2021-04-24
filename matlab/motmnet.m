function [ otimizacao ] = motmnet (otimizacao,network)
clc;
fprintf('!!!Configuração dos Métodos de Otimização!!!');
% [index,list,tipo] = net_select(network);
% otimizacao.netlist = index;
% otimizacao.netdesc = list;
% otimizacao.nettipo = tipo;

otimizacao.netlist = [];
otimizacao.netdesc = {};
otimizacao.nettipo = 4;
list2 = {};
for i = 1:length(network.redes)
    rede = network.redes(i);
    treino = rede.treino{end};
    validacao = rede.validacao{end};
    teste = rede.teste{end};
    all = rede.all{end};
    list2(i,:) = {rede.index,rede.tipo,rede.trainFcn,...%1 2 3
        rede.trainFcnName,rede.transferFcn,...%4 5
        treino.mse,validacao.mse,teste.mse,all.mse,...%6 7 8 9
        treino.rmse,validacao.rmse,teste.rmse,all.rmse,...%10 11 12 13
        treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...%14 15 16 17
        treino.mape,validacao.mape,teste.mape,all.mape,...%18 19 20 21
        treino.regression,validacao.regression,teste.regression,all.regression};%22 23 24 25
end
for i = 1:size(list2,1)
    if ~isempty(list2{i,9})
        otimizacao.netdesc(end+1,:) = list2(i,:);
    end
end
otimizacao.netdesc = sortrows(otimizacao.netdesc,9);
for i = 1:size(otimizacao.netdesc,1)
    otimizacao.netlist(end+1) = otimizacao.netdesc{i,1};
end
end