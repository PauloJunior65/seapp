function [ error ] = get_error( target,output )

error.mse = [];
error.rmse = [];
error.nrmse = [];
error.mape = [];
error.regression = [];
error.x = [];
error.output(1).mse = [];
error.output(1).rmse = [];
error.output(1).nrmse = [];
error.output(1).mape = [];
error.output(1).regression = [];
error.output(1).x = [];

if ~isempty(output) && ~isempty(target)
    error.mse = mse(target,output);
    error.rmse=sqrt(error.mse);
    error.x = sum(target(:)/(size(target,1)*size(target,2)));
    error.nrmse=error.rmse/error.x;
    error.mape=mean(abs(target-output)./target,2);
    error.regression=regression(target,output);
    for i = 1:size(target,1)
        dado.mse = mse(target(i,:),output(i,:));
        dado.rmse = sqrt(dado.mse);
        dado.x = sum(target(i,:)/size(target,1));
        dado.nrmse = dado.rmse/dado.x;
        dado.mape = mean(abs(target(i,:)-output(i,:))./target(i,:));
        dado.regression = regression(target(i,:),output(i,:));
        error.output(i) = dado;
    end
end
end