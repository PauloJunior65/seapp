function  pausa()
f = figure;
h = uicontrol('Position',[20 20 200 40],'String','Continue',...
    'Callback','uiresume(gcbf)');
disp('Click Continue');
screensize = get( groot, 'Screensize' );
set(f,'Resize','off','Position',[(screensize(3)/2) (screensize(4)/2) 250 80]);
uiwait(gcf);
%close(f);
close all;
end

