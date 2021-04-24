function [ error ] = get_error( target,output )

error.mse = [];
error.rmse = [];
error.nrmse = [];
error.mape = [];
error.regression = [];
error.output(1).mse = [];
error.output(1).rmse = [];
error.output(1).nrmse = [];
error.output(1).mape = [];
error.output(1).regression = [];

if ~isempty(output) && ~isempty(target)
    error.mse = mse(target,output);
    error.rmse=sqrt(error.mse);
    error.nrmse=error.rmse./(max(target)-min(target));
    error.mape=mean(abs(output-target)./target,2)*100;
    error.regression=regression(target,output);
    for i = 1:size(target,1)
        dado.mse = mse(target(i,:),output(i,:));
        dado.rmse = sqrt(dado.mse);
        dado.nrmse = dado.rmse/(max(target(i,:))-min(target(i,:)));
        dado.mape = mean(abs(output(i,:)-target(i,:))./target(i,:))*100;
        dado.regression = regression(target(i,:),output(i,:));
        error.output(i) = dado;
    end
end

end