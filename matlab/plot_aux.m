function tipo = plot_aux(network)
clc;
fprintf('\nPlotar quais Treinos:\n');
treino = 1:length(network.redes(1).rede);
fprintf('\t[] - Treino [');
fprintf('%d ',treino);
fprintf(']\n');
fprintf('\t0 - Todos\n');
tipo = input('(int ou [])opcao:');
if tipo == 0
    tipo = treino;
end
end

