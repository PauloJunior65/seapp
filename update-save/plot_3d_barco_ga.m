function h = plot_3d_barco_ga( tipo,resultado,otimizacao )
h ={};
for i = 1:length(resultado.redes)
    for j = 1:length(tipo)
        z = resultado.redes(i).plot(tipo(j)).value3dZ;
        h{end+1} = figure;
        mesh(resultado.plot.value3dX,resultado.plot.value3dY,z);
        title(sprintf('Nº%d - Treino %d',resultado.redes(i).index,tipo(j)));
        xlabel('Distancia');
        ylabel('Velocidade');
        zlabel('Consumo');
        h{end}.Name = sprintf('Nº%d - Treino %d; Plot GA 3d',resultado.redes(i).index,tipo(j));
        h{end}.NumberTitle = 'off';
        
        h{end+1} = figure;
        hold on
        mesh(resultado.plot.value3dX,resultado.plot.value3dY,z);
        plot3(otimizacao.distacia,resultado.redes(i).ga(tipo(j)).x,resultado.redes(i).ga(tipo(j)).fval,'-o','Color','b','MarkerSize',10,'MarkerFaceColor','g');
        hold off
        view(3);
        title(sprintf('Nº%d - Treino %d',resultado.redes(i).index,tipo(j)));
        xlabel('Distancia');
        ylabel('Velocidade');
        zlabel('Consumo');
        h{end}.Name = sprintf('Nº%d - Treino %d; Plot GA 3d 2',resultado.redes(i).index,tipo(j));
        h{end}.NumberTitle = 'off';
    end
end
                    


end

