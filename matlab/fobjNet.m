function [ f ] = fobjNet( x,tipo,net )
    output = net(x);
    for i = 1:size(output,1)
        if tipo(i) == 1
            f(i) = -(output(i));
        else
            f(i) = output(i);
        end
    end
end
