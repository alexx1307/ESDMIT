function [delta_2_i, delta_2] = p2( y, delta_3_i, j )
    delta_2_i = 0;
    delta_2 = 0;
    delta_2_i = floor((delta_3_i + j) / 2);

	if ((y(delta_2_i) - y(j)) < -0.01)
		delta_2 = -1;
    else
		if (abs(y(delta_2_i) - y(j)) < 0.01)
			delta_2 = 0;
        else
			if ((y(delta_2_i) - y(j)) > 0.01)
				delta_2 = 1;
            end
        end
    end
end

