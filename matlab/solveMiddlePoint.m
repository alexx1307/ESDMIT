
function [ newMiddle, error, leftCoeffs, rightCoeffs] = solveMiddlePoint(x,y,middle,leftDeg,rightDeg)
%     if middle < 2
%         newMiddle = 1;
%         leftError = 0;
%         leftCoeffs = [0];
%         
%         return
%     end
%     if middle > length(x)-1  
%         newMiddle = length(x);
%         rightError = 0;
%         rightCoeffs = [0];
%         return
%     end
    
    len = length(x);
    x = 1:len;
    minError = Inf;
    newMiddle = floor(len/2);
    for i = 2:len-1
        [leftError,rightError, lcoeffs, rcoeffs] = approxBothSides(x,y,i,leftDeg,rightDeg);   %error is sum of approximation errors for both sides with current middle point   
        error = leftError + rightError;
        if minError > error
            newMiddle = i;
            leftCoeffs = lcoeffs;
            rightCoeffs = rcoeffs; 
            minError = error;
        end
    end
    error = minError;
%     x = 1:len;
%     [leftError,rightError, lcoeffs, rcoeffs] = approxBothSides(x,y,middle,leftDeg,rightDeg);   %error is sum of approximation errors for both sides with current middle point   
%     [leftErrorPrim,rightErrorPrim, lcoeffsPrim, rcoeffsPrim] = approxBothSides(x,y,middle-1,leftDeg,rightDeg); %errorPrim -||- middle point moved to left by 1
%     [leftErrorBis,rightErrorBis, lcoeffsBis, rcoeffsBis] = approxBothSides(x,y,middle+1,leftDeg,rightDeg);  %errorBis -||- middle point moved to right by 1
%     error = leftError+rightError; 
%     errorPrim = leftErrorPrim+rightErrorPrim; 
%     errorBis = leftErrorBis+rightErrorBis; 
%     minError = min([error, errorPrim, errorBis]);
%     if minError == error
%         newMiddle = middle;
%         leftCoeffs = lcoeffs;
%         rightCoeffs = rcoeffs;
%     elseif minError == errorPrim
%         newMiddle = middle - 1;
%         leftCoeffs = lcoeffsPrim;
%         rightCoeffs = rcoeffsPrim;
%         leftError = leftErrorPrim;
%         rightError = rightErrorPrim;
%     else
%         newMiddle = middle + 1;
%         leftCoeffs = lcoeffsBis;
%         rightCoeffs = rcoeffsBis;
%         leftError = leftErrorBis;
%         rightError = rightErrorBis;
%     end
end
function [ leftError,rightError, leftCoeffs, rightCoeffs ] = approxBothSides( x, y, middle, leftDeg, rightDeg )
    [leftError, leftCoeffs] = approximate(x(1:middle-1), y(1:middle-1), leftDeg);
    [rightError, rightCoeffs] = approximate(x(middle:length(x)), y(middle:length(x)), rightDeg);
end
function [ error, coeffs ] = approximate(x, y, deg )
    coeffs = polyfit(x, y, deg);
    aproximation = polyval(coeffs, x);    
    error = sum((aproximation-y).^2); %aproximation square error 
end
