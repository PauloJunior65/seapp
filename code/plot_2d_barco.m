function h = plot_2d_barco( index,treino,network,resultado,otimizacao)
h = {};
for i = 1:length(index)
    for j = 1:length(treino)
        index2 = index(i);
        rede = resultado.redes(index2);
        rede2 = network.redes(index2);
        t = treino(j);
        ga = rede.ga(t);
        swarm = rede.swarm(t);
        sa = rede.sa(t);
        out = rede.plot.output2d;
        
        h{end+1} = figure;
        hold on
        plot(resultado.plot.value2dx,out);
        plot(ga.x,ga.fval,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerSize',10,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','r');
        plot(swarm.x,swarm.fval,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerSize',7,...
            'MarkerEdgeColor','g',...
            'MarkerFaceColor','g');
        plot(sa.x,sa.fval,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerSize',4,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor','b');
        hold off
        grid on;
        title(sprintf('Otimiza��o da Rede Neural\n(ID: %d;TR-N: %d; TR: %s; FA: %s)',...
            rede.index,t,rede2.trainFcnName,rede2.transferFcn));
        xlabel('Velocidade (KM/H)');
        ylabel('Consumo (L)');
        legend({sprintf('Sa�da (D: %0.2f nm)',otimizacao.distacia)
            sprintf('GA (V: %0.2f km/h; C: %0.2f L)',ga.x,ga.fval)
            sprintf('PSO (V: %0.2f km/h; C: %0.2f L)',swarm.x,swarm.fval)
            sprintf('SA (V: %0.2f km/h; C: %0.2f L)',sa.x,sa.fval)});
        h{end}.Name = sprintf('N-%d; TRN-%d; TR-%s; FA-%s; Plot 2d',...
            rede.index,t,rede2.trainFcn,rede2.transferFcn);
        h{end}.NumberTitle = 'off';
    end
end

end

