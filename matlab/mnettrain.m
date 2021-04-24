function [ network ] = mnettrain (network,dado)
clc;
network.net_train = 100;%input('(int) Número de Treino:');
network.net_epochs = 10;%input('(int) Número máximo de iterações de cada Treino:');
network.net_lr = 0.00001;%input('Taxa de aprendizagem\n Exemplo "0.0001"\n(double):');
clc;
fprintf('\nTreinando as Redes Neurais\n');
fprintf('=================================================\n');
for i = 1:length(network.redes_aux)
    net = network.redes_aux{i};
    net.trainParam.epochs = network.net_epochs;
    net.trainParam.lr = network.net_lr;
    %reset
    network.redes(i).rede = {};
    network.redes(i).rede_treino = {};
    network.redes(i).tempo = {};
    network.redes(i).treino = {};
    network.redes(i).validacao = {};
    network.redes(i).teste = {};
    network.redes(i).all = {};
    %add
    for j = 1:network.net_train
        fprintf('Treinamento %d de %d\n',j,length(network.net_train));
        fprintf('-------------------------------------------------\n');
        tempo = datetime('now','TimeZone','local','Format','dd HH:mm:ss');
        %[net,network.redes(i).treino{j}] = train(net,dado.input,dado.target);
        [net,tr] = train(net,dado.input,dado.target,'useParallel','yes');
        network.redes(i).tempo{j} = datetime('now','TimeZone','local','Format','dd HH:mm:ss') - tempo;
        network.redes(i).rede{j} = net;
        network.redes(i).rede_treino{j} = tr;
        
        output = net(dado.input);
        [trOut,trTarg,vOut,vTarg,tsOut,tsTarg] = net_regression_array( tr,dado,output );
        
        network.redes(i).treino{j} = get_error(trTarg,trOut);
        network.redes(i).validacao{j} = get_error(vTarg,vOut);
        network.redes(i).teste{j}  = get_error(tsTarg,tsOut);
        network.redes(i).all{j} = get_error(dado.target,output);
    end
    network.redes_aux{i} = net;
    
    net_print(network.redes(i));
    fprintf('=================================================\n');
    
end
nntraintool('close');
end