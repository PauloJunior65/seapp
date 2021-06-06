parfor i = 1:1
end
clear;
clc;
configuracao.data = datetime;
configuracao.save = 'Rede';
mkdir(configuracao.save);
configuracao.file = 'DATABASE/dados';
mrandom(configuracao.file,500);
dado = mgenerate(configuracao);
network.net_camada = 2;
network.net_neuronio = [5 37];
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
network.trainSelect = 0;
network.transferFcn = {'purelin'; 'tansig';'logsig'};
network.transferSelect = 2;
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
network.resource = 3;%Resources: 1-Normal |2-Parallel |3-Parallel e GPU
network = mnettrain(configuracao,network,dado);
otimizacao = [];
resultado = [];
msave;
%mload;
index = net_select(network,4);%Listar por: 1 - TREINO |2 - VALIDAÇÃO |3 - TESTE |4 - ALL');
op_exportar_net(index,[],network,dado,configuracao);
%=============================================================
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
%=============================================================
otimizacao = motmcreate(dado);
otimizacao.psize = 50;
otimizacao.pgen = 100;
otimizacao.peli = 20;
otimizacao.tipo = 2;%1 - Maximizar | 2 - Minimizar
otimizacao.parallel = false;

configuracao.data = datetime;
configuracao.save = 'Manaus-Barcelos 2';
otimizacao.distacia = 440.98/ 1.852;
resultado = motmexe(configuracao,dado,network,otimizacao);
msave;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);

configuracao.data = datetime;
configuracao.save = 'Manaus-Itacoatiara 2';
otimizacao.distacia = 195.3/ 1.852;
resultado = motmexe(configuracao,dado,network,otimizacao);
msave;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);

configuracao.data = datetime;
configuracao.save = 'Manaus-Parintins 2';
otimizacao.distacia = 433.75/ 1.852;
resultado = motmexe(configuracao,dado,network,otimizacao);
msave;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);