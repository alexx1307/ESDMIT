function [ ret ] = checkDer( coeffs, point, treshold )
    val = polyval(polyder(coeffs),point);
    ret = 0;
    if val> treshold
        ret=1;
    elseif val<-treshold 
        ret =-1;
    end

end

