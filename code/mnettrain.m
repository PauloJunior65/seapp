function [ network ] = mnettrain (configuracao,network,dado)
mkdir([configuracao.save '\save']);
file = [configuracao.save '\save\treino-'];
clc;
fprintf('Treino:\n\t1-Novo\n\t2-Save\n');
switch input('opcao:')
    case 1
        inicio = 1;
        network.net_train = input('(int) Número de Treino:');
        network.net_epochs = input('(int) Número máximo de iterações de cada Treino:');
        network.net_lr = input('Taxa de aprendizagem\n Exemplo "0.0001"\n(double):');
        fprintf('\nResources:\n\t1-Normal\n\t2-Parallel\n\t3-Parallel e GPU\n');
        network.resource = input('(int) opcao:');
        %Reset
        for i = 1:length(network.redes_aux)
            network.redes(i).rede = {};
            network.redes(i).rede_treino = {};
            network.redes(i).tempo = {};
            network.redes(i).treino = {};
            network.redes(i).validacao = {};
            network.redes(i).teste = {};
            network.redes(i).all = {};
        end
        save([file 'dado'],'dado');
        save([file 'network'],'inicio','network');
    case 2
        load([file 'dado']);
        load([file 'network']);
end


clc;
fprintf('\nTreinando as Redes Neurais: %d\n',network.net_train);
fprintf('=================================================');
%Treino
if network.resource > 1
    parfor i = 1:1
    end
end
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