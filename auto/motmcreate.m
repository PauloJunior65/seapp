function otimizacao = motmcreate(dado)
clc;

%%Par�metros
otimizacao.variavel = 1;%N�mero de vari�veis
otimizacao.A = [];%Coeficientes de Desigualda
otimizacao.b = [];%Termo Independente
otimizacao.Aeq = [];%Coeficientes de Igualdade
otimizacao.beq = [];%Termo Independente
otimizacao.ConstFunction = [];%Fun��o de Restri��o
otimizacao.parallel = false;
otimizacao.x0 = dado.inputVal{2,3};%Startingpoint
otimizacao.lb = dado.inputVal{2,3};%Limite Inferior
otimizacao.ub = dado.inputVal{2,4};%Limite Superior


end