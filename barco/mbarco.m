function [ barco ] = mbarco()
%RPM SFOC PW
barco.motor = [
    800,209,100;
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
barco.GR = 0.8;%Gear Ratio
barco.PP = 22.5;%Propeller Pitch
barco.PS = 10;%Propeller Slip
barco.C = 656;%V (in kph), C = 656.
end

