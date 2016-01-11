function [ ct ] = class_it( delta_1, delta_2, delta_3, delta_4 )
    ct = 0;

	if ((delta_1 == 1) && (delta_2 == 1) && (delta_3 == 1) && (delta_4 == 1))
		ct = 2;
    elseif ((delta_1 == 1) && (delta_2 == 0) && (delta_3 == 1) && (delta_4 == 1))
		ct = 3;
    elseif ((delta_1 == 1) && (delta_2 == -1) && (delta_3 == 0) && (delta_4 == 1))
		ct = 4;
    elseif ((delta_1 == -1) && (delta_2 == 0) && (delta_3 == 1) && (delta_4 == 1))
		ct = 1;
    elseif ((delta_1 == -1) && (delta_2 == -1) && (delta_3 == 0) && (delta_4 == 1))
		ct = 5;
    elseif ((delta_1 == -1) && (delta_2 == -1) && (delta_3 == -1) && (delta_4 == -1))
		ct = 6;
    elseif ((delta_1 == -1) && (delta_2 == -1) && (delta_3 == -1) && (delta_4 == 0))
		ct = 6;
    end
end

