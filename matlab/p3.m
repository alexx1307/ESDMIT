function [ delta_3_i, delta_3 ] = p3( y, delta_4_i, j, coeffs )
	base_min_3_i = floor((delta_4_i + j) / 2);
	base_min_3 = y(base_min_3_i);
    min_3_i = base_min_3_i;
    min_3 = base_min_3;
    delta_3 = 0;
    delta_3_i = 0;
%     for i = -floor((delta_4_i + j) / 8):floor((delta_4_i + j) / 8)
% 		if (y(base_min_3_i + i) < min_3)
% 	
% 			if (y(base_min_3_i + i + 1) > y(base_min_3_i + i))
% 		
% 				if (y(base_min_3_i + i - 1) > y(base_min_3_i + i))
% 		
% 					min_3_i = base_min_3_i + i;
% 					min_3 = y(min_3_i);
% 					delta_3 = 0;
% 
%                 end
%             end
%         end
%     end
% 	if (delta_3~=999 && delta_3 == 0)
% 		delta_3_i = min_3_i;
%     else
    if ((y(min_3_i) - y(delta_4_i - 1)) < -0.01)
        if (y(min_3_i) - y(j) < 0.01)
            delta_3 = 0;
            delta_3_i = min_3_i;
        else
            delta_3 = 1;
            delta_3_i = min_3_i;
        end
    else
        if (abs(y(min_3_i) - y(delta_4_i)) < 0.01)
            delta_3 = 0;
            delta_3_i = min_3_i;
        else
            if ((y(min_3_i) - y(delta_4_i)) > 0.01)
                if (y(min_3_i) - y(j)<0.01)
                    delta_3 = 0;
                    delta_3_i = min_3_i;
                else
                    delta_3 = 1;
                    delta_3_i = min_3_i;
                end
            end
        end
    end
end

