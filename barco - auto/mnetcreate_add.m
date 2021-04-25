function [ network ] = mnetcreate_add (network,count,i,j,net,tipo)

fprintf('Redes Neurais: %d - %s | %s | %s\n',count,tipo,network.trainFcn{i,2});

network.redes(count).index = count;
network.redes(count).tipo = tipo;
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
end