function [ network ] = mnetcreate(dado)
clc;
fprintf('!!!Configuração da Rede Neural!!!\n');
network.net_camada = input('(int) Quantidade de de Camada:');
network.net_neuronio = zeros(1,network.net_camada);
for i = 1:network.net_camada
    network.net_neuronio(i) = input(sprintf('(int) Quantidade de Neuronios da Camada %d:',i));
end

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
network.trainSelect = input('(int ou []) Opção:');

network.transferFcn = {'purelin'; 'tansig';'logsig'};
fprintf('\nEscolhe as Função de Transferência\n');
fprintf('\t0 - Todos\n');
for i = 1:length(network.transferFcn)
    fprintf('\t%d - %s\n',i,network.transferFcn{i});
end
network.transferSelect = input('(int ou []) Opção:');

network.redeTipo = {'feedforwardnet'};
fprintf('\nEscolhe os Tipo de Redes\n');
fprintf('\t0 - Todos\n');
for i = 1:length(network.redeTipo)
    fprintf('\t%d - %s\n',i,network.redeTipo{i});
end
network.redeSelect = input('(int ou []) Opção:');

network.net_train = 0;
network.net_epochs = 0;
network.net_lr = 0;
network.resource = 0;
network.redes_aux = {};

clc;
count = 1;
fprintf('\n!!!Creando as Redes Neurais!!!\n');
for i = 1:length(network.trainFcn)
    if any(network.trainSelect(:) == i) || any(network.trainSelect(:) == 0)
        for j = 1:length(network.transferFcn)
            if any(network.transferSelect(:) == j) || any(network.transferSelect(:) == 0)
                if any(network.redeSelect(:) == 1) || any(network.redeSelect(:) == 0)
                    net = net_feedforwardnet(network,dado,network.trainFcn{i,1},network.transferFcn{j});
                    net.name = sprintf('N%d - %s',count,net.name);
                    network = mnetcreate_add (network,count,i,j,net,network.redeTipo{1});
                    count = count +1;
                end
            end
        end
    end
end
end