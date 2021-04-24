clc;
fprintf('Salvando...\n');
save(['save\' nome_save '-configuracao'],'configuracao');
fprintf('Salvo => configuracao\n');
save(['save\' nome_save '-dado'],'dado');
fprintf('Salvo => dado\n');
save(['save\' nome_save '-network'],'network');
fprintf('Salvo => network\n');
save(['save\' nome_save '-otimizacao'],'otimizacao');
fprintf('Salvo => otimizacao\n');
save(['save\' nome_save '-resultado'],'resultado');
fprintf('Salvo => resultado\n');

