function [ SFOC,PW ] = mbarco_rpm_old(RPM)
barco = mbarco();
motor = barco.motor;
motor = sortrows(motor,-1);
for m = 1:size(motor,1)
    SFOC = motor(m,2);
    PW = motor(m,3);
    if RPM >= motor(m,1)
        break;
    end
end

end

