function [  S,  S_i ] = findS( y_1 )
    srednia =0;
    y_1Len = length(y_1);
	zakres = floor(y_1Len/10):floor(y_1Len - y_1Len/10);
    suma = sum(y_1(zakres));

	srednia = suma / length(zakres) ;

	am = 0.0;
	ap = 0.0;
	[Smin_y, Smin_yi] = min(y_1:2:floor(length(y_1) / 2));
    
  
	Se_flag = 0;
	Sa_flag = 0;
	Se = 0.0;
	Se_i = 0.0;
	
	Sa = 0.0;
	Sa_i = 0.0;

	for i = 2:floor(length(y_1) / 8)+1
		ap = y_1(i) - y_1(i + 1);
		am = (y_1(i + 1) - y_1(i + 2));
		if (ap > 0 && am<0 && Se_flag == 0) % minimum lokalne
			Se = y_1(i + 1);
			Se_i = i + 1;
			Se_flag = 1;
        else
			if ((ap)>2 * (am))
				Sa = y_1(i + 1);
				Sa_i = i + 1;
				Sa_flag = 1;
            end
        end
        
    end
	if (Se_flag)
		S_i = Se_i;
		S = Se;
    else
		if (Sa_flag)
			S_i = Sa_i;
			S = Sa;
        else
			S_i = 1;          %gdy nie ma Swave, dalej zostaje podany punkt R!
			S = y_1(1);
        end
    end
end

