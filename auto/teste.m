parfor i = 1:1
end
clear;
net_teste = {};
for i = 1:50
    for j = 1:40
        net_teste{end+1,1} = [i j];
    end
end

mkdir('teste');
list = {'Camada 1','Camada 2','Resources','Algoritmo de Treinamento',...%1 2 3
    'Algoritmo de Treinamento Nome','Função de Transferência',...%4 5
    'Total Treinamento','Total de Iterações','Tempo Total',...%6 7
    'Treino MSE','Validacao MSE','Teste MSE','All MSE',...% 8 9 10 11
    'Treino RMSE','Validacao RMSE','Teste RMSE','All RMSE',...% 12 13 14 15
    'Treino NRMSE','Validacao NRMSE','Teste NRMSE','All NRMSE',...% 16 17 18 19
    'Treino MAPE','Validacao MAPE','Teste MAPE','All MAPE',...% 20 21 22 23
    'Treino REGRESSION','Validacao REGRESSION','Teste REGRESSION','All REGRESSION'};% 24 25 26 27
for i = 1:size(net_teste,1)
    for j = 1:3
        clc;
        fprintf('\n%s',sprintf(' %d ',net_teste{i}));
        configuracao.data = datetime;
        configuracao.save = ['Rede[' sprintf(' %d ',net_teste{i}) ']'];
        mkdir(configuracao.save);
        configuracao.file = 'DATABASE/dados';
        dado = mgenerate(configuracao);
        network.net_camada = 2;
        network.net_neuronio = net_teste{i};
        network.trainFcn = {'trainlm', 'Levenberg-Marquardt';...
            'trainbr','Regularização Bayesiana';...
            'trainbfg','BFGS Quasi-Newton';...
            'trainrp','Resilient Backpropagation';...
            'trainscg','Scaled Conjugate Gradient';...
            'traincgb','Conjugate Gradient with Powell/Beale Restarts';...
            'traincgf','Fletcher-Powell Conjugate Gradient';...
            'traincgp','Polak-Ribiére Conjugate Gradient';...
            'trainoss','One Step Secant';...
            'traingdx','Variable Learning Rate Gradient Descent';...
            'traingdm','Gradient Descent with Momentum';...
            'traingd','Gradient Descent'};
        network.trainSelect = 1;
        network.transferFcn = {'purelin'; 'tansig';'logsig'};
        network.transferSelect = 0;
        network.redeTipo = {'feedforwardnet'};
        network.redeSelect = 0;
        network.net_train = 0;
        network.net_epochs = 0;
        network.net_lr = 0;
        network.redes_aux = {};
        network = mnetcreate(network,dado);
        network.net_train = 1;
        network.net_epochs = 1000;
        network.net_lr = 0;
        network.resource = j;%Resources: 1-Normal |2-Parallel |3-Parallel e GPU
        network = mnettrain(configuracao,network,dado);
        save(['teste\teste-[' sprintf(' %d ',net_teste{i}) ']'],'configuracao','dado','network');
        %=====================================================================
        for z1 = 1:length(network.redes)
            rede = network.redes(z1);
            treino = rede.treino{end};
            validacao = rede.validacao{end};
            teste2 = rede.teste{end};
            all = rede.all{end};
            qdt = 0;
            dur = duration;
            for z2 = 1:length(rede.rede_treino)
                qdt = qdt + rede.rede_treino{z2}.num_epochs;
                dur = dur + rede.tempo{z2};
            end
            resources = {'Normal','Parallel','Parallel e GPU'};
            list(end+1,:) = {net_teste{i}(1),net_teste{i}(2),resources{j},rede.trainFcn,...%1 2 3
                rede.trainFcnName,rede.transferFcn,...%4 5
                length(rede.rede),qdt,sprintf('%s',dur),...%6 7
                treino.mse,validacao.mse,teste2.mse,all.mse,...% 8 9 10 11
                treino.rmse,validacao.rmse,teste2.rmse,all.rmse,...% 12 13 14 15
                treino.nrmse,validacao.nrmse,teste2.nrmse,all.nrmse,...% 16 17 18 19
                treino.mape,validacao.mape,teste2.mape,all.mape,...%20 21 22 23
                treino.regression,validacao.regression,teste2.regression,all.regression};% 24 25 26 27
        end
    end
end

xlswrite('teste\Relatorio.xlsx',list(1:7201,:));

list2 = list(2:7201,:);
list3 = sortrows(list2,13);

res = {'Normal','Parallel','Parallel e GPU'};
fun = {'purelin','tansig','logsig'};
count = 1;
for i = 1:size(res,2)
    for j = 1:size(fun,2)
        dividir(count).res = res{i};
        dividir(count).fun = fun{j};
        dividir(count).list = {};
        dividir(count).sort = {};
        count = count + 1;
    end
end
for i = 1:size(dividir,2)
    excel = {};
    excel2 = {};
    for j = 1:size(list2,1)
        item = list2(j,:);
        if strcmpi(item{3},dividir(i).res) == 1 && strcmpi(item{6},dividir(i).fun) == 1
            excel(end+1,:) = item;
        end
        item = list3(j,:);
        if strcmpi(item{3},dividir(i).res) == 1 && strcmpi(item{6},dividir(i).fun) == 1
            excel2(end+1,:) = item;
        end
    end
    dividir(i).list = excel;
    dividir(i).sort = excel2;
end

xlswrite('teste\Relatorio.xlsx',[list(1,:);list2]);
xlswrite('teste\Relatorio-Sort.xlsx',[list(1,:);list3]);
for i = 1:size(dividir,2)
    xlswrite(['teste\Relatorio ',dividir(i).res,' ',dividir(i).fun,'.xlsx'],[list(1,:);dividir(i).list]);
    xlswrite(['teste\Relatorio ',dividir(i).res,' ',dividir(i).fun,' -Sort.xlsx'],[list(1,:);dividir(i).sort]);
end
