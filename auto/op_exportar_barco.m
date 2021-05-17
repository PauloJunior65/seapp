function op_exportar_barco(index,index2,configuracao,resultado,dado,network,otimizacao)
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

%=======================================================
clc
fprintf('!!!barco!!!!\n');
path_plus = [path,'barco\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));

barco = mbarco();

h = {};
h{end+1} = figure;
plot(barco.motor(:,1),barco.motor(:,2));
title('SFOC do Motor');
xlabel('RPM');
ylabel('SFOC');
legend('SFOC');
h{end}.Name = sprintf('DB-SFOC');
h{end}.NumberTitle = 'off';

h{end+1} = figure;
plot(barco.motor(:,1),barco.motor(:,3));
title('PW do Motor');
xlabel('RPM');
ylabel('PW');
legend('PW');
h{end}.Name = sprintf('DB-PW');
h{end}.NumberTitle = 'off';

SFOC = [];
PW = [];
for RPM = 800:2100
    [ SFOC(end+1),PW(end+1) ] = mbarco_rpm(RPM);
end

h{end+1} = figure;
plot(800:2100,SFOC);
title('SFOC do Motor');
xlabel('RPM');
ylabel('SFOC');
legend('SFOC');
h{end}.Name = sprintf('Funcao-SFOC');
h{end}.NumberTitle = 'off';

h{end+1} = figure;
plot(800:2100,PW);
title('PW do Motor');
xlabel('RPM');
ylabel('PW');
legend('PW');
h{end}.Name = sprintf('Funcao-PW');
h{end}.NumberTitle = 'off';

plot_save(path_plus,h);
close all;
%========================================================

clc
fprintf('!!!plot barco2d!!!!\n');
path_plus = [path,'barco2d\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
plot_save(path_plus,plot_2d_barco_fun( resultado,otimizacao ));
for j = 1:length(index2)
    h = plot_2d_barco( index,index2(j),network,resultado,otimizacao);
    plot_save(path_plus,h);
    close all;
end

clc
fprintf('!!!plot barco3d!!!!\n');
path_plus = [path,'barco3d\'];
mkdir(strcat(path_plus,'png'));
mkdir(strcat(path_plus,'fig'));
plot_save(path_plus,plot_3d_barco_fun( resultado,otimizacao ));
for j = 1:length(index2)
    h = plot_3d_barco( index,index2(j),network,resultado,otimizacao);
    plot_save(path_plus,h);
    close all;
end

%========================================================
clc
fprintf('!!!otimizacao!!!!\n');
path_plus = [path,'otimizacao\'];
mkdir(path_plus);

list = {'Nº','Tipo de Rede','Algoritmo de Treinamento',...
    'Algoritmo de Treinamento Nome','Função de Transferência',...
    'GA Velocidade (KM/H)','GA Consumo (L)','GA Tempo',...
    'PSO Velocidade (KM/H)','PSO Consumo (L)','PSO Tempo',...
    'SA Velocidade (KM/H)','SA Consumo (L)','SA Tempo'};
for i = 1:length(index)
    rede = network.redes(index(i));
    rede2 = resultado.redes(index(i));
    ga = rede2.ga(end);
    swarm = rede2.swarm(end);
    sa = rede2.sa(end);
    list(end+1,:) = {rede.index,rede.tipo,rede.trainFcn,...
        rede.trainFcnName,rede.transferFcn,...
        ga.x,ga.fval,sprintf('%s',ga.tempo),...
        swarm.x,swarm.fval,sprintf('%s',swarm.tempo),...
        sa.x,sa.fval,sprintf('%s',sa.tempo)};
end
xlswrite([path_plus,'Redes Neurais - OTM.xlsx'],list);

list = {'Nº','Tipo de Rede','Algoritmo de Treinamento',...
    'Algoritmo de Treinamento Nome','Função de Transferência','Nº Treino',...
    'GA Velocidade (KM/H)','GA Consumo (L)','GA Tempo',...
    'PSO Velocidade (KM/H)','PSO Consumo (L)','PSO Tempo',...
    'SA Velocidade (KM/H)','SA Consumo (L)','SA Tempo'};
for i = 1:length(index)
    for j = 1:length(index2)
        rede = network.redes(index(i));
        rede2 = resultado.redes(index(i));
        ga = rede2.ga(index2(j));
        swarm = rede2.swarm(index2(j));
        sa = rede2.sa(index2(j));
        list(end+1,:) = {rede.index,rede.tipo,rede.trainFcn,...
            rede.trainFcnName,rede.transferFcn,index2(j),...
            ga.x,ga.fval,sprintf('%s',ga.tempo),...
            swarm.x,swarm.fval,sprintf('%s',swarm.tempo),...
            sa.x,sa.fval,sprintf('%s',sa.tempo)};
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
fprintf(fid,'!!!Barco!!!\n');
fprintf(fid,'Distacia Mila: %f\n',otimizacao.distacia);
fprintf(fid,'Distacia KM: %f\n',otimizacao.distacia*1.852);
fprintf(fid,'=====================================================\n');
fprintf(fid,'!!!Função!!!\n');
fprintf(fid,'GA (V: %f km/h; C: %f L)\n',resultado.ga.x,resultado.ga.fval);
fprintf(fid,'PSO (V: %f km/h; C: %f L)\n',resultado.swarm.x,resultado.swarm.fval);
fprintf(fid,'SA (V: %f km/h; C: %f L)\n',resultado.sa.x,resultado.sa.fval);
fprintf(fid,'=====================================================\n');
fprintf(fid,'!!!Otimização GA!!!\n');
tipo = {'1 - Maximizar','2 - Minimizar'};
fprintf(fid,'Tipo: %s\n',tipo{otimizacao.tipo});
fprintf(fid,'Tempo: %s\n',resultado.ga.tempo);
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
fprintf(fid,'Tempo: %s\n',resultado.swarm.tempo);
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
fprintf(fid,'Tempo: %s\n',resultado.sa.tempo);
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

%=====================================================================

clc
fprintf('!!!dados 2d!!!!\n');
path_plus = [path,'dados2d\'];
mkdir(path_plus);

list = {};
list(:,1) = ['Velocidade (KM/H)';num2cell(resultado.plot.value2dx')];
list(:,2) = [sprintf('Função\nConsumo (L)');num2cell(resultado.plot.output2d')];
for i = 1:length(index)
    rede = resultado.redes(index(i));
    list(:,end+1) = [sprintf('Rede Neural N%d\nConsumo (L)',rede.index);...
        num2cell(rede.plot(end).output2d')];
end
xlswrite([path_plus,'Redes Neurais - Dados 2d.xlsx'],list);

list = {};
list(:,1) = ['Velocidade (KM/H)';num2cell(resultado.plot.value2dx')];
list(:,2) = [sprintf('Função\nConsumo (L)');num2cell(resultado.plot.output2d')];
for i = 1:length(index)
    for j = 1:length(index2)
        rede = resultado.redes(index(i));
        list(:,end+1) = [sprintf('Rede Neural\nN-%d TR-%d\nConsumo (L)',...
            rede.index,index2(j));...
            num2cell(rede.plot(index2(j)).output2d')];
    end
end
xlswrite([path_plus,'Redes Neurais - Dados 2d Treino.xlsx'],list);

%=====================================================================

clc
fprintf('!!!dados 3d!!!!\n');
path_plus = [path,'dados3d\'];
mkdir(path_plus);

list = num2cell(resultado.plot.value3dX);
xlswrite([path_plus,'Distancia (NM).xlsx'],list);
list = num2cell(resultado.plot.value3dY);
xlswrite([path_plus,'Velocidade (KM-H).xlsx'],list);
list = num2cell(resultado.plot.value3dZ);
xlswrite([path_plus,'Fução Consumo (L).xlsx'],list);

for i = 1:length(index)
    for j = 1:length(index2)
        rede = resultado.redes(index(i));
        list = num2cell(rede.plot(index2(j)).value3dZ);
        xlswrite([path_plus,sprintf('N-%d; TR-%d; Consumo (L).xlsx',...
            rede.index,index2(j))],list);
    end
end

end

