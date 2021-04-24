function h = plot_2d_barco_gafun( resultado )
h = {};
h{1} = figure;
plot(resultado.plot.value2dx,resultado.plot.output2d,resultado.fun.x,resultado.fun.fval,'g--o','MarkerFaceColor','r');
title(sprintf('Melhor Velocidade para a Distacia %f nm é %f Km/h',resultado.otimizacao.distacia,resultado.fun.x));
xlabel('Velocidade KM/H');
ylabel('Consumo em Litro');
legend({'Função','Ponto Ótimo'});
h{1}.Name = sprintf('Função');
h{1}.NumberTitle = 'off';


end

