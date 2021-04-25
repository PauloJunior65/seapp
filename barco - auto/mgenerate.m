function [ dado ] = mgenerate (configuracao)
clc;
fprintf('\n===================================');
fprintf('\nGerando os Dados de Entrada e Saida\n');
[num,txt,dado.raw] = xlsread(fullfile(strcat(configuracao.file,'.xlsx')));
dado.inputVal = {1,'Nautical Mile';3,'KM/H'};
dado.targetVal = {5,'Consumo em litro'};

for i = 1:size(dado.inputVal,1)
    value = num(:,dado.inputVal{i,1})';
    dado.inputVal{i,3} = min(value);
    dado.inputVal{i,4} = max(value);
    dado.input(i,:) = value;
end

for i = 1:size(dado.targetVal,1)
    value = num(:,dado.targetVal{i,1})';
    dado.targetVal{i,3} = min(value);
    dado.targetVal{i,4} = max(value);
    dado.target(i,:) = value;
end

end