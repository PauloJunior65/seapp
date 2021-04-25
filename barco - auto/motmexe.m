function resultado = motmexe(configuracao,dado,network,otimizacao)

clc;
path = [configuracao.save '\ga'];
mkdir([path,'\fig']);
mkdir([path,'\png']);
for iddado = 1:length(network.redes)
    clc;
    rede_index = network.redes(iddado);
    fprintf('!!!Executando o Método de Otimização!!!\n');
    net_print(network.redes(iddado));
    fprintf('\n')
    for idrede = 1:length(rede_index.rede)
        fprintf('Treino: %d de %d\n',idrede,length(rede_index.rede));
        rede.index = rede_index.index;
        net = rede_index.rede{idrede};
        fun = @(x)fobjNet([otimizacao.distacia;x(1)],otimizacao.tipo,net);
        opt = optimoptions(@ga, ...
            'PopulationSize', otimizacao.psize, ...
            'HybridFcn',@fmincon,...
            'MaxGenerations', otimizacao.pgen, ...
            'EliteCount', otimizacao.peli, ...
            'FunctionTolerance', 1e-8,...
            'Display','iter',...
            'PlotFcn', {@gaplotbestf,@gaplotbestindiv},...
            'UseParallel',true);
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
        fig = gcf;
        fig.Name = sprintf('Nº%d, Treino %d, Dado %d - %s',rede.index,idrede,iddado,fig.Name);
        savefig(sprintf('%s\\%s.fig',[path,'\fig'],fig.Name));
        saveas(gcf,sprintf('%s\\%s.png',[path,'\png'],fig.Name));
        close(fig);
        %Dados para o Plot
        rede.plot(idrede).output2d = [];
        rede.plot(idrede).value3dZ = [];
    end
    resultado.redes(iddado) = rede;
    fprintf('!!!Término!!!');
end
close all;

clc;
fprintf('!!!Executando o Método de Otimização!!!\n');
fprintf('\nOtimização da função...\n');
fun = @(x)fobj(x,otimizacao.distacia);
opt = optimoptions(@ga, ...
    'PopulationSize', otimizacao.psize, ...
    'HybridFcn',@fmincon,...
    'MaxGenerations', otimizacao.pgen, ...
    'EliteCount', otimizacao.peli, ...
    'FunctionTolerance', 1e-8,...
    'Display','iter',...
    'PlotFcn', {@gaplotbestf,@gaplotbestindiv},...
    'UseParallel',true);
[resultado.fun.x,...
    resultado.fun.fval,...
    resultado.fun.exitflag,...
    resultado.fun.output,...
    resultado.fun.population,...
    resultado.fun.scores] = ...
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
fig = gcf;
fig.Name = sprintf('Funcao');
savefig(sprintf('%s/%s.fig',path,fig.Name));
saveas(gcf,sprintf('%s/%s.png',path,fig.Name));
close(fig);


clc;
fprintf('\nDados para o Plot 2d da Função\n');
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

for iddado = 1:length(network.redes)
    for idrede = 1:length(network.redes(iddado).rede)
        clc;
        fprintf('Plot Net 2d e 3d\n');
        fprintf('Dado: %d de %d\n',iddado,length(network.redes));
        fprintf('Net: %d de %d\n',idrede,length(network.redes(iddado).rede));
        
        net = network.redes(iddado).rede{idrede};
        
        output = [];
        for d = 1:length(value)
            output(1,d) = net([otimizacao.distacia;value(d)]);
        end
        resultado.redes(iddado).plot(idrede).output2d = output;
        
        output = [];
        for i = 1:size(x,1)
            output(i,:) = net([x(i,:);y(i,:)]);
        end
        resultado.redes(iddado).plot(idrede).value3dZ = output;
    end
end

end