parfor i = 1:1
end
clear;
clc;
configuracao.data = datetime;
configuracao.save = 'Rede';
% mkdir(configuracao.save);
% configuracao.file = 'DATABASE/dados';
% mrandom(configuracao.file,1000);
% dado = mgenerate(configuracao);
% network.net_camada = 2;
% network.net_neuronio = [50 40];
% network.trainFcn = {'trainlm', 'Levenberg-Marquardt';...
%     'trainbr','Regulariza��o Bayesiana';...
%     'trainbfg','BFGS Quasi-Newton';...
%     'trainrp','Resilient Backpropagation';...
%     'trainscg','Scaled Conjugate Gradient';...
%     'traincgb','Conjugate Gradient with Powell/Beale Restarts';...
%     'traincgf','Fletcher-Powell Conjugate Gradient';...
%     'traincgp','Polak-Ribi�re Conjugate Gradient';...
%     'trainoss','One Step Secant';...
%     'traingdx','Variable Learning Rate Gradient Descent';...
%     'traingdm','Gradient Descent with Momentum';...
%     'traingd','Gradient Descent'};
% network.trainSelect = 0;
% network.transferFcn = {'purelin'; 'tansig';'logsig'};
% network.transferSelect = 0;
% network.redeTipo = {'feedforwardnet'};
% network.redeSelect = 0;
% network.net_train = 0;
% network.net_epochs = 0;
% network.net_lr = 0;
% network.redes_aux = {};
% network = mnetcreate(network,dado);
% network.net_train = 1;
% network.net_epochs = 1000;
% network.net_lr = 1e-6;
% network.resource = 3;%Resources: 1-Normal |2-Parallel |3-Parallel e GPU
% network = mnettrain(configuracao,network,dado);
% otimizacao = [];
% resultado = [];
% msave;
mload;
index = net_select(network,4);%Listar por: 1 - TREINO |2 - VALIDA��O |3 - TESTE |4 - ALL');
op_exportar_net(index,[],network,dado,configuracao);

otimizacao = motmcreate(dado);
otimizacao.psize = 50;
otimizacao.pgen = 100;
otimizacao.peli = 20;
otimizacao.tipo = 2;%1 - Maximizar | 2 - Minimizar
otimizacao.parallel = true;

configuracao.data = datetime;
configuracao.save = 'Manaus-Barcelos';
otimizacao.distacia = 440.98/ 1.852;
resultado = motmexe(configuracao,dado,network,otimizacao);
msave;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);

configuracao.data = datetime;
configuracao.save = 'Manaus-Itacoatiara';
otimizacao.distacia = 195.3/ 1.852;
resultado = motmexe(configuracao,dado,network,otimizacao);
msave;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);

configuracao.data = datetime;
configuracao.save = 'Manaus-Parintins';
otimizacao.distacia = 433.75/ 1.852;
resultado = motmexe(configuracao,dado,network,otimizacao);
msave;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);