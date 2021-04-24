function h = plot_3d_barco_ga( tipo,resultado )
h ={};
for i = 1:length(resultado.redes)
    for j = 1:length(tipo)
        net = resultado.redes(i).rede{tipo(j)};
        z = resultado.redes(i).plot(tipo(j)).value3dZ;
        h{end+1} = figure;
        mesh(resultado.plot.value3dX,resultado.plot.value3dY,z);
        title(sprintf('Saida do %s do Treino %d',net.name,tipo(j)));
        xlabel('Distancia');
        ylabel('Velocidade');
        zlabel('Consumo');
        h{end}.Name = sprintf('Nº%d - Treino %d; Plot GA 3d',resultado.redes(i).index,tipo(j));
        h{end}.NumberTitle = 'off';
        
        h{end+1} = figure;
        hold on
        mesh(resultado.plot.value3dX,resultado.plot.value3dY,z);
        plot3(resultado.otimizacao.distacia,resultado.redes(i).ga(tipo(j)).x,resultado.redes(i).ga(tipo(j)).fval,'-o','Color','b','MarkerSize',10,'MarkerFaceColor','g');
        hold off
        view(3);
        title(sprintf('Saida do %s do Treino %d',net.name,tipo(j)));
        xlabel('Distancia');
        ylabel('Velocidade');
        zlabel('Consumo');
        h{end}.Name = sprintf('Nº%d - Treino %d; Plot GA 3d 2',resultado.redes(i).index,tipo(j));
        h{end}.NumberTitle = 'off';
    end
end
                    


end

