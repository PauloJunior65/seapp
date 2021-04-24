function [ net ] = net_feedforwardnet(network,dado,trainFcn,transferFcn)

net = feedforwardnet(network.net_neuronio);
net.trainFcn = trainFcn;
net.trainParam.time = inf;
for c = 1:length(network.net_camada)
    net.layers{c}.transferFcn = transferFcn;
end
net = configure(net,dado.input,dado.target);

end

