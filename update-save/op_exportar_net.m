function op_exportar_net(index,index2,network,dado,path)
clc;
mkdir(path);

if isempty(index)
    index = 1:length(network.redes);
end
if isempty(index2)
    index2 = 1:length(network.redes(1).rede);
end

fprintf('!!!plot perform!!!!\n');
path_plus = [path,'perform\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
parfor i = 1:length(index)
    h = plot_net_perform(index(i),index2,network);
    plot_save(path_plus,h);
end
clc;
fprintf('!!!plot errhist!!!!\n');
path_plus = [path,'errhist\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
parfor i = 1:length(index)
    h=plot_net_errhist(index(i),index2,network,dado);
    plot_save(path_plus,h);
end
clc;
fprintf('!!!plot regression!!!!\n');
path_plus = [path,'regression\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
parfor i = 1:length(index)
    h=plot_net_regression(index(i),index2,network,dado);
    plot_save(path_plus,h);
end
clc;
fprintf('!!!plot trainstate!!!!\n');
path_plus = [path,'trainstate\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
parfor i = 1:length(index)
    h=plot_net_trainstate(index(i),index2,network);
    plot_save(path_plus,h);
end

clc;
list = {'Nº','Tipo de Rede','Algoritmo de Treinamento',...%1 2 3
    'Algoritmo de Treinamento Nome','Função de Transferência',...%4 5
    'Total Treinamento','Total de Iterações','Tempo Total',...%6 7
    'Treino MSE','Validacao MSE','Teste MSE','All MSE',...% 8 9 10 11
    'Treino RMSE','Validacao RMSE','Teste RMSE','All RMSE',...% 12 13 14 15
    'Treino NRMSE','Validacao NRMSE','Teste NRMSE','All NRMSE',...% 16 17 18 19
    'Treino MAPE','Validacao MAPE','Teste MAPE','All MAPE',...% 20 21 22 23
    'Treino REGRESSION','Validacao REGRESSION','Teste REGRESSION','All REGRESSION'};% 24 25 26 27
for i = 1:length(index)
    rede = network.redes(index(i));
    treino = rede.treino{end};
    validacao = rede.validacao{end};
    teste = rede.teste{end};
    all = rede.all{end};
    qdt = 0;
    dur = duration;
    for j = 1:length(rede.rede_treino)
        qdt = qdt + rede.rede_treino{j}.num_epochs;
        dur = dur + rede.tempo{j};
    end
    list(i+1,:) = {rede.index,rede.tipo,rede.trainFcn,...%1 2 3
        rede.trainFcnName,rede.transferFcn,...%4 5
        length(rede.rede),qdt,sprintf('%s',dur),...%6 7
        treino.mse,validacao.mse,teste.mse,all.mse,...% 8 9 10 11
        treino.rmse,validacao.rmse,teste.rmse,all.rmse,...% 12 13 14 15
        treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...% 16 17 18 19
        treino.mape,validacao.mape,teste.mape,all.mape,...%20 21 22 23
        treino.regression,validacao.regression,teste.regression,all.regression};% 24 25 26 27
end
xlswrite([path,'Redes Neurais.xlsx'],list);

end

