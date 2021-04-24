function [ network ] = mnetcreate (dado)
clc;
fprintf('!!!Configuração da Rede Neural!!!\n');
network.net_camada = 2;%input('(int) Quantidade de de Camada:');
% network.net_neuronio = zeros(1,network.net_camada);
% for i = 1:network.net_camada
%     network.net_neuronio(i) = input(sprintf('(int) Quantidade de Neuronios da Camada %d:',i));
% end
network.net_neuronio = [50 40];
%trainFcn
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
fprintf('\nEscolhe os Algoritmo de Treinamento\n');
fprintf('\t0 - Todos\n');
for i = 1:length(network.trainFcn)
    fprintf('\t%d - %s\n',i,strjoin(network.trainFcn(i,:),': '));
end
treino = 0;%input('(int ou []) Opção:');
%transferFcn
network.transferFcn = {'purelin'; 'tansig';'logsig'};
fprintf('\nEscolhe as Função de Transferência\n');
fprintf('\t0 - Todos\n');
for i = 1:length(network.transferFcn)
    fprintf('\t%d - %s\n',i,network.transferFcn{i});
end
fcn = 0;%input('(int ou []) Opção:');
%tipo
network.redetipo = {'feedforwardnet'};
fprintf('\nEscolhe os Tipo de Redes\n');
fprintf('\t0 - Todos\n');
for i = 1:length(network.redetipo)
    fprintf('\t%d - %s\n',i,network.redetipo{i});
end
tipos = 0;%input('(int ou []) Opção:');
network.net_train = 0;
network.net_epochs = 0;
network.net_lr = 0;
network.redes_aux = {};
%Create
count = 1;
for i = 1:length(network.trainFcn)
    if any(treino(:) == i) || any(treino(:) == 0)
        for j = 1:length(network.transferFcn)
            if any(fcn(:) == j) || any(fcn(:) == 0)
                clc;
                fprintf('\n!!!Creando as Redes Neurais!!!\n');
                fprintf('Redes Neurais: %d\n',count);
                if any(tipos(:) == 1) || any(tipos(:) == 0)
                    net = net_feedforwardnet(network,dado,network.trainFcn{i,1},network.transferFcn{j});
                    net.name = sprintf('N%d - %s',count,net.name);
                    
                    network.redes(count).index = count;
                    network.redes(count).tipo = 'feedforwardnet';
                    network.redes(count).trainFcn = network.trainFcn{i,1};
                    network.redes(count).trainFcnName = network.trainFcn{i,2};
                    network.redes(count).transferFcn = network.transferFcn{j};
                    
                    network.redes(count).treino = {};
                    network.redes(count).validacao = {};
                    network.redes(count).teste = {};
                    network.redes(count).all = {};
                    
                    network.redes(count).rede = {};
                    network.redes(count).rede_treino = {};
                    network.redes(count).tempo = {};
                    
                    network.redes_aux{count} = net;
                    
                    count = count +1;
                end
            end
        end
    end
end
end