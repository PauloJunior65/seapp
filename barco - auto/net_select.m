function [index,list,tipo] = net_select(network,tipo)
[list2,tipo] = net_list(network,tipo);
fprintf('\nRedes Neurais que vai utiliza nos Metodos:\n');
for i = 1:size(list2,1)
    switch tipo
        case 1
            fprintf('\t%d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                i,list2{i,4},list2{i,5},list2{i,6},list2{i,10},list2{i,14},list2{i,18},list2{i,22});
        case 2
            fprintf('\t%d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                i,list2{i,4},list2{i,5},list2{i,7},list2{i,11},list2{i,15},list2{i,19},list2{i,23});
        case 3
            fprintf('\t%d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                i,list2{i,4},list2{i,5},list2{i,8},list2{i,12},list2{i,16},list2{i,20},list2{i,24});
        otherwise
            fprintf('\t%d - T:%s |FT:%s |MSE:%f |RMSE:%f |NRMSE:%f |MAPE:%f |REGRESSION:%f\n',...
                i,list2{i,4},list2{i,5},list2{i,9},list2{i,13},list2{i,17},list2{i,21},list2{i,25});
    end
end
index = [];
list = {};
for i = 1:size(list2,1)
    index(end+1) = list2{i,1};
    list(end+1,:) = list2(i,:);
end

end