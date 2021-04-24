function op_exportar(index,index2,network,dado,tipo,path)
clc;
mkdir(path);

if isempty(index)
    index = 1:length(network.redes);
end
if isempty(index2)
    index2 = 1:length(network.redes(1).rede);
end


if tipo == 1% Barco Plot
    clc;
    fprintf('!!!plot 2d barco!!!!\n');
    path_plus = [path,'barco2d\'];
    mkdir(path_plus);
    plot_save(path_plus,plot_2d_barco_gafun(network));
    close all;
    parfor i = 1:length(index2)
        plot_save(path_plus,plot_2d_barco_ga(index2(i),network));
    end
    clc;
    fprintf('!!!plot 3d barco!!!!\n');
    path_plus = [path,'barco3d\'];
    mkdir(path_plus);
    plot_save(path_plus,plot_3d_barco_gafun(network));
    close all;
    parfor i = 1:length(index2)
        plot_save(path_plus,plot_3d_barco_ga(index2(i),network));
    end
    clc;
else
    if size(dado.targetCol,2) == 1
        switch size(dado.inputCol,2)
            case 1
            case 2
            case 3
            otherwise
        end
    end
end

if tipo == 1
    list = {'Nº','Tipo de Rede','Algoritmo de Treinamento',...%1 2 3
        'Algoritmo de Treinamento Nome','Função de Transferência',...%4 5
        'Total Treinamento','Total de Iterações',...%6 7
        'Treino MSE','Validacao MSE','Teste MSE','All MSE',...% 8 9 10 11
        'Treino RMSE','Validacao RMSE','Teste RMSE','All RMSE',...% 12 13 14 15
        'Treino NRMSE','Validacao NRMSE','Teste NRMSE','All NRMSE',...% 16 17 18 19
        'Treino MAPE','Validacao MAPE','Teste MAPE','All MAPE',...% 20 21 22 23
        'Treino REGRESSION','Validacao REGRESSION','Teste REGRESSION','All REGRESSION',...% 24 25 26 27
        'GA-Velocidade em KM/H','GA-Consumo em Litro'};%28 29
    for i = 1:length(network.redes)
        rede = network.redes(i);
        treino = rede.treino{end};
        validacao = rede.validacao{end};
        teste = rede.teste{end};
        all = rede.all{end};
        ga = rede.ga(end);
        qdt = 0;
        for j = 1:length(rede.rede_treino)
            qdt = qdt + rede.rede_treino{j}.num_epochs;
        end
        list(i+1,:) = {rede.index,rede.tipo,rede.trainFcn,...%1 2 3
            rede.trainFcnName,rede.transferFcn,...%4 5
            length(rede.rede),qdt,...%6 7
            treino.mse,validacao.mse,teste.mse,all.mse,...% 8 9 10 11
            treino.rmse,validacao.rmse,teste.rmse,all.rmse,...% 12 13 14 15
            treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...% 16 17 18 19 
            treino.mape,validacao.mape,teste.mape,all.mape,...%20 21 22 23
            treino.regression,validacao.regression,teste.regression,all.regression,...% 24 25 26 27
            ga.x,ga.fval};%28 29
    end
    xlswrite([path,'Redes Neurais.xlsx'],list);
    
    list = {'Nº','Tipo de Rede','Algoritmo de Treinamento',...%1 2 3
        'Função de Transferência','Nº Treinamento','Iterações',...%4 5 6
        'Treino MSE','Validacao MSE','Teste MSE','All MSE',...% 7 8 9 10
        'Treino RMSE','Validacao RMSE','Teste RMSE','All RMSE',...% 11 12 13 14
        'Treino NRMSE','Validacao NRMSE','Teste NRMSE','All NRMSE',...% 15 16 17 18
        'Treino MAPE','Validacao MAPE','Teste MAPE','All MAPE',...% 19 20 21 22
        'Treino REGRESSION','Validacao REGRESSION','Teste REGRESSION','All REGRESSION',...% 23 24 25 26
        'GA-Velocidade em KM/H','GA-Consumo em Litro'};% 27 28
    count = 2;
    for i = 1:length(network.redes)
        for j = 1:length(rede.rede)
            rede = network.redes(i);
            treino = rede.treino{j};
            validacao = rede.validacao{j};
            teste = rede.teste{j};
            all = rede.all{j};
            ga = rede.ga(j);
            qdt = rede.rede_treino{j}.num_epochs;
            list(count,:) = {rede.index,rede.tipo,rede.trainFcnName,rede.transferFcn,j,qdt,...
                treino.mse,validacao.mse,teste.mse,all.mse,...%6 7 8 9
                treino.rmse,validacao.rmse,teste.rmse,all.rmse,...%10 11 12 13
                treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...%14 15 16 17
                treino.mape,validacao.mape,teste.mape,all.mape,...%18 19 20 21
                treino.regression,validacao.regression,teste.regression,all.regression,...%22 23 24 25
                ga.x,ga.fval};
            count = count + 1;
        end
    end
    xlswrite([path,'Redes Neurais - Treinos.xlsx'],list);
    
    fid = fopen( strcat(path,'desc.txt'), 'wt' );
    fprintf(fid,'!!!Dados!!!');
    fprintf(fid,'Input Size: %d x %d\n',size(network.dado.input,1),size(network.dado.input,2));
    fprintf(fid,'Output Size: %d x %d\n',size(network.dado.target,1),size(network.dado.target,2));
    fprintf(fid,'----------------------');
    for i = 1:size(network.dado.inputCol,2)
        fprintf(fid,'Input%d => col:%d  name:%s\n',i,network.dado.inputCol{1,i},network.dado.inputCol{2,i});
    end
    for i = 1:size(network.dado.targetCol,2)
        fprintf(fid,'Output%d => col:%d  name:%s\n',i,network.dado.targetCol{1,i},network.dado.targetCol{2,i});
    end
    fprintf(fid,'======================\n');
    fprintf(fid,'!!!Barco!!!\n');
    fprintf(fid,'Distacia Mila: %f\n',network.otimizacao.distacia);
    fprintf(fid,'Distacia KM: %f\n',network.otimizacao.distacia*1.852);
    fprintf(fid,'======================\n');
    fprintf(fid,'!!!Função!!!\n');
    fprintf(fid,'Velocidade em Km/H: %f\n',network.fun.x);
    fprintf(fid,'Consumo em Litro: %f\n',network.fun.fval);
    fprintf(fid,'======================\n');
    fprintf(fid,'!!!Otimização!!!\n');
    fprintf(fid,'Valor derteminado na inicialização: %f\n',network.otimizacao.x0);
    fprintf(fid,'Limite Inferior: %f\n',network.otimizacao.lb);
    fprintf(fid,'Limite Superior: %f\n',network.otimizacao.ub);
    fprintf(fid,'O resultado da função: %f\n',network.otimizacao.tipo);
    fprintf(fid,'PopulationSize: %f\n',network.otimizacao.psize);
    fprintf(fid,'MaxGenerations: %f\n',network.otimizacao.pgen);
    fprintf(fid,'EliteCount: %f\n',network.otimizacao.peli);
    fprintf(fid,'======================\n');
    fclose(fid);
end

end

