function [ dado ] = mgenerate (configuracao)

[num,txt,dado.raw] = xlsread(fullfile(strcat(configuracao.file,'.xlsx')));
dado.inputVal = {};
dado.targetVal = {};
for i = 1:length(txt)
    clc;
    fprintf('Selecionar os dados:\n');
    fprintf('\t\tColuna:%d\n',i);
    fprintf('\t\tNome:%s\n',txt{i});
    fprintf('\t1-Input\n');
    fprintf('\t2-Target\n');
    fprintf('\t3-Ignorar\n');
    switch input('(int) opçao:')
        case 1
            dado.inputVal(end+1,:) = {i,txt{i}};
        case 2
            dado.targetVal(end+1,:) = {i,txt{i}};
        otherwise
    end
end


fprintf('\n===================================');
fprintf('\nGerando os Dados de Entrada e Saida\n');

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

fprintf('\nTipo de Dados:\n');
fprintf('\t1-Barco\n');
fprintf('\t2-Dinâmico\n');
switch input('(int) opçao:')
    case 1
        dado.tipo = true;
    otherwise
        dado.tipo = false;
end

end