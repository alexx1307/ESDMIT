function [ delta_4_i, delta_4 ] = p4( RR, y, ton )    
    [maxt, maxt_i] = max(y(ton: length(y)-2));
    [mint, mint_i] = min(y(ton: length(y)-2));
    maxt_i = maxt_i+ton;
    mint_i = mint_i+ton;
    delta_4_i = 0;
    delta_4 = 0;
	if ((maxt - y(ton)) >= (y(ton) - mint))
		if (mint == y(ton))
			if (maxt == y(ton))
				delta_4 = 0;
				delta_4_i = floor(RR / 2);
            else
				delta_4 = 1;
				delta_4_i = maxt_i;
            end
        else
			delta_4 = 1;
			delta_4_i = maxt_i;
        end
    else
		delta_4 = -1;
		delta_4_i = mint_i;
    end
end

