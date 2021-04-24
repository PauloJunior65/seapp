function [ dado ] = mgenerate (configuracao)
clc;
dado.raw = xlsread(fullfile(strcat(configuracao.file,'.xlsx')));
if configuracao.tipo == 1
    dado.inputCol = {1,3;'distacia','velocidade'};
    dado.targetCol = {5;'consumo'};
else
    
    for i = 1:size(dado.raw,2)
        fprintf('!!!Configuração da Base de Dados!!!');
        fprintf('\nQuantidade de variavel encontrado no Arquivo %s: %d\n',configuracao.file,size(dado.raw,2));
        fprintf('\nVariavel %d o Tipo:\n',i);
        fprintf('\t 1- Entrada\n');
        fprintf('\t 2- Saida\n');
        cols{1,i} = input('Opção:');
        cols{2,i} = input('Nome da Variavel:','s');
    end
    count1 = 1;
    count2 = 1;
    for i = 1:size(cols,2)
        if cols{1,i} == 1
            dado.inputCol{1,count1} = i;
            dado.inputCol{2,count1} = cols{2,i};
            count1 =count1+ 1;
        else
            dado.targetCol{1,count2} = i;
            dado.targetCol{2,count2} = cols{2,i};
            count2 =count2+ 1;
        end
    end
end
fprintf('\n===================================');
fprintf('\nGerando os Dados de Entrada e Saida\n');
qdt = length(dado.raw);
qdt_input = size(dado.inputCol,2);
qdt_target = size(dado.targetCol,2);
dado.input = zeros(qdt_input,qdt);
dado.inputLimit = zeros(qdt_input,2);
dado.target = zeros(qdt_target,qdt);
dado.targetLimit = zeros(qdt_target,2);
for j = 1:qdt_input
    value = dado.raw(:,dado.inputCol{1,j})';
    dado.inputLimit(j,1) = min(value);
    dado.inputLimit(j,2) = max(value);
    dado.input(j,:) = value;
end
for j = 1:qdt_target
    value = dado.raw(:,dado.targetCol{1,j})';
    dado.targetLimit(j,1) = min(value);
    dado.targetLimit(j,2) = max(value);
    dado.target(j,:) = value;
end

end