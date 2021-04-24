function [ SFOC,PW ] = mbarco_rpm(RPM)
barco = mbarco();
motor = barco.motor;
SFOC = 0;
PW = 0;
for m = 2:size(motor,1)
    if RPM <= motor(m,1)
        if RPM == motor(m-1,1)
            SFOC = motor(m-1,2);
            PW = motor(m-1,3);
        else
            if RPM == motor(m,1)
                SFOC = motor(m,2);
                PW = motor(m,3);
            else
                m_SFOC = (motor(m,2)-motor(m-1,2))/(motor(m,1)-motor(m-1,1));
                SFOC = (m_SFOC * ( RPM - motor(m-1,1) ) ) + motor(m-1,2);
                m_PW = (motor(m,3)-motor(m-1,3))/(motor(m,1)-motor(m-1,1));
                PW = (m_PW * ( RPM - motor(m-1,1) ) ) + motor(m-1,3);
            end
        end
        break;
    end
end

end

