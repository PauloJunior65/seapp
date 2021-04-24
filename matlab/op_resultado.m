function op_resultado( resultado )
list = {};
for i = 1:length(resultado.redes)
    rede = resultado.redes(i);
    treino = rede.treino{end};
    validacao = rede.validacao{end};
    teste = rede.teste{end};
    all = rede.all{end};
    list(i,:) = {rede.index,rede.tipo,rede.trainFcn,...%1 2 3
        rede.trainFcnName,rede.transferFcn,...%4 5
        treino.mse,validacao.mse,teste.mse,all.mse,...%6 7 8 9
        treino.rmse,validacao.rmse,teste.rmse,all.rmse,...%10 11 12 13
        treino.nrmse,validacao.nrmse,teste.nrmse,all.nrmse,...%14 15 16 17
        treino.mape,validacao.mape,teste.mape,all.mape,...%18 19 20 21
        treino.regression,validacao.regression,teste.regression,all.regression};%22 23 24 25
end



while true
    clc
    fprintf('!!!Resultado o Método de Otimização!!!\n');
    fprintf('======================================\n');
    for i = 1:size(list,1)
        fprintf('Rede Neural Nº%d | T:%s |FT:%s \n',i,list{i,4},list{i,5});
        fprintf('\t ALL: |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
            list{i,9},list{i,13},list{i,17},list{i,21},list{i,25});
    end
    fprintf('======================================\n');
    fprintf('\t1 - Ver os Resultados\n');
    fprintf('\t2 - Plot Redes Neurais\n');
    fprintf('\t3 - Plot Performance\n');
    fprintf('\t4 - Plot Training State\n');
    fprintf('\t5 - Plot Error Histogram\n');
    fprintf('\t6 - Plot Regressão\n');
    fprintf('\t7 - Plot GA 2D\n');
    fprintf('\t8 - Plot GA 3D\n');
    fprintf('\t9 - Exportar\n');
    fprintf('\t0 - Voltar\n');
    switch input('opcao:')
        case 1
            clc;
            fprintf('!!!Resultados!!!\n');
            fprintf('======================================\n');
            for i = 1:length(resultado.redes)
                net_print(resultado.redes(i));
                fprintf('==============================\n');
            end
            input('\n\nPressione ENTER para continuar','s');
        case 2
            plot_net_view([],resultado);
            pausa();
        case 3
            plot_net_perform([],plot_aux(resultado),resultado);
            pausa();
        case 4
            plot_net_trainstate([],plot_aux(resultado),resultado);
            pausa();
        case 5
            plot_net_errhist([],plot_aux(resultado),resultado,resultado.dado);
            pausa();
        case 6
            plot_net_regression([],plot_aux(resultado),resultado,resultado.dado);
            pausa();
        case 7
            if resultado.tipo == 1% Barco Plot
                plot_2d_barco_ga(plot_aux(resultado),resultado);
                plot_2d_barco_gafun(resultado);
            else
                if size(resultado.dado.targetCol,2) == 1
                    switch size(resultado.dado.inputCol,2)
                        case 1
                        case 2
                        case 3
                        otherwise
                    end
                end
            end
            pausa();
        case 8
            if resultado.tipo == 1% Barco Plot
                plot_3d_barco_ga(plot_aux(resultado),resultado);
                plot_3d_barco_gafun(resultado);
            else
                if size(resultado.dado.targetCol,2) == 1
                    switch size(resultado.dado.inputCol,2)
                        case 1
                        case 2
                        case 3
                        otherwise
                    end
                end
            end
            pausa();
        case 9
            path = sprintf('%s\\',datetime('now','Format','yyyy-MM-dd HH-mm-ss'));
            op_exportar([],plot_aux(resultado),resultado,resultado.dado,resultado.tipo,path);
            op_exportar_net([],plot_aux(resultado),resultado,resultado.dado,path);
        otherwise
            break;
    end
end

end

