function mrandom(nome,qdt)
file = fullfile(strcat(nome,'.xlsx'));
delete(file);
dado = {'Distancia (NM)','Distancia (KM)','Velocidade (KM/H)','Tempo (H)','Consumo (L)'};
barco = mbarco();

data = {800,800,2100,2100;...
    1,600,1,600}
for i = 1:4
    RPM = data{1,i};
    [ SFOC,PW ] = mbarco_rpm(RPM);
    kmh =  (RPM * barco.PP * (1 - (barco.PS/100))) / (barco.GR * barco.C);%km/h
    dis_km = data{2,i};%KM
    dis_nm = dis_km/ 1.852;%Nautical Mile
    tempo = dis_nm/kmh;%Hora
    consumo =  PW * SFOC * tempo;%gr
    consumo_litro = consumo/860;%gr to Liters Diesel
    dado(end+1,:) = {dis_nm,dis_km,kmh,tempo,consumo_litro};
end
for i = 5:qdt
    clc;
    fprintf('!!!Gerando um Arquivo!!!\n');
    fprintf('Parte %d de %d\n',i,qdt);
    RPM = randi([800 2100]);
    [ SFOC,PW ] = mbarco_rpm(RPM);
    kmh =  (RPM * barco.PP * (1 - (barco.PS/100))) / (barco.GR * barco.C);%km/h
    dis_km = randi([1 600]);%KM
    dis_nm = dis_km/ 1.852;%Nautical Mile
    tempo = dis_nm/kmh;%Hora
    consumo =  PW * SFOC * tempo;%gr
    consumo_litro = consumo/860;%gr to Liters Diesel
    dado(end+1,:) = {dis_nm,dis_km,kmh,tempo,consumo_litro};
end
xlswrite(file,dado);

end

