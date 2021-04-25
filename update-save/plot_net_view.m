function plot_net_view( index,network )

if isempty(index)
    index = 1:length(network.redes);
end
for i = 1:length(index)
    view(network.redes(index(i)).rede{end});
end

end