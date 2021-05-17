function op_exportar_net(index,index2,network,dado,configuracao)
clc;
path = sprintf('%s',datetime('now','Format','yyyy-MM-dd-HH-mm-ss'));
path = [configuracao.save,'\',path,'\'];
mkdir(path);

if isempty(index)
    index = 1:length(network.redes);
end
if isempty(index2)
    index2 = 1:length(network.redes(1).rede);
end

%=====================================================================

fprintf('!!!plot perform!!!!\n');
path_plus = [path,'perform\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
for j = 1:length(index2)
    h = plot_net_perform(index,index2(j),network);
    plot_save(path_plus,h);
    close all;
end

clc;
fprintf('!!!plot errhist!!!!\n');
path_plus = [path,'errhist\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
for j = 1:length(index2)
    h=plot_net_errhist(index,index2(j),network,dado);
    plot_save(path_plus,h);
    close all;
end

clc;
fprintf('!!!plot regression!!!!\n');
path_plus = [path,'regression\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
for j = 1:length(index2)
    h=plot_net_regression(index,index2(j),network,dado);
    plot_save(path_plus,h);
    close all;
end

clc;
fprintf('!!!plot trainstate!!!!\n');
path_plus = [path,'trainstate\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
for j = 1:length(index2)
    h=plot_net_trainstate(index,index2(j),network);
    plot_save(path_plus,h);
    close all;
end

%=====================================================================

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
    
    list(end+1,:) = {rede.index,rede.tipo,rede.trainFcn,...%1 2 3
        rede.trainFcnName,rede.transferFcn,...%4 5
        length(rede.rede),qdt,sprintf('%s',dur),...%6 7
        treino.mse,validacao.mse,teste.mse,all.mse,...% 8 9 10 11
        treino.rmse,validacao.rmse,teste.rmse,all.rmse,...% 12 13 14 15
        treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...% 16 17 18 19
        treino.mape,validacao.mape,teste.mape,all.mape,...%20 21 22 23
        treino.regression,validacao.regression,teste.regression,all.regression};% 24 25 26 27
end
xlswrite([path,'Redes Neurais.xlsx'],list);

%=====================================================================

clc;
list = {'Nº','Tipo de Rede','Algoritmo de Treinamento',...%1 2 3
    'Algoritmo de Treinamento Nome','Função de Transferência',...%4 5
    'N° Treinamento','Iterações','Tempo',...%6 7
    'Treino MSE','Validacao MSE','Teste MSE','All MSE',...% 8 9 10 11
    'Treino RMSE','Validacao RMSE','Teste RMSE','All RMSE',...% 12 13 14 15
    'Treino NRMSE','Validacao NRMSE','Teste NRMSE','All NRMSE',...% 16 17 18 19
    'Treino MAPE','Validacao MAPE','Teste MAPE','All MAPE',...% 20 21 22 23
    'Treino REGRESSION','Validacao REGRESSION','Teste REGRESSION','All REGRESSION'};% 24 25 26 27
for i = 1:length(index)
    for j = 1:length(index2)
        rede = network.redes(index(i));
        treino = rede.treino{index2(j)};
        validacao = rede.validacao{index2(j)};
        teste = rede.teste{index2(j)};
        all = rede.all{index2(j)};
        qdt = rede.rede_treino{index2(j)}.num_epochs;
        dur = rede.tempo{index2(j)};
        
        list(end+1,:) = {rede.index,rede.tipo,rede.trainFcn,...%1 2 3
            rede.trainFcnName,rede.transferFcn,...%4 5
            length(rede.rede),qdt,sprintf('%s',dur),...%6 7
            treino.mse,validacao.mse,teste.mse,all.mse,...% 8 9 10 11
            treino.rmse,validacao.rmse,teste.rmse,all.rmse,...% 12 13 14 15
            treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...% 16 17 18 19
            treino.mape,validacao.mape,teste.mape,all.mape,...%20 21 22 23
            treino.regression,validacao.regression,teste.regression,all.regression};% 24 25 26 27
    end
end
xlswrite([path,'Redes Neurais - Treino.xlsx'],list);

%=====================================================================

fid = fopen( strcat(path,'rede-parametros.txt'), 'wt' );
fprintf(fid,'Camada: %d\n',network.net_camada);
fprintf(fid,'=====================================================\n');
fprintf(fid,'Neuronio: [ ');
fprintf(fid,'%d ',network.net_neuronio);
fprintf(fid,']\n');
fprintf(fid,'=====================================================\n');
fprintf(fid,'trainFcn:\n');
for i = 1:size(network.trainFcn,1)
    if any(network.trainSelect(:) == i) || any(network.trainSelect(:) == 0)
    fprintf(fid,'\t%s : %s\n',network.trainFcn{i,1},network.trainFcn{i,2});
    end
end
fprintf(fid,'=====================================================\n');
fprintf(fid,'transferFcn:\n');
for i = 1:size(network.transferFcn,1)
    if any(network.transferSelect(:) == j) || any(network.transferSelect(:) == 0)
        fprintf(fid,'\t%s\n',network.transferFcn{i});
    end
end
fprintf(fid,'=====================================================\n');
fprintf(fid,'redeTipo:\n');
for i = 1:size(network.redeTipo,1)
    if any(network.redeSelect(:) == i) || any(network.redeSelect(:) == 0)
        fprintf(fid,'\t%s\n',network.redeTipo{i});
    end
end
fclose(fid);

%=====================================================================

xlswrite([path,'Dados - Raw.xlsx'],dado.raw);

list = {'Tipo','Coluna','Nome','Min','Max'};
list2 = {};
for i = 1:size(dado.inputVal,1)
    list(end+1,:) = ['input',dado.inputVal(i,:)];
    list2{1,end+1} = dado.inputVal{i,2};
end
list2 = [list2;num2cell(dado.input')];
xlswrite([path,'Dados - Input.xlsx'],list2);
list2 = {};
for i = 1:size(dado.targetVal,1)
    list(end+1,:) = ['target',dado.targetVal(i,:)];
    list2{1,end+1} = dado.targetVal{i,2};
end
xlswrite([path,'Dados - Target.xlsx'],list2);
xlswrite([path,'Dados - Desc.xlsx'],list);

end

