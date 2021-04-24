function [ otimizacao ] = motmcreate (configuracao,dado)
clc;

%%Parâmetros
otimizacao.A = [];%Coeficientes de Desigualda
otimizacao.b = [];%Termo Independente
otimizacao.Aeq = [];%Coeficientes de Igualdade
otimizacao.beq = [];%Termo Independente
otimizacao.ConstFunction = [];%@res;  %Função de Restrição
if configuracao.tipo == 1
    %%Personalizado
    otimizacao.variavel = 1;
    otimizacao.x0 = dado.inputLimit(2,1);%Startingpoint
    otimizacao.lb = dado.inputLimit(2,1);%Limite Inferior
    otimizacao.ub = dado.inputLimit(2,2);%Limite Superior
    fprintf('\nO resultado da função:\n');
    fprintf('\t1 - Maximizar\n');
    fprintf('\t2 - Minimizar\n');
    if 1 == 2%input('Opção:')
        otimizacao.tipo = 1;
    else
        otimizacao.tipo = 2;
    end
    fprintf('\nDistacia:\n');
    fprintf('\t1 - Nautical Mile\n');
    fprintf('\t2 - Quilometro\n');
    %     switch input('opcao:')
    %         case 1
    %             otimizacao.distacia = input('\n(int) Valor: ');
    %         otherwise
    %             otimizacao.distacia = input('\n(int) Valor: ')/ 1.852;
    %     end
    otimizacao.distacia = 195.3/1.852;
else
    %%Dinâmico
    otimizacao.variavel = length(dado.inputCol);
    fprintf('\nDefinir o ponto de inicio:\n');
    fprintf('\t1-Inicializar todas as variavel com um derteminado valor\n');
    fprintf('\t2-ou definir cada uma\n');
    if 1 == input('Opção:')%Startingpoint
        otimizacao.x0 = zeros(1,otimizacao.variavel) + 1;
    else
        for j = 1:variavel
            otimizacao.x0(j) = input(sprintf('\nVariavel %d:',j));
        end
    end
    tx1 = 'Limite Inferior: ';
    tx2 = 'Limite Superior: ';
    for j = 1:length(dado.inputCol)
        tx1 = sprintf('%s V%d : %f | ',tx1,j,dado.inputLimit(j,1));
        tx2 = sprintf('%s V%d : %f | ',tx2,j,dado.inputLimit(j,2));
        otimizacao.lb(j) = dado.inputLimit(1,1);%Limite Inferior
        otimizacao.ub(j) = dado.inputLimit(1,2);%Limite Superior
    end
    fprintf('\nContinuar com os Limite Inferior e Superior:\n');
    fprintf('\t%s\n\t%s\n',tx1,tx2);
    fprintf('1 - Continuar\n');
    fprintf('2 - Editar\n');
    if 2 == input('Opção:')
        for j = 1:size(dado.inputLimit,1)
            otimizacao.lb(1,j) = input(sprintf('\nInput %d Limite Inferior:',j));%Limite Inferior
            otimizacao.ub(1,j) = input(sprintf('\nInput %d Limite Superior:',j));%Limite Superior
        end
    end
    for j = 1:length(dado.targetCol)
        fprintf('\nO resultado da função %d:\n',j);
        fprintf('1 - Maximizar\n');
        fprintf('2 - Minimizar\n');
        if 1 == input('Opção:')
            otimizacao.tipo{j} = 1;
        else
            otimizacao.tipo{j} = 2;
        end
    end
end

otimizacao.psize = 50;%input('\n(int) PopulationSize: ');
otimizacao.pgen = 100;%input('(int) MaxGenerations: ');
otimizacao.peli = 20;%input('(int) EliteCount: ');

end