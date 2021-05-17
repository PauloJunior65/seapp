function h = plot_net_perform( index,tipo,network )

if isempty(index)
    index = 1:length(network.redes);
end
h = {};
for i = 1:length(index)
    for j = 1:length(tipo)
        h{end+1} = figure;
        plotperform(network.redes(index(i)).rede_treino{tipo(j)});
        h{end}.Name = sprintf('Nº%d - Treino %d; Performance',index(i),tipo(j));
        h{end}.NumberTitle = 'off';
    end
end

end