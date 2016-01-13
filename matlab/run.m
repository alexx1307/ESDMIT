function [ m1s, r1s, p4s, p3s, p2s, p1s, typy, nachylenia, epizody ] = run( ecgData, Rpeaks, Tpeaks, qrsEnd)
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
    
    for k = 50:l_r-50
			RR = Rpeaks(k + 1) - Rpeaks(k);
            
			%analiza pojedynczego przebiegu EKG

			x_1 = x(Rpeaks(k):Rpeaks(k+1));
			y_1 = y(Rpeaks(k):Rpeaks(k+1));
            Tpeak_yi = Tpeaks (k) - Rpeaks(k) +1;

			j = qrsEnd(k)-Rpeaks(k);
            x_2 = x_1(j:Tpeak_yi);
            y_2 = y_1(j:Tpeak_yi);
			[ton, coeffs] = solver(x_2,y_2);

			%%%%%%%%%%%%%%%%%%%%
			if j<1
				j=1;
            end
            if ton<10
                typy = [typy 0];
                continue
            end

            [ delta_4_i, delta_4 ] = p4( RR, y_2, ton);
            p4s = [p4s Rpeaks(k)+delta_4_i];
 			[ delta_3_i, delta_3 ] = p3(y_2, delta_4_i, j, coeffs);
            p3s = [p3s Rpeaks(k)+delta_3_i];
            
            [delta_2_i, delta_2] = p2( y_2, delta_3_i, j);
            p2s = [p2s Rpeaks(k)+delta_2_i];
 			[delta_1_i, delta_1] = p1(y_2, j, 1);
            p1s = [p1s Rpeaks(k)+delta_1_i];
 			typ=class_it(delta_1, delta_2, delta_3, delta_4);
            typy = [typy typ];
            m1s = [m1s Rpeaks(k)+j];
            r1s = [r1s Rpeaks(k)+ton];
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

