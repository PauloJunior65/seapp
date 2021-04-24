function op_exportar_net(index,index2,network,dado,path)
clc;
mkdir(path);

if isempty(index)
    index = 1:length(network.redes);
end
if isempty(index2)
    index2 = 1:length(network.redes(1).rede);
end

% fprintf('!!!plot perform!!!!\n');
% path_plus = [path,'perform\'];
% mkdir(path_plus);
% parfor i = 1:length(index)
%     plot_save(path_plus,plot_net_perform(index(i),index2,network));
% end
% clc;
% fprintf('!!!plot errhist!!!!\n');
% path_plus = [path,'errhist\'];
% mkdir(path_plus);
% parfor i = 1:length(index)
%     plot_save(path_plus,plot_net_errhist(index(i),index2,network,dado));
% end
clc;
fprintf('!!!plot regression!!!!\n');
path_plus = [path,'regression\'];
mkdir(path_plus);
parfor i = 1:length(index)
    plot_save(path_plus,plot_net_regression(index(i),index2,network,dado));
end
clc;
fprintf('!!!plot trainstate!!!!\n');
path_plus = [path,'trainstate\'];
mkdir(path_plus);
parfor i = 1:length(index)
    plot_save(path_plus,plot_net_trainstate(index(i),index2,network));
end

end

