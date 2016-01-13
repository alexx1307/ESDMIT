function [delta_1_i, delta_1 ] = p1( y, j, S_i )
	delta_1_i = 0;
    delta_1 = 0;

    delta_1_i = j;

	if ((y(delta_1_i) - y(S_i)) < -0.02)
		delta_1 = -1;
    else
		if (abs(y(delta_1_i) - y(S_i)) < 0.02)
			delta_1 = 0;
        else
            delta_1 = 1;
        end
    end

end

