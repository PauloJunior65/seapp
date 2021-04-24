function op_listarnet( configuracao,resultado,dado,network,otimizacao )
clc;
fprintf('!!!Listar Redes Neurais : %d!!!\n',length(network.redes));
[index,list,tipo] = net_select(network);
while true
    clc
    fprintf('!!!Listar Redes Neurais : %d!!!\n',length(index));
    fprintf('==============================\n');
    for i = 1:size(list,1)
        switch tipo
            case 1
                fprintf('Rede Neural %d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                    i,list{i,4},list{i,5},list{i,6},list{i,10},list{i,14},list{i,18},list{i,22});
            case 2
                fprintf('Rede Neural %d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                    i,list{i,4},list{i,5},list{i,7},list{i,11},list{i,15},list{i,19},list{i,23});
            case 3
                fprintf('Rede Neural %d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                    i,list{i,4},list{i,5},list{i,8},list{i,12},list{i,16},list{i,20},list{i,24});
            otherwise
                fprintf('Rede Neural %d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                    i,list{i,4},list{i,5},list{i,9},list{i,13},list{i,17},list{i,21},list{i,25});
        end
    end
    fprintf('==============================\n');
    fprintf('\t1 - Nova Pesquisa\n');
    fprintf('\t2 - Ver Redes Neurais\n');
    fprintf('\t3 - Plot Redes Neurais\n');
    fprintf('\t4 - Plot Performance\n');
    fprintf('\t5 - Plot Training State\n');
    fprintf('\t6 - Plot Error Histogram\n');
    fprintf('\t7 - Plot Regressão\n');
    fprintf('\t8 - Plot GA 2D\n');
    fprintf('\t9 - Plot GA 3D\n');
    fprintf('\t10 - Exportar Net\n');
    fprintf('\t11 - Exportar Otm\n');
    fprintf('\t12 - Exportar All\n');
    fprintf('\t0 - Voltar\n');
    switch input('opcao:')
        case 1
            clc;
            [index,list,tipo] = net_select(network);
        case 2
            clc;
            fprintf('!!!Listar Redes Neurais : %d!!!\n',length(network.redes));
            fprintf('==============================\n');
            for i = 1:length(index)
                net_print(network.redes(index(i)));
                fprintf('==============================\n');
            end
            input('\n\nPressione ENTER para continuar','s');
        case 3
            plot_net_view(index,network);
            pausa();
        case 4
            plot_net_perform(index,plot_aux(network),network);
            pausa();
        case 5
            plot_net_trainstate(index,plot_aux(network),network);
            pausa();
        case 6
            plot_net_errhist(index,plot_aux(network),network,dado);
            pausa();
        case 7
            plot_net_regression(index,plot_aux(network),network,dado);
            pausa();
        case 8
            plot_2d_barco_ga(plot_aux(network),resultado,otimizacao);
            plot_2d_barco_gafun(resultado,otimizacao);
        case 9
            plot_3d_barco_ga(plot_aux(network),resultado,otimizacao);
            plot_3d_barco_gafun(resultado,otimizacao);
        case 10
            path = sprintf('%s\\%s\\',configuracao.save,datetime('now','Format','yyyy-MM-dd HH-mm-ss'));
            op_exportar_net(index,plot_aux(network),network,dado,path);
        case 11
            path = sprintf('%s\\%s\\',configuracao.save,datetime('now','Format','yyyy-MM-dd HH-mm-ss'));
            op_exportar(index,plot_aux(network),configuracao,resultado,dado,network,otimizacao,path);
        case 12
            path = sprintf('%s\\%s\\',configuracao.save,datetime('now','Format','yyyy-MM-dd HH-mm-ss'));
            aux = plot_aux(network);
            op_exportar_net(index,aux,network,dado,path);
            op_exportar(index,aux,configuracao,resultado,dado,network,otimizacao,path);
        otherwise
            break;
    end
end

end

