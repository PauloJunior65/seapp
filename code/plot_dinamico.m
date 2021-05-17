function h = plot_dinamico( index,treino,network,resultado)

h ={};
for i = 1:length(index)
    for j = 1:length(treino)
        index2 = index(i);
        rede = resultado.redes(index2);
        rede2 = network.redes(index2);
        t = treino(j);
        ga = rede.ga(t);
        swarm = rede.swarm(t);
        sa = rede.sa(t);
        
        h{end+1} = figure;
        
        if size(dado.inputVal,1) == 1 && size(dado.targetVal,1) == 1
            hold on
            plot(resultado.plot.value2dx,rede.plot(t).output2d);
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
            title(sprintf('Otimiza��o da Rede Neural\n(ID: %d;TR-N: %d; TR: %s; FA: %s)',...
                rede.index,t,rede2.trainFcnName,rede2.transferFcn));
            xlabel(dado.inputVal{1,2});
            ylabel(dado.targetVal{1,2});
            legend({sprintf('Sa�da da Rede Neural')
                sprintf('GA (IN: %0.2f; OUT: %0.2f)',ga.x,ga.fval)
                sprintf('PSO (IN: %0.2f; OUT: %0.2f)',swarm.x,swarm.fval)
                sprintf('SA (IN: %0.2f; OUT: %0.2f)',sa.x,sa.fval)});
        end
        
        if size(dado.inputVal,1) == 2 && size(dado.targetVal,1) == 1
            hold on
            mesh(resultado.plot.value3dX,...
                resultado.plot.value3dY,...
                rede.plot(t).value3dZ);
            plot3(ga.x(1),ga.x(2),ga.fval,...
                'LineStyle','none',...
                'Marker','+',...
                'MarkerSize',10,...
                'MarkerEdgeColor','r');
            plot3(swarm.x(1),swarm.x(2),swarm.fval,...
                'LineStyle','none',...
                'Marker','x',...
                'MarkerSize',10,...
                'MarkerEdgeColor','g');
            plot3(sa.x(1),sa.x(2),sa.fval,...
                'LineStyle','none',...
                'Marker','o',...
                'MarkerSize',10,...
                'MarkerEdgeColor','b');
            hold off
            legend({sprintf('Sa�da da Rede Neural')
                sprintf('GA (IN-1: %0.2f; IN-2: %0.2f; OUT: %0.2f)',ga.x(1),ga.x(2),ga.fval)
                sprintf('PSO (IN-1: %0.2f; IN-2: %0.2f; OUT: %0.2f)',swarm.x(1),swarm.x(2),swarm.fval)
                sprintf('SA (IN-1: %0.2f; IN-2: %0.2f; OUT: %0.2f)',sa.x(1),sa.x(2),sa.fval)});
            title(sprintf('Saida da Rede Neural\n(N-%d; TRN-%d; TR-%s; FA-%s)',...
                rede.index,t,rede2.trainFcnName,rede2.transferFcn));
            xlabel(dado.inputVal{1,2});
            ylabel(dado.inputVal{2,2});
            zlabel(dado.targetVal{1,2});
            view(3);
        end
        
        if size(dado.inputVal,1) == 2 && size(dado.targetVal,1) == 2
            hold on
            mesh(resultado.plot.value3dX,...
                resultado.plot.value3dY,...
                rede.plot(t).value3dZ,...
                rede.plot(t).value3dC);
            plot3(ga.x(1),ga.x(2),ga.output(1),ga.output(2),...
                'LineStyle','none',...
                'Marker','+',...
                'MarkerSize',10,...
                'MarkerEdgeColor','r');
            plot3(swarm.x(1),swarm.x(2),swarm.output(1),swarm.output(2),...
                'LineStyle','none',...
                'Marker','x',...
                'MarkerSize',10,...
                'MarkerEdgeColor','g');
            plot3(sa.x(1),sa.x(2),sa.output(1),sa.output(2),...
                'LineStyle','none',...
                'Marker','o',...
                'MarkerSize',10,...
                'MarkerEdgeColor','b');
            hold off
            legend({sprintf('Sa�da da Rede Neural')
                sprintf('GA (IN-1: %0.2f; IN-2: %0.2f; OUT-1: %0.2f; OUT-2: %0.2f)',ga.x(1),ga.x(2),ga.output(1),ga.output(2))
                sprintf('PSO (IN-1: %0.2f; IN-2: %0.2f; OUT-1: %0.2f; OUT-2: %0.2f)',swarm.x(1),swarm.x(2),swarm.output(1),ga.output(2))
                sprintf('SA (IN-1: %0.2f; IN-2: %0.2f; OUT-1: %0.2f; OUT-2: %0.2f)',sa.x(1),sa.x(2),sa.output(1),ga.output(2))});
            title(sprintf('Saida da Rede Neural\n(N-%d; TRN-%d; TR-%s; FA-%s)',...
                rede.index,t,rede2.trainFcnName,rede2.transferFcn));
            xlabel(dado.inputVal{1,2});
            ylabel(dado.inputVal{2,2});
            zlabel(dado.targetVal{1,2});
            clabel(dado.targetVal{2,2});
            view(3);
        end
        
        if size(dado.inputVal,1) == 3 && size(dado.targetVal,1) == 1
            hold on
            mesh(resultado.plot.value3dX,...
                resultado.plot.value3dY,...
                rede.plot(t).value3dZ,...
                rede.plot(t).value3dC);
            plot3(ga.x(1),ga.x(2),ga.x(3),ga.output(1),...
                'LineStyle','none',...
                'Marker','+',...
                'MarkerSize',10,...
                'MarkerEdgeColor','r');
            plot3(swarm.x(1),swarm.x(2),swarm.x(3),swarm.output(1),...
                'LineStyle','none',...
                'Marker','x',...
                'MarkerSize',10,...
                'MarkerEdgeColor','g');
            plot3(sa.x(1),sa.x(2),sa.x(3),sa.output(1),...
                'LineStyle','none',...
                'Marker','o',...
                'MarkerSize',10,...
                'MarkerEdgeColor','b');
            hold off
            legend({sprintf('Sa�da da Rede Neural')
                sprintf('GA (IN-1: %0.2f; IN-2: %0.2f; IN-3: %0.2f; OUT: %0.2f)',ga.x(1),ga.x(2),ga.x(3),ga.output(1))
                sprintf('PSO (IN-1: %0.2f; IN-2: %0.2f; IN-3: %0.2f; OUT: %0.2f)',swarm.x(1),swarm.x(2),swarm.x(3),ga.output(1))
                sprintf('SA (IN-1: %0.2f; IN-2: %0.2f; IN-3: %0.2f; OUT: %0.2f)',sa.x(1),sa.x(2),sa.x(3),ga.output(1))});
            title(sprintf('Saida da Rede Neural\n(N-%d; TRN-%d; TR-%s; FA-%s)',...
                rede.index,t,rede2.trainFcnName,rede2.transferFcn));
            xlabel(dado.inputVal{1,2});
            ylabel(dado.inputVal{2,2});
            zlabel(dado.inputVal{3,2});
            clabel(dado.targetVal{1,2});
            view(3);
        end
        
        h{end}.Name = sprintf('N-%d; TRN-%d; TR-%s; FA-%s; Plot OTM',...
            rede.index,t,rede2.trainFcn,rede2.transferFcn);
        h{end}.NumberTitle = 'off';
    end
end

end
