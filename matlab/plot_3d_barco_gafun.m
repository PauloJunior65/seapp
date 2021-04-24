function h = plot_3d_barco_gafun(resultado )
h = {};
h{1} = figure;
mesh(resultado.plot.value3dX,resultado.plot.value3dY,resultado.plot.value3dZ);
title(sprintf('Saida da Função'));
xlabel('Distancia');
ylabel('Velocidade');
zlabel('Consumo');
h{1}.Name = sprintf('Função - Saida');
h{1}.NumberTitle = 'off';

end

