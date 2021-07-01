function h = plot_3d_barco( index,treino,network,resultado,otimizacao)
h ={};
for i = 1:length(resultado.redes)
    for j = 1:length(treino)
        index2 = index(i);
        rede = resultado.redes(index2);
        rede2 = network.redes(index2);
        t = treino(j);
        ga = rede.ga(t);
        swarm = rede.swarm(t);
        sa = rede.sa(t);
        z = rede.plot(t).value3dZ;
        
        h{end+1} = figure;
        mesh(resultado.plot.value3dX,resultado.plot.value3dY,z);
        grid on;
        title(sprintf('Saida da Rede Neural\n(N-%d; TRN-%d; TR-%s; FA-%s)',...
            rede.index,t,rede2.trainFcnName,rede2.transferFcn));
        xlabel('Distancia (nmi)');
        ylabel('Velocidade (km/h)');
        zlabel('Consumo (L)');
        h{end}.Name = sprintf('N-%d; TRN-%d; TR-%s; FA-%s; Plot 3d',...
            rede.index,t,rede2.trainFcn,rede2.transferFcn);
        h{end}.NumberTitle = 'off';
        
        h{end+1} = figure;
        hold on
        mesh(resultado.plot.value3dX,resultado.plot.value3dY,z);
        plot3(otimizacao.distacia,ga.x,ga.fval,...
            'LineStyle','none',...
            'Marker','+',...
            'MarkerSize',10,...
            'MarkerEdgeColor','r');
        plot3(otimizacao.distacia,swarm.x,swarm.fval,...
            'LineStyle','none',...
            'Marker','x',...
            'MarkerSize',10,...
            'MarkerEdgeColor','g');
        plot3(otimizacao.distacia,sa.x,sa.fval,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerSize',10,...
            'MarkerEdgeColor','b');
        hold off
        grid on;
        legend({sprintf('Saída da Rede Neural')
            sprintf('GA (D: %0.2f nmi; V: %0.2f km/h; C: %0.2f L)',otimizacao.distacia,ga.x,ga.fval)
            sprintf('PSO (D: %0.2f nmi; V: %0.2f km/h; C: %0.2f L)',otimizacao.distacia,swarm.x,swarm.fval)
            sprintf('SA (D: %0.2f nmi; V: %0.2f km/h; C: %0.2f L)',otimizacao.distacia,sa.x,sa.fval)});
        title(sprintf('Saida da Rede Neural\n(N-%d; TRN-%d; TR-%s; FA-%s)',...
            rede.index,t,rede2.trainFcnName,rede2.transferFcn));
        xlabel('Distancia (nmi)');
        ylabel('Velocidade (km/h)');
        zlabel('Consumo (L)');
        view(3);
        h{end}.Name = sprintf('N-%d; TRN-%d; TR-%s; FA-%s; Plot 3d Comp',...
            rede.index,t,rede2.trainFcn,rede2.transferFcn);
        h{end}.NumberTitle = 'off';
    end
end

end

