function h = plot_net_regression( index,tipo,network,dado )

if isempty(index)
    index = 1:length(network.redes);
end
h = {};
for i = 1:length(index)
    for j = 1:length(tipo)
        net = network.redes(index(i)).rede{tipo(j)};
        tr = network.redes(index(i)).rede_treino{tipo(j)};
        output = net(dado.input);
        [ trOut,trTarg,vOut,vTarg,tsOut,tsTarg ] = net_regression_array( tr,dado,output );
        h{end+1} = figure;
        plotregression(...
            trTarg, trOut, 'Treino',...
            vTarg, vOut, 'Valida��o',...
            tsTarg, tsOut,'Teste',...
            dado.target,output,'ALL');
        h{end}.Name = sprintf('N�%d - Treino %d; Regression',index(i),tipo(j));
        h{end}.NumberTitle = 'off';
    end
end

end