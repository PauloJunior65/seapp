function h = plot_3d_barco_gafun(resultado,otimizacao)
h = {};
h{1} = figure;
mesh(resultado.plot.value3dX,resultado.plot.value3dY,resultado.plot.value3dZ);
title(sprintf('Saida da Fun��o'));
xlabel('Distancia');
ylabel('Velocidade');
zlabel('Consumo');
h{1}.Name = sprintf('Fun��o - Saida');
h{1}.NumberTitle = 'off';

end

