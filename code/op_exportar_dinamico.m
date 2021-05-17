function op_exportar_dinamico(index,index2,configuracao,resultado,dado,network,otimizacao)
clc;
path = sprintf('%s',datetime('now','Format','yyyy-MM-dd-HH-mm-ss'));
path = [configuracao.save,'\',path,'\'];
mkdir(path);

if isempty(index)
    index = 1:length(network.redes);
end
if isempty(index2)
    index2 = 1:length(network.redes(1).rede);
end

%========================================================

clc
fprintf('!!!plot otm!!!!\n');
path_plus = [path,'otm\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
for j = 1:length(index2)
    h = plot_dinamico( index,index2(j),network,resultado);
    plot_save(path_plus,h);
    close all;
end

%========================================================

clc
fprintf('!!!otimizacao!!!!\n');
path_plus = [path,'otimizacao\'];
mkdir(path_plus);

otm = {};
for i = 1:size(dado.inputVal,1)
    otm{1,end+1} = ['GA ',dado.inputVal{i,2}];
end
for i = 1:size(dado.targetVal,1)
    otm{1,end+1} = ['GA ',dado.targetVal{i,2}];
end
otm{1,end+1} = 'GA Tempo';
for i = 1:size(dado.inputVal,1)
    otm{1,end+1} = ['PSO ',dado.inputVal{i,2}];
end
for i = 1:size(dado.targetVal,1)
    otm{1,end+1} = ['PSO ',dado.targetVal{i,2}];
end
otm{1,end+1} = 'PSO Tempo';
for i = 1:size(dado.inputVal,1)
    otm{1,end+1} = ['SA ',dado.inputVal{i,2}];
end
for i = 1:size(dado.targetVal,1)
    otm{1,end+1} = ['SA ',dado.targetVal{i,2}];
end
otm{1,end+1} = 'SA Tempo';

list = [{'Nº','Tipo de Rede','Algoritmo de Treinamento',...
    'Algoritmo de Treinamento Nome','Função de Transferência'},otm];
for i = 1:length(index)
    rede = network.redes(index(i));
    rede2 = resultado.redes(index(i));
    ga = rede2.ga(end);
    swarm = rede2.swarm(end);
    sa = rede2.sa(end);
    
    aux = {rede.index,rede.tipo,rede.trainFcn,...
        rede.trainFcnName,rede.transferFcn};
    
    for j = 1:size(dado.inputVal,1)
        aux(1,end+1) = ga.x(j);
    end
    for j = 1:size(dado.targetVal,1)
        aux{1,end+1} = ga.output(j);
    end
    aux{1,end+1} = sprintf('%s',ga.tempo);
    
    for j = 1:size(dado.inputVal,1)
        aux(1,end+1) = swarm.x(j);
    end
    for j = 1:size(dado.targetVal,1)
        aux{1,end+1} = swarm.output(j);
    end
    aux{1,end+1} = sprintf('%s',swarm.tempo);
    
    for j = 1:size(dado.inputVal,1)
        aux(1,end+1) = sa.x(j);
    end
    for j = 1:size(dado.targetVal,1)
        aux{1,end+1} = sa.output(j);
    end
    aux{1,end+1} = sprintf('%s',sa.tempo);
    
    list(end+1,:) = aux;
end
xlswrite([path_plus,'Redes Neurais - OTM.xlsx'],list);

list = [{'Nº','Tipo de Rede','Algoritmo de Treinamento',...
    'Algoritmo de Treinamento Nome','Função de Transferência','Nº Treino'},otm];
for i = 1:length(index)
    for j = 1:length(index2)
        rede = network.redes(index(i));
        rede2 = resultado.redes(index(i));
        ga = rede2.ga(index2(j));
        swarm = rede2.swarm(index2(j));
        sa = rede2.sa(index2(j));
        
        aux = {rede.index,rede.tipo,rede.trainFcn,...
            rede.trainFcnName,rede.transferFcn,index2(j)};
        
        for z = 1:size(dado.inputVal,1)
            aux(1,end+1) = ga.x(z);
        end
        for z = 1:size(dado.targetVal,1)
            aux{1,end+1} = ga.output(z);
        end
        aux{1,end+1} = sprintf('%s',ga.tempo);
        
        for z = 1:size(dado.inputVal,1)
            aux(1,end+1) = swarm.x(z);
        end
        for z = 1:size(dado.targetVal,1)
            aux{1,end+1} = swarm.output(z);
        end
        aux{1,end+1} = sprintf('%s',swarm.tempo);
        
        for z = 1:size(dado.inputVal,1)
            aux(1,end+1) = sa.x(z);
        end
        for z = 1:size(dado.targetVal,1)
            aux{1,end+1} = sa.output(z);
        end
        aux{1,end+1} = sprintf('%s',sa.tempo);
        
        list(end+1,:) = aux;
    end
end
xlswrite([path_plus,'Redes Neurais - OTM Treinos.xlsx'],list);

%=====================================================================

fid = fopen( strcat(path_plus,'parametros.txt'), 'wt' );
fprintf(fid,'!!!Dados!!!');
fprintf(fid,'--------Input---------');
fprintf(fid,'Size: %d x %d\n',size(dado.input,1),size(dado.input,2));
for i = 1:size(dado.inputVal,1)
    fprintf(fid,'Input %d => C: %d | N: %s | MIN: %d | MAX: %s\n',i,...
        dado.inputVal{i,1},dado.inputVal{i,2},...
        dado.inputVal{i,3},dado.inputVal{i,4});
end
fprintf(fid,'--------Output--------');
fprintf(fid,'Size: %d x %d\n',size(dado.target,1),size(dado.target,2));
for i = 1:size(dado.targetVal,1)
    fprintf(fid,'Target %d => C: %d | N: %s | MIN: %d | MAX: %s\n',i,...
        dado.targetVal{i,1},dado.targetVal{i,2},...
        dado.targetVal{i,3},dado.targetVal{i,4});
end
fprintf(fid,'=====================================================\n');
fprintf(fid,'!!!Otimização GA!!!\n');
tipo = {'1 - Maximizar','2 - Minimizar'};
fprintf(fid,'Tipo: %s\n',tipo{otimizacao.tipo});
fprintf(fid,'nvars: %d\n',otimizacao.variavel);
fprintf(fid,'lb: %f\n',otimizacao.lb);
fprintf(fid,'ub: %f\n',otimizacao.ub);
fprintf(fid,'PopulationSize: %d\n',otimizacao.psize);
fprintf(fid,'MaxGenerations: %d\n',otimizacao.pgen);
fprintf(fid,'EliteCount: %d\n',otimizacao.peli);
fprintf(fid,'UseParallel: %d\n',otimizacao.parallel);
fprintf(fid,'FitnessScalingFcn: fitscalingrank\n');
fprintf(fid,'MaxStallTime: Inf\n');
fprintf(fid,'NonlinearConstraintAlgorithm: auglag\n');
fprintf(fid,'SelectionFcn: selectionstochunif\n');
fprintf(fid,'ConstraintTolerance: 0.001\n');
fprintf(fid,'CreationFcn: gacreationuniform\n');
fprintf(fid,'CrossoverFcn: crossoverscattered\n');
fprintf(fid,'CrossoverFraction: 0.8\n');
fprintf(fid,'FunctionTolerance: 0.000001\n');
fprintf(fid,'MaxStallGenerations: 50\n');
fprintf(fid,'MaxTime: Inf\n');
fprintf(fid,'MutationFcn: mutationgaussian\n');
fprintf(fid,'PopulationType: doubleVector\n');
fprintf(fid,'HybridFcn: []\n');
fprintf(fid,'InitialPopulationMatrix: []\n');
fprintf(fid,'InitialPopulationRange: []\n');
fprintf(fid,'InitialScoresMatrix: []\n');
fprintf(fid,'OutputFcn: []\n');
fprintf(fid,'A: [] -> Coeficientes de Desigualda\n');
fprintf(fid,'b: [] -> Termo Independente\n');
fprintf(fid,'Aeq: [] -> Coeficientes de Igualdade\n');
fprintf(fid,'beq: [] -> Termo Independente\n');
fprintf(fid,'ConstFunction: [] -> Função de Restrição\n');
fprintf(fid,'=====================================================\n');
fprintf(fid,'!!!Otimização PSO!!!\n');
tipo = {'1 - Maximizar','2 - Minimizar'};
fprintf(fid,'Tipo: %s\n',tipo{otimizacao.tipo});
fprintf(fid,'nvars: %d\n',otimizacao.variavel);
fprintf(fid,'lb: %f\n',otimizacao.lb);
fprintf(fid,'ub: %f\n',otimizacao.ub);
fprintf(fid,'CreationFcn: pswcreationuniform\n');
fprintf(fid,'FunctionTolerance: 0.000001\n');
fprintf(fid,'InertiaRange: [0.1 1.1]\n');
fprintf(fid,'InitialSwarmSpan: 2000\n');
fprintf(fid,'MaxIterations: 200*numberofvariables\n');
fprintf(fid,'MaxStallIterations: 20\n');
fprintf(fid,'MaxStallTime: Inf\n');
fprintf(fid,'MaxTime: Inf\n');
fprintf(fid,'MinNeighborsFraction: 0.25\n');
fprintf(fid,'ObjectiveLimit: -Inf\n');
fprintf(fid,'SelfAdjustmentWeight: 1.49\n');
fprintf(fid,'SocialAdjustmentWeight: 1.49\n');
fprintf(fid,'SwarmSize: %d\n',otimizacao.psize);
fprintf(fid,'UseParallel: %d\n',otimizacao.parallel);
fprintf(fid,'HybridFcn: []\n');
fprintf(fid,'InitialSwarmMatrix: []\n');
fprintf(fid,'OutputFcn: []\n');
fprintf(fid,'=====================================================\n');
fprintf(fid,'!!!Otimização SA!!!\n');
tipo = {'1 - Maximizar','2 - Minimizar'};
fprintf(fid,'Tipo: %s\n',tipo{otimizacao.tipo});
fprintf(fid,'x0: %f\n',otimizacao.x0);
fprintf(fid,'lb: %f\n',otimizacao.lb);
fprintf(fid,'ub: %f\n',otimizacao.ub);
fprintf(fid,'AcceptanceFcn: acceptancesa\n');
fprintf(fid,'AnnealingFcn: annealingfast\n');
fprintf(fid,'DataType: double\n');
fprintf(fid,'FunctionTolerance: 0.000001\n');
fprintf(fid,'InitialTemperature: 100\n');
fprintf(fid,'MaxFunctionEvaluations: 3000*numberOfVariables\n');
fprintf(fid,'MaxIterations: Inf\n');
fprintf(fid,'MaxStallIterations: 500*numberOfVariables\n');
fprintf(fid,'MaxTime: Inf\n');
fprintf(fid,'ObjectiveLimit: -Inf\n');
fprintf(fid,'OutputFcn: []\n');
fprintf(fid,'HybridFcn: []\n');
fprintf(fid,'HybridInterval: end\n');
fprintf(fid,'ReannealInterval: 100\n');
fprintf(fid,'TemperatureFcn: temperatureexp\n');
fprintf(fid,'=====================================================\n');
fclose(fid);


end

