function op_exportar(index,index2,configuracao,resultado,dado,network,otimizacao,path)
clc;
mkdir(path);

if isempty(index)
    index = 1:length(network.redes);
end
if isempty(index2)
    index2 = 1:length(network.redes(1).rede);
end

fprintf('!!!plot 2d barco!!!!\n');
path_plus = [path,'barco2d\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
plot_save(path_plus,plot_2d_barco_gafun(resultado,otimizacao));
plot_save(path_plus,plot_2d_barco_ga(index2,resultado,otimizacao));
close all;
clc;
fprintf('!!!plot 3d barco!!!!\n');
path_plus = [path,'barco3d\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
plot_save(path_plus,plot_3d_barco_gafun(resultado,otimizacao));
plot_save(path_plus,plot_3d_barco_ga(index2,resultado,otimizacao));
close all;

clc;
list = {'Nº','Nº-DB','Tipo de Rede','Algoritmo de Treinamento',...%1 2 3
    'Algoritmo de Treinamento Nome','Função de Transferência',...%4 5
    'Total Treinamento','Total de Iterações','Tempo Total',...%6 7
    'Treino MSE','Validacao MSE','Teste MSE','All MSE',...% 8 9 10 11
    'Treino RMSE','Validacao RMSE','Teste RMSE','All RMSE',...% 12 13 14 15
    'Treino NRMSE','Validacao NRMSE','Teste NRMSE','All NRMSE',...% 16 17 18 19
    'Treino MAPE','Validacao MAPE','Teste MAPE','All MAPE',...% 20 21 22 23
    'Treino REGRESSION','Validacao REGRESSION','Teste REGRESSION','All REGRESSION',...% 24 25 26 27
    'GA-Velocidade em KM/H','GA-Consumo em Litro'};%28 29
for i = 1:length(index)
    rede = network.redes(index(i));
    rede2 = resultado.redes(index(i));
    treino = rede.treino{end};
    validacao = rede.validacao{end};
    teste = rede.teste{end};
    all = rede.all{end};
    ga = rede2.ga(end);
    qdt = 0;
    dur = duration;
    for j = 1:length(rede.rede_treino)
        qdt = qdt + rede.rede_treino{j}.num_epochs;
        dur = dur + rede.tempo{j};
    end
    list(i+1,:) = {i,rede.index,rede.tipo,rede.trainFcn,...%1 2 3
        rede.trainFcnName,rede.transferFcn,...%4 5
        length(rede.rede),qdt,sprintf('%s',dur),...%6 7
        treino.mse,validacao.mse,teste.mse,all.mse,...% 8 9 10 11
        treino.rmse,validacao.rmse,teste.rmse,all.rmse,...% 12 13 14 15
        treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...% 16 17 18 19
        treino.mape,validacao.mape,teste.mape,all.mape,...%20 21 22 23
        treino.regression,validacao.regression,teste.regression,all.regression,...% 24 25 26 27
        ga.x,ga.fval};%28 29
end
xlswrite([path,'Redes Neurais - GA.xlsx'],list);

list = {'Nº','Nº-DB','Tipo de Rede','Algoritmo de Treinamento',...%1 2 3
    'Função de Transferência','Nº Treinamento','Iterações','Tempo',...%4 5 6
    'Treino MSE','Validacao MSE','Teste MSE','All MSE',...% 7 8 9 10
    'Treino RMSE','Validacao RMSE','Teste RMSE','All RMSE',...% 11 12 13 14
    'Treino NRMSE','Validacao NRMSE','Teste NRMSE','All NRMSE',...% 15 16 17 18
    'Treino MAPE','Validacao MAPE','Teste MAPE','All MAPE',...% 19 20 21 22
    'Treino REGRESSION','Validacao REGRESSION','Teste REGRESSION','All REGRESSION',...% 23 24 25 26
    'GA-Velocidade em KM/H','GA-Consumo em Litro'};% 27 28
count = 2;
for i = 1:length(index)
    for j = 1:length(index2)
        rede = network.redes(index(i));
        rede2 = resultado.redes(index(i));
        treino = rede.treino{index2(j)};
        validacao = rede.validacao{index2(j)};
        teste = rede.teste{index2(j)};
        all = rede.all{index2(j)};
        ga = rede2.ga(index2(j));
        qdt = rede.rede_treino{index2(j)}.num_epochs;
        dur = rede.tempo{index2(j)};
        list(count,:) = {sprintf('%d-%d',i,j),rede.index,rede.tipo,rede.trainFcnName,rede.transferFcn,j,qdt,sprintf('%s',dur),...
            treino.mse,validacao.mse,teste.mse,all.mse,...%6 7 8 9
            treino.rmse,validacao.rmse,teste.rmse,all.rmse,...%10 11 12 13
            treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...%14 15 16 17
            treino.mape,validacao.mape,teste.mape,all.mape,...%18 19 20 21
            treino.regression,validacao.regression,teste.regression,all.regression,...%22 23 24 25
            ga.x,ga.fval};
        count = count + 1;
    end
end
xlswrite([path,'Redes Neurais - GA - Treinos.xlsx'],list);

fid = fopen( strcat(path,'desc.txt'), 'wt' );
fprintf(fid,'!!!Dados!!!');
fprintf(fid,'--------Input---------');
fprintf(fid,'Size: %d x %d\n',size(dado.input,1),size(dado.input,2));
for i = 1:size(dado.inputVal,1)
    fprintf(fid,'Input %d => C: %d | N: %s | MIN: %d | MAX: %s\n',i,...
        dado.inputVal{i,1},dado.inputVal{i,2},...
        dado.inputVal{i,3},dado.inputVal{i,4});
end
fprintf(fid,'--------Output--------');
fprintf(fid,'Size: %d x %d\n',size(dado.target,1),size(dado.target,2));
for i = 1:size(dado.targetVal,1)
    fprintf(fid,'Target %d => C: %d | N: %s | MIN: %d | MAX: %s\n',i,...
        dado.targetVal{i,1},dado.targetVal{i,2},...
        dado.targetVal{i,3},dado.targetVal{i,4});
end
fprintf(fid,'======================\n');
fprintf(fid,'!!!Barco!!!\n');
fprintf(fid,'Distacia Mila: %f\n',otimizacao.distacia);
fprintf(fid,'Distacia KM: %f\n',otimizacao.distacia*1.852);
fprintf(fid,'======================\n');
fprintf(fid,'!!!Função!!!\n');
fprintf(fid,'Velocidade em Km/H: %f\n',resultado.fun.x);
fprintf(fid,'Consumo em Litro: %f\n',resultado.fun.fval);
fprintf(fid,'======================\n');
fprintf(fid,'!!!Otimização!!!\n');
fprintf(fid,'Valor derteminado na inicialização: %f\n',otimizacao.x0);
fprintf(fid,'Limite Inferior: %f\n',otimizacao.lb);
fprintf(fid,'Limite Superior: %f\n',otimizacao.ub);
tipo = {'1 - Maximizar','2 - Minimizar'};
fprintf(fid,'O resultado da função: %s\n',tipo{otimizacao.tipo});
fprintf(fid,'PopulationSize: %f\n',otimizacao.psize);
fprintf(fid,'MaxGenerations: %f\n',otimizacao.pgen);
fprintf(fid,'EliteCount: %f\n',otimizacao.peli);
fprintf(fid,'======================\n');
fclose(fid);

end

