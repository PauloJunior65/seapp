function mrandom(nome,qdt)
file = fullfile(strcat(nome,'.xlsx'));
delete(file);

%        RPM SFOC PW
motor = [800,209,100;
    850,205,114;
    900,202.5,125;
    950,199,140;
    1000,197.5,155;
    1050,195,175;
    1100,193,190;
    1150,196,208;
    1200,198.2,217;
    1250,198,225;
    1300,197.5,228;
    1350,195,232;
    1400,194.5,234;
    1450,196,235;
    1500,197.5,235;
    1550,198,235;
    1600,199.5,235;
    1650,201,235;
    1700,202.5,235;
    1750,203,235;
    1800,204,235;
    1850,205,235;
    1900,207,235;
    1950,209,235;
    2000,212.5,235;
    2050,217.5,235;
    2100,222,235];
motor = sortrows(motor,-1);
GR = 0.8;%Gear Ratio
PP = 22.5;%Propeller Pitch
PS = 10;%Propeller Slip
C = 656;%V (in kph), C = 656.

dado = {'Nautical Mile','Quilometro','KM/H','Hora','Consumo em litro'};
for i = 1:qdt
    clc;
    fprintf('!!!Gerando um Arquivo!!!\n');
    fprintf('Parte %d de %d\n',i,qdt);
    RPM = randi([800 2100]);
    for m = 1:size(motor,1)
        sfoc = motor(m,2);
        pw = motor(m,3);
        if RPM >= motor(m,1)
            break;
        end
    end
    kmh =  (RPM * PP * (1 - (PS/100))) / (GR * C);%km/h
    dis_km = randi([1 600]);%KM
    dis_nm = dis_km/ 1.852;%Nautical Mile
    tempo = dis_nm/kmh;%Hora
    consumo =  pw * sfoc * tempo;%gr
    consumo_litro = consumo/860;%gr to Liters Diesel
    dado(i+1,:) = {dis_nm,dis_km,kmh,tempo,consumo_litro};
end
xlswrite(file,dado);

end

