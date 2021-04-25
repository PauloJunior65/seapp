clc;
mkdir([configuracao.save '\save']);
fprintf('Salvando...\n');
save([configuracao.save '\save\configuracao'],'configuracao');
fprintf('Salvo => configuracao\n');
save([configuracao.save '\save\dado'],'dado');
fprintf('Salvo => dado\n');
save([configuracao.save '\save\network'],'network');
fprintf('Salvo => network\n');
save([configuracao.save '\save\otimizacao'],'otimizacao');
fprintf('Salvo => otimizacao\n');
save([configuracao.save '\save\resultado'],'resultado');
fprintf('Salvo => resultado\n');

