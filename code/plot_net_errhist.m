function h = plot_net_errhist( index,tipo,network,dado )

if isempty(index)
    index = 1:length(network.redes);
end
h = {};
for i = 1:length(index)
    for j = 1:length(tipo)
        net = network.redes(index(i)).rede{tipo(j)};
        output = net(dado.input);
        errors = gsubtract(output,dado.target);
        h{end+1} = figure;
        ploterrhist(errors);
        h{end}.Name = sprintf('Nº%d - Treino %d; Error Histogram',index(i),tipo(j));
        h{end}.NumberTitle = 'off';
    end
end

end