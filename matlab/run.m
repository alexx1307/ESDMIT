function [ m1s, r1s, p4s, p3s, p2s, p1s, typy, nachylenia, epizody ] = run( ecgData, Rpeaks, Tpeaks, qrsEnd)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    y = ecgData;
    l_r = length(Rpeaks);
	x = 1:length(ecgData);
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
    tPeakCounter = 1;
    tic
    for k = 1:l_r-1
        try
			RR = Rpeaks(k + 1) - Rpeaks(k);
            
			%analiza pojedynczego przebiegu EKG

			x_1 = x(Rpeaks(k):Rpeaks(k+1));
			y_1 = y(Rpeaks(k):Rpeaks(k+1));
            
            while (Tpeaks(tPeakCounter)<Rpeaks(k))
                tPeakCounter=tPeakCounter+1;
            end

            Tpeak_yi = -1;
            if(Tpeaks(tPeakCounter)<Rpeaks(k+1))
                Tpeak_yi = Tpeaks (k) - Rpeaks(k) +1;
            end
            
			j = qrsEnd(k)-Rpeaks(k)+1;
           

			%%%%%%%%%%%%%%%%%%%%
			 [s_val, s] = min(y_1(max(1,j-20):j+20));
             isS =  y_1(max(1,s-4))-0.08>y_1(s) && y_1(s) <y_1(s+4)-0.05;
             isS;
            if(isS)
                newJ = solveMiddlePoint(x_1(s:s+20)-1,y_1(s:s+20),1,2,2);
                newJ;
                j = s + newJ-1;
            end
            [ton, err, coeffs1, coeffs2] = solveMiddlePoint(x_1(j:Tpeak_yi), y_1(j:Tpeak_yi),floor((j+Tpeak_yi)/2), 2,2);
            ton= ton + j-1;
        
            if(ton-30<j)
                j = ton;
                [ton,err,coeffs1,coeffs2] = findMiddlePoint(x_1(j:Tpeak_yi), y_1(j:Tpeak_yi));
                ton= ton + j-1;
            end

            p1 = j;
            d1 = vif(isS==1,1,-1);
            p4 = vif(Tpeak_yi==-1,floor(RR/2),Tpeak_yi);
            d4 = checkDer(coeffs2,p4-j,0.001);
            d4 = vif(Tpeak_yi==-1,d4,checkDer(coeffs2,floor((p4+ton)/2)-j,0.001));
            p3 = floor((p4+p1)/2);
            if(length(y_1(max(floor((p4+p1)/2)-10, j+10):min(floor((p4+p1)/2)+20, ton+10)))>5)
                means = tsmovavg(y_1(max(floor((p4+p1)/2)-10, j+10):min(floor((p4+p1)/2)+20, ton+10)),'s',5);
                [sth, ind] = min(means);
                p3 = ind + max(floor((p4+p1)/2)-10, j+10)-1;
            end
            
            d3 = vif(y_1(p3-15)-0.02>y_1(p3)&& y_1(p3) <y_1(p3+15)-0.02,0,checkDer(coeffs1,p3,0.002));
            p2 = floor((p3+p1)/2);
            d2 = checkDer(coeffs1,p2,0.006);

%             [ delta_4_i, delta_4 ] = p4( RR, y_2, ton);
             p4s = [p4s Rpeaks(k)+p4-1];
%  			[ delta_3_i, delta_3 ] = p3(y_2, delta_4_i, j, coeffs);
             p3s = [p3s Rpeaks(k)+p3-1];
%             
%             [delta_2_i, delta_2] = p2( y_2, delta_3_i, j);
             p2s = [p2s Rpeaks(k)+p2-1];
%  			[delta_1_i, delta_1] = p1(y_2, j, 1);
             p1s = [p1s Rpeaks(k)+p1-1];
 			typ=class_it(d1, d2, d3, d4);
            typy = [typy typ];
            m1s = [m1s Rpeaks(k)+j-1];
            r1s = [r1s Rpeaks(k)+ton-1];
            nachylenie = 0.0;
			 wartosc_n = y_1(ton) - y_1(j);
			 dlugosc_n = ton - j;

			 nachylenie = wartosc_n / dlugosc_n;
            nachylenia = [nachylenia nachylenie];
            if (((y_1(ton) > 1) && (y_1(j) > 1) && (wartosc_n > 0)) || ((y_1(ton) > 2) && (y_1(j) > 2)))
				epizody = [epizody 1];			
            else
                epizody = [epizody 0];
            end
         catch
             typ =0;
             'error'
             typy = [typy typ];
         end

    end
    toc     
end


