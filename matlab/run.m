function [ m1s, r1s, p4s, p3s, p2s, p1s, typy, nachylenia, epizody ] = run( ecgData, Rpeaks, Tpeaks )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    y = ecgData;
    l_r = length(Rpeaks);
	x = 1:length(ecgData);
    
	j = 0;
	ton = 0;
	Tpeak_y = 0;
	Tpeak_yi = 0;
	S = 0;
	S_i = 0;

	nachylenie = 0.0;
	wartosc_n = 0.0;
	dlugosc_n = 0.0;
    
    %%%%%debug%%%%%%
    m1s = [];
    r1s = [];
    p4s = [];
    p3s = [];
    p2s = [];
    p1s = [];
    typy = [];
    nachylenia = [];
    epizody = [];
    %%%%%%%%%%%%%%%%
    
    for k = 1:500%l_r-2
			RR = Rpeaks(k + 1) - Rpeaks(k);
            
			%analiza pojedynczego przebiegu EKG

			x_1 = x(Rpeaks(k):Rpeaks(k+1));
			y_1 = y(Rpeaks(k):Rpeaks(k+1));
            Tpeak_yi = Tpeaks (k) - Rpeaks(k) +1;
            Tpeak_y = y_1(Tpeak_yi);

			[S, S_i] = findS( y_1)
            
			L_sit=Tpeak_yi-S_i;
		
			x_2=x_1(S_i:S_i+L_sit-2);
			y_2=y_1(S_i:S_i+L_sit-2);

			[j, ton, coeffs] = solver( x_2, y_2);

			%%%%%%%%%%%%%%%%%%%%
			if j<1
				j=1;
            end
            if ton<10
                typy = [typy 0];
                continue
            end
            [ delta_4_i, delta_4 ] = p4( RR, y_2, ton);
            p4s = [p4s x(Rpeaks(k)+delta_4_i+S_i-1)];
 			[ delta_3_i, delta_3 ] = p3(y_2, delta_4_i, j, coeffs);
            p3s = [p3s x(Rpeaks(k)+delta_3_i+S_i-1)];
            
            [delta_2_i, delta_2] = p2( y_2, delta_3_i, j);
            p2s = [p2s x(Rpeaks(k)+delta_2_i+S_i-1)];
 			[delta_1_i, delta_1] = p1(y_2, j, 1);
            p1s = [p1s x(Rpeaks(k)+delta_1_i+S_i-1)];
 			typ=class_it(delta_1, delta_2, delta_3, delta_4);
            typy = [typy typ];
            m1s = [m1s x(Rpeaks(k)+j+S_i-1)];
            r1s = [r1s x(Rpeaks(k)+ton+S_i-1)];
            nachylenie = 0.0;
			 wartosc_n = y_2(ton) - y_2(j);
			 dlugosc_n = ton - j;

			 nachylenie = wartosc_n / dlugosc_n;
            nachylenia = [nachylenia nachylenie];
            if (((y_2(ton) > 1) && (y_2(j) > 1) && (wartosc_n > 0)) || ((y_2(ton) > 2) && (y_2(j) > 2)))
			 epizody = [epizody 1];
			
            else
                epizody = [epizody 0];
            end

    end
         
end

