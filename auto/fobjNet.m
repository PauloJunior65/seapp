function [ f ] = fobjNet( x,tipo,net )
    output = net(x);
    if tipo == 1
        f = -(output(1));
    else
        f = output(1);
    end
end
