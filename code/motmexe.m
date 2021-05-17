function resultado = motmexe(configuracao,dado,network,otimizacao)

clc;
pasta = sprintf('OTM %s',datetime('now','Format','yyyy-MM-dd-HH-mm-ss'));
path = [configuracao.save,'\',pasta,'\ga'];
mkdir([path,'\fig']);
mkdir([path,'\png']);
path2 = [configuracao.save,'\',pasta,'\pso'];
mkdir([path2,'\fig']);
mkdir([path2,'\png']);
path3 = [configuracao.save,'\',pasta,'\sa'];
mkdir([path3,'\fig']);
mkdir([path3,'\png']);

%%
%Otimização da Função
clc;
fprintf('\nDados para o Plot 2d da Função\n');
if dado.tipo
    value = dado.inputVal{2,3}:dado.inputVal{2,4};
    %Distancia
    if otimizacao.distacia < dado.inputVal{1,3}
        value2 = otimizacao.distacia:dado.inputVal{1,4};
    else
        if otimizacao.distacia > dado.inputVal{1,4}
            value2 = dado.inputVal{1,3}:otimizacao.distacia;
        else
            value2 = dado.inputVal{1,3}:dado.inputVal{1,4};
        end
    end
    
    fun = @(x)fobj(x,otimizacao.distacia);
    %GA
    clc;
    fprintf('!!!Executando o Método de Otimização!!!\n');
    fprintf('\nOtimização da função Genetic Algorithm...\n');
    tempo = datetime;
    opt = optimoptions(@ga, ...
        'PopulationSize', otimizacao.psize, ...
        'MaxGenerations', otimizacao.pgen, ...
        'EliteCount', otimizacao.peli, ...
        'Display','iter',...
        'PlotFcn', {@gaplotbestf,@gaplotbestindiv},...
        'UseParallel',otimizacao.parallel);
    [resultado.ga.x,...
        resultado.ga.fval,...
        resultado.ga.exitflag,...
        resultado.ga.output,...
        resultado.ga.population,...
        resultado.ga.scores] = ...
        ga(fun,...%Função anônima
        otimizacao.variavel,...
        otimizacao.A,...
        otimizacao.b,...
        otimizacao.Aeq,...
        otimizacao.beq,...
        otimizacao.lb,...
        otimizacao.ub,...
        otimizacao.ConstFunction,...
        opt);
    resultado.ga.tempo = datetime - tempo;
    fig = gcf;
    fig.Name = sprintf('Funcao');
    savefig(sprintf('%s\\%s.fig',[path,'\fig'],fig.Name));
    saveas(gcf,sprintf('%s\\%s.png',[path,'\png'],fig.Name));
    close(fig);
    %Particle Swarm
    clc;
    fprintf('!!!Executando o Método de Otimização!!!\n');
    fprintf('\nOtimização da função Particle Swarm...\n');
    tempo = datetime;
    opt = optimoptions('particleswarm', ...
        'SwarmSize', otimizacao.psize, ...
        'Display','iter',...
        'PlotFcn', {@pswplotbestf},...
        'UseParallel',otimizacao.parallel);
    [resultado.swarm.x,...
        resultado.swarm.fval,...
        resultado.swarm.exitflag,...
        resultado.swarm.output] = ...
        particleswarm(fun,...%Função anônima
        otimizacao.variavel,...
        otimizacao.lb,...
        otimizacao.ub,...
        opt);
    resultado.swarm.tempo = datetime - tempo;
    fig = gcf;
    fig.Name = sprintf('Funcao');
    savefig(sprintf('%s\\%s.fig',[path2,'\fig'],fig.Name));
    saveas(gcf,sprintf('%s\\%s.png',[path2,'\png'],fig.Name));
    close(fig);
    %Simulated Annealing (sa)
    clc;
    fprintf('!!!Executando o Método de Otimização!!!\n');
    fprintf('\nOtimização da função Simulated Annealing...\n');
    tempo = datetime;
    opt = saoptimset('Display','iter',...
        'PlotFcns',{@saplotbestx,@saplotbestf,@saplotx,@saplotf});
    [resultado.sa.x,...
        resultado.sa.fval,...
        resultado.sa.exitflag,...
        resultado.sa.output] = ...
        simulannealbnd(fun,...%Função anônima
        otimizacao.x0,...
        otimizacao.lb,...
        otimizacao.ub,...
        opt);
    resultado.sa.tempo = datetime - tempo;
    fig = gcf;
    fig.Name = sprintf('Funcao');
    savefig(sprintf('%s\\%s.fig',[path3,'\fig'],fig.Name));
    saveas(gcf,sprintf('%s\\%s.png',[path3,'\png'],fig.Name));
    close(fig);
    
    %Dados para o Plot 2d da Função
    resultado.plot.value2dx = value;
    outputF = [];
    for d = 1:length(value)
        outputF(1,d) = fobj(value(d),otimizacao.distacia);
    end
    resultado.plot.output2d = outputF;
    
    %Dados para o Plot 3d da Função
    x = [];
    y = [];
    z = [];
    count = length(value)*length(value2);
    for i = 1:length(value)
        for j = 1:length(value2)
            fprintf('\nDados para o Plot 3d da Função\n');
            fprintf('Insert Data\n');
            fprintf('%d\n',count);
            x(i,j) = value2(j);
            y(i,j) = value(i);
            z(i,j) = fobj(value(i),value2(j));
            count = count-1;
            clc;
        end
    end
    resultado.plot.value3dX = x;
    resultado.plot.value3dY = y;
    resultado.plot.value3dZ = z;
else
    value = {};
    for i = 1:size(dado.inputVal,1)
        list = dado.inputVal{i,3};
        while list(end) < (dado.inputVal{i,4} - 0.2)
            list(end+1) = list(end) + 0.2;
        end
        list(end+1) = dado.inputVal{i,4};
        value{i} = list;
    end
    if size(dado.inputVal,1) == 1 && size(dado.targetVal,1) == 1
        resultado.plot.value2dx = value{1};
    end
    x = [];
    y = [];
    z = [];
    count = 1;
    if size(dado.inputVal,1) == 2 && ...
            (size(dado.targetVal,1) == 1 || size(dado.targetVal,1) == 2)
        for i = 1:length(value{1})
            for j = 1:length(value{2})
                fprintf('\nDados para o Plot 3d da Função\n');
                fprintf('Insert Data\n');
                fprintf('%d\n',count);
                x(i,j) = value{1}(i);
                y(i,j) = value{2}(j);
                count = count+1;
                clc;
            end
        end
    end
    if size(dado.inputVal,1) == 3 && size(dado.targetVal,1) == 1
        for i = 1:length(value{1})
            for j = 1:length(value{2})
                fprintf('\nDados para o Plot 3d da Função\n');
                fprintf('Insert Data\n');
                fprintf('%d\n',count);
                if j <= length(value{3})
                    x(i,j) = value{1}(i);
                    y(i,j) = value{2}(j);
                    z(i,j) = value{3}(j);
                    count = count+1;
                else
                    break;
                end
                clc;
            end
        end
    end
    resultado.plot.value3dX = x;
    resultado.plot.value3dY = y;
    resultado.plot.value3dZ = z;
end
%%
%Otimização da Rede Neural
for iddado = 1:length(network.redes)
    clc;
    rede_index = network.redes(iddado);
    fprintf('!!!Executando o Método de Otimização!!!\n');
    net_print(network.redes(iddado));
    fprintf('\n');
    for idrede = 1:length(rede_index.rede)
        fprintf('Treino: %d de %d\n',idrede,length(rede_index.rede));
        rede.index = rede_index.index;
        net = rede_index.rede{idrede};
        if dado.tipo
            fun = @(x)sum(fobjNet([otimizacao.distacia;x(1)],otimizacao.tipo,net));
            fun2 = @(x)fobjNet([otimizacao.distacia;x(1)],otimizacao.tipo,net);
        else
            fun = @(x)sum(fobjNet(x,otimizacao.tipo,net));
            fun2 = @(x)fobjNet(x,otimizacao.tipo,net);
        end
        %GA
        fprintf('\nGenetic Algorithm\n');
        tempo = datetime;
        opt = optimoptions(@ga, ...
            'PopulationSize', otimizacao.psize, ...
            'MaxGenerations', otimizacao.pgen, ...
            'EliteCount', otimizacao.peli, ...
            'Display','iter',...
            'PlotFcn', {@gaplotbestf,@gaplotbestindiv},...
            'UseParallel',otimizacao.parallel);
        [rede.ga(idrede).x,...
            rede.ga(idrede).fval,...
            rede.ga(idrede).exitflag,...
            rede.ga(idrede).output,...
            rede.ga(idrede).population,...
            rede.ga(idrede).scores] = ...
            ga(fun,...%Função anônima
            otimizacao.variavel,...
            otimizacao.A,...
            otimizacao.b,...
            otimizacao.Aeq,...
            otimizacao.beq,...
            otimizacao.lb,...
            otimizacao.ub,...
            otimizacao.ConstFunction,...
            opt);
        rede.ga(idrede).tempo = datetime - tempo;
        rede.ga(idrede).output = fun2(rede.ga(idrede).x);
        fig = gcf;
        fig.Name = sprintf('Nº%d, Treino %d, Dado %d - %s',rede.index,idrede,iddado,fig.Name);
        savefig(sprintf('%s\\%s.fig',[path,'\fig'],fig.Name));
        saveas(gcf,sprintf('%s\\%s.png',[path,'\png'],fig.Name));
        close(fig);
        %Particle Swarm
        fprintf('\nParticle Swarm\n');
        tempo = datetime;
        opt = optimoptions('particleswarm', ...
            'SwarmSize', otimizacao.psize, ...
            'Display','iter',...
            'PlotFcn', {@pswplotbestf},...
            'UseParallel',otimizacao.parallel);
        [rede.swarm(idrede).x,...
            rede.swarm(idrede).fval,...
            rede.swarm(idrede).exitflag,...
            rede.swarm(idrede).output] = ...
            particleswarm(fun,...%Função anônima
            otimizacao.variavel,...
            otimizacao.lb,...
            otimizacao.ub,...
            opt);
        rede.swarm(idrede).tempo = datetime - tempo;
        rede.swarm(idrede).output = fun2(rede.swarm(idrede).x);
        fig = gcf;
        fig.Name = sprintf('Nº%d, Treino %d, Dado %d - %s',rede.index,idrede,iddado,fig.Name);
        savefig(sprintf('%s\\%s.fig',[path2,'\fig'],fig.Name));
        saveas(gcf,sprintf('%s\\%s.png',[path2,'\png'],fig.Name));
        close(fig);
        %Simulated Annealing (sa)
        fprintf('\nSimulated Annealing\n');
        tempo = datetime;
        opt = saoptimset('Display','iter',...
            'PlotFcns',{@saplotbestx,@saplotbestf,@saplotx,@saplotf});
        [rede.sa(idrede).x,...
            rede.sa(idrede).fval,...
            rede.sa(idrede).exitflag,...
            rede.sa(idrede).output] = ...
            simulannealbnd(fun,...%Função anônima
            otimizacao.x0,...
            otimizacao.lb,...
            otimizacao.ub,...
            opt);
        rede.sa(idrede).tempo = datetime - tempo;
        rede.sa(idrede).output = fun2(rede.sa(idrede).x);
        fig = gcf;
        fig.Name = sprintf('Nº%d, Treino %d, Dado %d - %s',rede.index,idrede,iddado,fig.Name);
        savefig(sprintf('%s\\%s.fig',[path3,'\fig'],fig.Name));
        saveas(gcf,sprintf('%s\\%s.png',[path3,'\png'],fig.Name));
        close(fig);
        
        fprintf('\nPlot Net 2d e 3d\n');
        if dado.tipo
            output = [];
            for d = 1:length(value)
                output(1,d) = net([otimizacao.distacia;value(d)]);
            end
            rede.plot(idrede).output2d = output;
            output = [];
            for i = 1:size(x,1)
                output(i,:) = net([x(i,:);y(i,:)]);
            end
            rede.plot(idrede).value3dZ = output;
        else
            if size(dado.inputVal,1) == 1 && size(dado.targetVal,1) == 1
                rede.plot(idrede).output2d = net(value{1});
            end
            output = [];
            output2 = [];
            if size(dado.inputVal,1) == 2 && size(dado.targetVal,1) == 1
                for i = 1:size(x,1)
                    output(i,:) = net([x(i,:);y(i,:)]);
                end
                rede.plot(idrede).value3dZ = output;
            end
            if size(dado.inputVal,1) == 2 && size(dado.targetVal,1) == 2
                for i = 1:size(x,1)
                    value = net([x(i,:);y(i,:)]);
                    output(i,:) = value(1,:);
                    output2(i,:) = value(2,:);
                end
                rede.plot(idrede).value3dZ = output;
                rede.plot(idrede).value3dC = output2;
            end
            if size(dado.inputVal,1) == 3 && size(dado.targetVal,1) == 1
                for i = 1:size(x,1)
                    output(i,:) = net([x(i,:);y(i,:);z(i,:)]);
                end
                rede.plot(idrede).value3dC = output;
            end
        end
    end
    resultado.redes(iddado) = rede;
    fprintf('!!!Término!!!');
end
close all;
end