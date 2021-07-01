function [ consumo ] = fobj( vel,dis )
b = mbarco();
RPM = (vel * b.GR * b.C) / (b.PP * (1 - (b.PS)));
[ SFOC,PW ] = mbarco_rpm(RPM);
tempo = dis/vel;
consumo_gr =  PW * SFOC * tempo;
consumo = consumo_gr/860;
end

