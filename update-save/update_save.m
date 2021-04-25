function [ configuracao,dado,network,otimizacao,resultado ] = update_save(nome,configuracao2,dado2,network2,otimizacao2,resultado2 )

configuracao.data = datetime;
configuracao.save = nome;
mkdir(configuracao.save);
configuracao.file = ['dado/',configuracao2.file];

dado.raw = {'Nautical Mile','Quilometro','KM/H','Hora','Consumo em litro'};
for i = 1:size(dado2.raw,1)
    dado.raw(i+1,:) = num2cell(dado2.raw(i,:));
end
dado.inputVal = {1,'Nautical Mile',dado2.inputLimit(1,1),dado2.inputLimit(1,2);3,'KM/H',dado2.inputLimit(2,1),dado2.inputLimit(2,2)};
dado.targetVal = {5,'Consumo em litro',dado2.targetLimit(1,1),dado2.targetLimit(1,2)};
dado.input = dado2.input;
dado.target = dado2.target;

network.net_camada = network2.net_camada;
network.net_neuronio = network2.net_neuronio;
network.trainFcn = network2.trainFcn;
network.trainSelect = 0;
network.transferFcn = network2.transferFcn;
network.transferSelect = 0;
network.redeTipo = network2.redetipo;
network.redeSelect = 0;
network.net_train = network2.net_train;
network.net_epochs = network2.net_epochs;
network.net_lr = network2.net_lr;
network.redes_aux = network2.redes_aux;
network.redes = network2.redes;
network.resource = 3;

otimizacao.A = otimizacao2.A;
otimizacao.b = otimizacao2.b;
otimizacao.Aeq = otimizacao2.Aeq;
otimizacao.beq = otimizacao2.beq;
otimizacao.ConstFunction = otimizacao2.ConstFunction;
otimizacao.variavel = otimizacao2.variavel;
otimizacao.x0 = otimizacao2.x0;
otimizacao.lb = otimizacao2.lb;
otimizacao.ub = otimizacao2.ub;
otimizacao.psize = otimizacao2.psize;
otimizacao.pgen = otimizacao2.pgen;
otimizacao.peli = otimizacao2.peli;
otimizacao.tipo = otimizacao2.tipo;
otimizacao.distacia = otimizacao2.distacia;

for i = 1:size(resultado2.redes,2)
    resultado.redes(i).index = resultado2.redes(i).index;
    resultado.redes(i).ga = resultado2.redes(i).ga;
    resultado.redes(i).plot = resultado2.redes(i).plot;
end
resultado.fun = resultado2.fun;
resultado.plot = resultado2.plot;


end

