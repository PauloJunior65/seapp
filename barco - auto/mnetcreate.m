function [ network ] = mnetcreate (network,dado)
%Create
count = 1;
clc;
fprintf('\n!!!Creando as Redes Neurais!!!\n');
for i = 1:length(network.trainFcn)
    if any(network.trainSelect(:) == i) || any(network.trainSelect(:) == 0)
        for j = 1:length(network.transferFcn)
            if any(network.transferSelect(:) == j) || any(network.transferSelect(:) == 0)
                if any(network.redeSelect(:) == 1) || any(network.redeSelect(:) == 0)
                    net = net_feedforwardnet(network,dado,network.trainFcn{i,1},network.transferFcn{j});
                    net.name = sprintf('N%d - %s',count,net.name);
                    network = mnetcreate_add (network,count,i,j,net,network.redeTipo{1});
                    count = count +1;
                end
            end
        end
    end
end
end