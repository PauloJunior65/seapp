function net_print( tipo )
treino = tipo.treino{end};
validacao = tipo.validacao{end};
teste = tipo.teste{end};
all = tipo.all{end};
fprintf('\nRede Neural %d:\n',tipo.index);
fprintf('tipo: %s\n',tipo.tipo);
fprintf('trainFcn: %s : %s\n',tipo.trainFcn,tipo.trainFcnName);
fprintf('transferFcn: %s\n',tipo.transferFcn);
fprintf('-------------------------------------------------\n');
fprintf('mse treino: %f\n',treino.mse);
fprintf('mse validacao: %f\n',validacao.mse);
fprintf('mse teste: %f\n',teste.mse);
fprintf('mse all: %f\n',all.mse);
fprintf('-------------------------------------------------\n');
fprintf('rmse treino: %f\n',treino.rmse);
fprintf('rmse validacao: %f\n',validacao.rmse);
fprintf('rmse teste: %f\n',teste.rmse);
fprintf('rmse all: %f\n',all.rmse);
fprintf('-------------------------------------------------\n');
fprintf('nrmse treino: %f\n',treino.nrmse);
fprintf('nrmse validacao: %f\n',validacao.nrmse);
fprintf('nrmse teste: %f\n',teste.nrmse);
fprintf('nrmse all: %f\n',all.nrmse);
fprintf('-------------------------------------------------\n');
fprintf('mape treino: %f\n',treino.mape);
fprintf('mape validacao: %f\n',validacao.mape);
fprintf('mape teste: %f\n',teste.mape);
fprintf('mape all: %f\n',all.mape);
fprintf('-------------------------------------------------\n');
fprintf('regression treino: %f\n',treino.regression);
fprintf('regression validacao: %f\n',validacao.regression);
fprintf('regression teste: %f\n',teste.regression);
fprintf('regression all: %f\n',all.regression);

end

