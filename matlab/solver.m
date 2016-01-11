function [j, ton, coeffs] = solver( xData, yData)
    [blad111,leftCoeffs111, coeffs111, rightCoeffs111, j111, ton111] = dopasuj(xData, yData,1,1,1);
    [blad112,leftCoeffs112, coeffs112,rightCoeffs112, j112, ton112]= dopasuj(xData, yData,1,1,2);
    [blad121,leftCoeffs121, coeffs121,rightCoeffs121, j121, ton121] = dopasuj(xData, yData,1,2,1);
    [blad122,leftCoeffs122, coeffs122,rightCoeffs122, j122, ton122] = dopasuj(xData, yData,1,2,2);
    minimalnyBlad = min([blad111, blad112, blad121, blad122]);
    if(minimalnyBlad ==blad111)
        j = j111;
        ton =ton111;
        coeffs =coeffs111;
        leftCoeffs =leftCoeffs111;
        rightCoeffs =rightCoeffs111;
    elseif(minimalnyBlad ==blad112)
        j =j112;
        ton =ton112;
        coeffs =coeffs112;
        leftCoeffs =leftCoeffs112;
        rightCoeffs =rightCoeffs112;
    elseif(minimalnyBlad ==blad121)
        j = j121;
        ton =ton121;
        coeffs =coeffs121;
        leftCoeffs =leftCoeffs121;
        rightCoeffs =rightCoeffs121;
    else 
        j =j122;
        ton =ton122;
        coeffs =coeffs122;
        leftCoeffs =leftCoeffs122;
        rightCoeffs =rightCoeffs122;
    end
    
%     hold off
%     plot(xData,yData);
%     hold on;
%     plot(xData(1:j),polyval(leftCoeffs,xData(1:j)),'r');
%     plot(xData(j:ton),polyval(coeffs,xData(j:ton)),'r');
%     plot(xData(ton:length(xData)),polyval(rightCoeffs,xData(ton:length(xData))),'r');
end

function [error, leftCoeffs,middleCoeffs, rightCoeffs, j, ton] = dopasuj(xData, yData, stopienLewy, stopienSrodek, stopienPrawy)
    dokonanoZmiany = 1;
    len = length(xData);
    j = floor(len/3);
    ton = j*2;
    leftCoeffs = [];
    middleCoeffs = [];
    rightCoeffs = [];
    error = inf;
    while dokonanoZmiany == 1
        %solveMiddlePoint returns coeffs of right part thats why we want to return only
        %these coeffs (coeffs of middle part)
        [nowyJ, leftError, middleError, leftCoeffs, middleCoeffs] = solveMiddlePoint(xData(1:ton), yData(1:ton)', j, stopienLewy, stopienSrodek); 
        [nowyTon,middleError, rightError, middleCoeffs, rightCoeffs] = solveMiddlePoint(xData(nowyJ:len) , yData(nowyJ:len)',  ton, stopienSrodek, stopienPrawy);
        newError = leftError+middleError+rightError;
        if newError < error
            j = nowyJ;
            ton=nowyTon;
            error = newError;
            dokonanoZmiany = 1;
        else 
            dokonanoZmiany = 0;
        end
    end
end
%     
%     
%     
% 	while ~((m1_b == m1 )&& (r1_b == r1) &&( l2_b == l2) && (m2_b == m2)||(i==l_1))
%        	consta = 1;
%         [newMiddle] = solveMiddlePoint(xData(consta:m2), yData(consta:m2), l2, 'left');
% 		
% 		m1 = newMiddle;		
% 		r1 = m2;
% 		
% 		[newMiddle] = solveMiddlePoint(xData(m1:l_y) , yData(m1:l_y),  r1, 'right' );    
%         
% 		l2 = m1;
% 		m2 = newMiddle;
% 		
% 		m1_b = m1;
% 		r1_b = r1;
% 		l2_b = l2;
% 		m2_b = m2;
%         if (l2<2)
%             l2=2;
%         end
%         if(m2<l_1)
%             m2=l_1;
%         end
%         i=i+1;
%     end