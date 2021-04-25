function [ list,tipo ] = net_list( network,tipo)
list = {};
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
fprintf('\nListar por:\n\t1 - TREINO\n\t2 - VALIDAÇÃO\n\t3 - TESTE\n\t4 - ALL\n');
switch tipo
    case 1
        for i = 1:size(list2,1)
            if ~isempty(list2{i,6})
                list(end+1,:) = list2(i,:);
            end
        end
        list = sortrows(list,6);
    case 2
        for i = 1:size(list2,1)
            if ~isempty(list2{i,7})
                list(end+1,:) = list2(i,:);
            end
        end
        list = sortrows(list,7);
    case 3
        for i = 1:size(list2,1)
            if ~isempty(list2{i,8})
                list(end+1,:) = list2(i,:);
            end
        end
        list = sortrows(list,8);
    otherwise
        for i = 1:size(list2,1)
            if ~isempty(list2{i,9})
                list(end+1,:) = list2(i,:);
            end
        end
        list = sortrows(list,9);
end
end

