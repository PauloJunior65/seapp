clc;
clear;
files = dir(fullfile('arquivo\*.fig'));
mkdir('fig');
mkdir('png');
for i = 1:length(files)
    fig = openfig(['arquivo\',files(i).name]);
    grid on;
    name = strcat('png\',fig.Name,'.png');
    saveas(fig,name);
    name = strcat('fig\',fig.Name,'.fig');
    savefig(fig,name)
    fprintf('Save %d: %s\n',i,fig.Name);
    close all;
end