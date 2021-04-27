function otimizacao = motmcreate(dado)
clc;

%%Parâmetros
otimizacao.variavel = 1;%Número de variáveis
otimizacao.A = [];%Coeficientes de Desigualda
otimizacao.b = [];%Termo Independente
otimizacao.Aeq = [];%Coeficientes de Igualdade
otimizacao.beq = [];%Termo Independente
otimizacao.ConstFunction = [];%Função de Restrição
otimizacao.x0 = dado.inputVal{2,3};%Startingpoint
otimizacao.lb = dado.inputVal{2,3};%Limite Inferior
otimizacao.ub = dado.inputVal{2,4};%Limite Superior


end