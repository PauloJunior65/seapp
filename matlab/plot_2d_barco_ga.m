function h = plot_2d_barco_ga( tipo,resultado )
h = {};
for i = 1:length(resultado.redes)
    for j = 1:length(tipo)
        h{end+1} = figure;
        hold on;
        plot(resultado.plot.value2dx,resultado.plot.output2d,...
            resultado.fun.x,resultado.fun.fval,'g--o','MarkerFaceColor','r');
        plot(resultado.plot.value2dx,resultado.redes(i).plot(tipo(j)).output2d,...
            resultado.redes(i).ga(tipo(j)).x,resultado.redes(i).ga(tipo(j)).fval,'g--o','MarkerFaceColor','g');
        hold off;
        title(sprintf('Melhor Velocidade para a Distacia %f nm é %f Km/h do Treino %d',resultado.otimizacao.distacia,resultado.redes(i).ga(tipo(j)).x,tipo(j)));
        xlabel('Velocidade KM/H');
        ylabel('Consumo em Litro');
        legend({'Função','Ponto Ótimo','Função Net','Ponto Ótimo Net'});
        h{end}.Name = sprintf('Nº%d - Treino %d; Plot GA 2d',resultado.redes(i).index,tipo(j));
        h{end}.NumberTitle = 'off';
    end
end

end

