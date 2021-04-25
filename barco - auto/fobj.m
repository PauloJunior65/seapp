function [ consumo ] = fobj( velocidade,distacia )

barco = mbarco();
RPM = (velocidade * barco.GR * barco.C) / (barco.PP * (1 - (barco.PS/100)));
[ SFOC,PW ] = mbarco_rpm(RPM);
tempo = distacia/velocidade;%Hora
consumo_gr =  PW * SFOC * tempo;%gr
consumo = consumo_gr/860;%gr to Liters Diesel

end