function h =  plot_net_trainstate( index,tipo,network )

if isempty(index)
    index = 1:length(network.redes);
end
h = {};
count = 1;
for i = 1:length(index)
    for j = 1:length(tipo)
        h{count} = figure;
        plottrainstate(network.redes(index(i)).rede_treino{tipo(j)});
        h{count}.Name = sprintf('Nº%d - Treino %d; Train State',index(i),tipo(j));
        h{count}.NumberTitle = 'off';
        count = count+ 1;
    end
end

end