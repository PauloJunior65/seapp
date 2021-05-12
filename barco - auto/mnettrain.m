function [ network ] = mnettrain (configuracao,network,dado)
mkdir([configuracao.save '\save']);
file = [configuracao.save '\save\treino-'];
inicio = 1;
save([file 'dado'],'dado');
save([file 'network'],'inicio','network');
% load([file 'dado']);
% load([file 'network']);
clc;
fprintf('\nTreinando as Redes Neurais: %d\n',network.net_train);
fprintf('=================================================');
%Treino
inicio2 = inicio;
for i = inicio2:length(network.redes_aux)
    net = network.redes_aux{i};
    net.trainParam.epochs = network.net_epochs;
    net.trainParam.lr = network.net_lr;
    fprintf('\nTreinamento ');
    dur = duration;
    for j = 1:network.net_train
        fprintf('%d,',j);
        tempo = datetime;
        switch network.resource
            case 3
                [net,tr] = train(net,dado.input,dado.target,'useParallel','yes','useGPU','yes');
            case 2
                [net,tr] = train(net,dado.input,dado.target,'useParallel','yes');
            otherwise
                [net,tr] = train(net,dado.input,dado.target);
        end
        network.redes(i).tempo{j} = datetime - tempo;
        dur = dur+network.redes(i).tempo{j};
        network.redes(i).rede{j} = net;
        network.redes(i).rede_treino{j} = tr;
        
        output = net(dado.input);
        [trOut,trTarg,vOut,vTarg,tsOut,tsTarg] = net_regression_array( tr,dado,output );
        
        network.redes(i).treino{j} = get_error(trTarg,trOut);
        network.redes(i).validacao{j} = get_error(vTarg,vOut);
        network.redes(i).teste{j}  = get_error(tsTarg,tsOut);
        network.redes(i).all{j} = get_error(dado.target,output);
        
        
    end
    fprintf('\n\t%s | %s | %s | %s\n',dur,...
        network.redes(i).tipo,...
        network.redes(i).trainFcnName,...
        network.redes(i).transferFcn);
    fprintf('\t Treino: %f | Validacao: %f | Teste: %f | All: %f \n',...
        network.redes(i).treino{end}.mse,...
        network.redes(i).validacao{end}.mse,...
        network.redes(i).teste{end}.mse,...
        network.redes(i).all{end}.mse);
    fprintf('-------------------------------------------------\n');
    network.redes_aux{i} = net;
    inicio = i+1;
    save([file 'network'],'inicio','network');
end
delete([file 'dado.mat']);
delete([file 'network.mat']);
nntraintool('close');
end