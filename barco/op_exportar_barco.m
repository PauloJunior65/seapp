function op_exportar_barco(dado,otimizacao,path)
clc;
mkdir([path,'png']);
mkdir([path,'fig']);

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

SFOC_new = [];
SFOC_old = [];
PW_new = [];
PW_old = [];
for RPM = 800:2100
    [ SFOC_new(end+1),PW_new(end+1) ] = mbarco_rpm(RPM);
    [ SFOC_old(end+1),PW_old(end+1) ] = mbarco_rpm_old(RPM);
end
h{end+1} = figure;
plot(800:2100,SFOC_new);
title('SFOC do Motor');
xlabel('RPM');
ylabel('SFOC');
legend('SFOC');
h{end}.Name = sprintf('Funcao-SFOC-New');
h{end}.NumberTitle = 'off';

h{end+1} = figure;
plot(800:2100,PW_new);
title('PW do Motor');
xlabel('RPM');
ylabel('PW');
legend('PW');
h{end}.Name = sprintf('Funcao-PW-New');
h{end}.NumberTitle = 'off';


h{end+1} = figure;
plot(800:2100,SFOC_old);
title('SFOC do Motor');
xlabel('RPM');
ylabel('SFOC');
legend('SFOC');
h{end}.Name = sprintf('Funcao-SFOC-Old');
h{end}.NumberTitle = 'off';

h{end+1} = figure;
plot(800:2100,PW_old);
title('PW do Motor');
xlabel('RPM');
ylabel('PW');
legend('PW');
h{end}.Name = sprintf('Funcao-PW-Old');
h{end}.NumberTitle = 'off';


fprintf('!!!Executando o Método de Otimização!!!\n');
fprintf('\nOtimização da função...\n');
opt = optimoptions(@ga, ...
    'PopulationSize', otimizacao.psize, ...
    'HybridFcn',@fmincon,...
    'MaxGenerations', otimizacao.pgen, ...
    'EliteCount', otimizacao.peli, ...
    'FunctionTolerance', 1e-8,...
    'Display','iter',...
    'PlotFcn', {@gaplotbestf,@gaplotbestindiv},...
    'UseParallel',true);
fun = @(x)fobj(x,otimizacao.distacia);
[fun_new.x,...
    fun_new.fval,...
    fun_new.exitflag,...
    fun_new.output,...
    fun_new.population,...
    fun_new.scores] = ...
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
fig.Name = 'Funcao-GA-New';
savefig(sprintf('%s\\%s.fig',[path,'fig'],fig.Name));
saveas(gcf,sprintf('%s\\%s.png',[path,'png'],fig.Name));
close(fig);

fun = @(x)fobj_old(x,otimizacao.distacia);
[fun_old.x,...
    fun_old.fval,...
    fun_old.exitflag,...
    fun_old.output,...
    fun_old.population,...
    fun_old.scores] = ...
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
fig.Name = 'Funcao-GA-Old';
savefig(sprintf('%s\\%s.fig',[path,'fig'],fig.Name));
saveas(gcf,sprintf('%s\\%s.png',[path,'png'],fig.Name));
close(fig);

velocidade = dado.inputVal{2,3}:dado.inputVal{2,4};
if otimizacao.distacia < dado.inputVal{1,3}
    distacia = otimizacao.distacia:dado.inputVal{1,4};
else
    if otimizacao.distacia > dado.inputVal{1,4}
        distacia = dado.inputVal{1,3}:otimizacao.distacia;
    else
        distacia = dado.inputVal{1,3}:dado.inputVal{1,4};
    end
end

cosumo_new = [];
cosumo_old = [];
for d = 1:length(velocidade)
    cosumo_new(1,d) = fobj(velocidade(d),otimizacao.distacia);
    cosumo_old(1,d) = fobj_old(velocidade(d),otimizacao.distacia);
end
h{end+1} = figure;
plot(velocidade,cosumo_new,fun_new.x,fun_new.fval,'g--o','MarkerFaceColor','r');
title(sprintf('Melhor Velocidade para a Distacia %f nm é %f Km/h',otimizacao.distacia,fun_new.x));
xlabel('Velocidade KM/H');
ylabel('Consumo em Litro');
legend({'Função','Ponto Ótimo'});
h{end}.Name = sprintf('Função 2d - New');
h{end}.NumberTitle = 'off';
h{end+1} = figure;
plot(velocidade,cosumo_old,fun_old.x,fun_old.fval,'g--o','MarkerFaceColor','r');
title(sprintf('Melhor Velocidade para a Distacia %f nm é %f Km/h',otimizacao.distacia,fun_old.x));
xlabel('Velocidade KM/H');
ylabel('Consumo em Litro');
legend({'Função','Ponto Ótimo'});
h{end}.Name = sprintf('Função 2d - Old');
h{end}.NumberTitle = 'off';
%Dados para o Plot 3d da Função
x = [];
y = [];
z_new = [];
z_old = [];
count = length(velocidade)*length(distacia);
for i = 1:length(velocidade)
    for j = 1:length(distacia)
        fprintf('\nDados para o Plot 3d da Função\n');
        fprintf('Insert Data\n');
        fprintf('%d\n',count);
        x(i,j) = distacia(j);
        y(i,j) = velocidade(i);
        z_new(i,j) = fobj(velocidade(i),distacia(j));
        z_old(i,j) = fobj_old(velocidade(i),distacia(j));
        count = count-1;
        clc;
    end
end
h{end+1} = figure;
mesh(x,y,z_new);
title(sprintf('Saida da Função'));
xlabel('Distancia');
ylabel('Velocidade');
zlabel('Consumo');
h{end}.Name = sprintf('Função 3d - New');
h{end}.NumberTitle = 'off';
h{end+1} = figure;
mesh(x,y,z_old);
title(sprintf('Saida da Função'));
xlabel('Distancia');
ylabel('Velocidade');
zlabel('Consumo');
h{end}.Name = sprintf('Função 3d - Old');
h{end}.NumberTitle = 'off';
plot_save(path,h);
close all;

end

