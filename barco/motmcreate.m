function otimizacao = motmcreate(dado)
clc;

%%Parâmetros
otimizacao.A = [];%Coeficientes de Desigualda
otimizacao.b = [];%Termo Independente
otimizacao.Aeq = [];%Coeficientes de Igualdade
otimizacao.beq = [];%Termo Independente
otimizacao.ConstFunction = [];%@res;  %Função de Restrição
otimizacao.variavel = 1;
otimizacao.x0 = dado.inputVal{2,3};%Startingpoint
otimizacao.lb = dado.inputVal{2,3};%Limite Inferior
otimizacao.ub = dado.inputVal{2,4};%Limite Superior

fprintf('\nO resultado da função:\n');
fprintf('\t1 - Maximizar\n');
fprintf('\t2 - Minimizar\n');
if 1 == input('Opção:')
    otimizacao.tipo = 1;
else
    otimizacao.tipo = 2;
end

fprintf('\nDistacia:\n');
fprintf('\t1 - Nautical Mile\n');
fprintf('\t2 - Quilometro\n');
switch input('opcao:')
    case 1
        otimizacao.distacia = input('(int) Valor: ');
    otherwise
        otimizacao.distacia = input('(int) Valor: ')/ 1.852;
end

otimizacao.psize = input('\n(int) PopulationSize: ');
otimizacao.pgen = input('(int) MaxGenerations: ');
otimizacao.peli = input('(int) EliteCount: ');

end