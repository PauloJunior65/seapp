function otimizacao = motmcreate(dado)
clc;

%%Parâmetros
otimizacao.A = [];%Coeficientes de Desigualda
otimizacao.b = [];%Termo Independente
otimizacao.Aeq = [];%Coeficientes de Igualdade
otimizacao.beq = [];%Termo Independente
otimizacao.ConstFunction = [];%Função de Restrição

fprintf('Usar Parallel:\n');
fprintf('\t1- TRUE\n');
fprintf('\t2- FALSE\n');
if 1 == input('(int) opção:')
    otimizacao.parallel = true;
else
    otimizacao.parallel = false;
end

if dado.tipo
    otimizacao.variavel = 1;%Número de variáveis
    otimizacao.x0 = dado.inputVal{2,3};%Startingpoint
    otimizacao.lb = dado.inputVal{2,3};%Limite Inferior
    otimizacao.ub = dado.inputVal{2,4};%Limite Superior
    fprintf('\nDistacia:\n');
    fprintf('\t1 - Nautical Mile\n');
    fprintf('\t2 - Quilometro\n');
    switch input('(int) opcao:')
        case 1
            otimizacao.distacia = input('(int) Valor: ');
        otherwise
            otimizacao.distacia = input('(int) Valor: ')/ 1.852;
    end
else
    otimizacao.variavel = size(dado.inputVal,1);%Número de variáveis
    for i = 1:size(dado.inputVal,1)
        otimizacao.x0(i) = dado.inputVal{i,3};%Startingpoint
        otimizacao.lb(i) = dado.inputVal{i,3};%Limite Inferior
        otimizacao.ub(i) = dado.inputVal{i,4};%Limite Superior
    end
end

for i = 1:size(dado.targetVal,1)
    fprintf('\nO resultado da função ( %s ):\n',dado.targetVal{i,2});
    fprintf('\t1 - Maximizar\n');
    fprintf('\t2 - Minimizar\n');
    if 1 == input('(int) opcao:')
        otimizacao.tipo(i) = 1;
    else
        otimizacao.tipo(i) = 2;
    end
end

otimizacao.psize = input('(int) PopulationSize: ');
otimizacao.pgen = input('(int) MaxGenerations: ');
otimizacao.peli = input('(int) EliteCount: ');


end