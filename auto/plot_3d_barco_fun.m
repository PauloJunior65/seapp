function h = plot_3d_barco_fun(resultado,otimizacao)
h = {};

h{1} = figure;
mesh(resultado.plot.value3dX,resultado.plot.value3dY,resultado.plot.value3dZ);
grid on;
title(sprintf('Saida da Fun��o\nDistancia: %0.2f',otimizacao.distacia));
xlabel('Distancia (nmi)');
ylabel('Velocidade (km/h)');
zlabel('Consumo (L)');
h{1}.Name = sprintf('Fun��o - Saida');
h{1}.NumberTitle = 'off';

h{2} = figure;
hold on
mesh(resultado.plot.value3dX,resultado.plot.value3dY,resultado.plot.value3dZ);
plot3(otimizacao.distacia,resultado.ga.x,resultado.ga.fval,...
    'LineStyle','none',...
    'Marker','+',...
    'MarkerSize',10,...
    'MarkerEdgeColor','r');
plot3(otimizacao.distacia,resultado.swarm.x,resultado.swarm.fval,...
    'LineStyle','none',...
    'Marker','x',...
    'MarkerSize',10,...
    'MarkerEdgeColor','g');
plot3(otimizacao.distacia,resultado.sa.x,resultado.sa.fval,...
    'LineStyle','none',...
    'Marker','o',...
    'MarkerSize',10,...
    'MarkerEdgeColor','b');
hold off
grid on;
legend({sprintf('Sa�da da Fun��o')
    sprintf('GA (D: %0.2f nmi; V: %0.2f km/h; C: %0.2f L)',otimizacao.distacia,resultado.ga.x,resultado.ga.fval)
    sprintf('PSO (D: %0.2f nmi; V: %0.2f km/h; C: %0.2f L)',otimizacao.distacia,resultado.swarm.x,resultado.swarm.fval)
    sprintf('SA (D: %0.2f nmi; V: %0.2f km/h; C: %0.2f L)',otimizacao.distacia,resultado.sa.x,resultado.sa.fval)});
title(sprintf('Saida da Fun��o'));
xlabel('Distancia (nmi)');
ylabel('Velocidade (km/h)');
zlabel('Consumo (L)');
view(3);
h{2}.Name = sprintf('Fun��o - Saida Comp');
h{2}.NumberTitle = 'off';

end

