function plot_save( path, h )
parfor i = 1:length(h)
    %name = strcat(path,sprintf('%d- ',i),h{i}.Name,'.png');
    name = strcat(path,'png\',h{i}.Name,'.png');
    saveas(h{i},name);
    name = strcat(path,'fig\',h{i}.Name,'.fig');
    savefig(h{i},name);
    fprintf('Save: %s\n',h{i}.Name);
    close(h{i});
end
end

