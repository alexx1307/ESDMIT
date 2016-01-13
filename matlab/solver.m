function [ton, coeffs] = solver( xData, yData)
    [blad11,leftCoeffs11, rightCoeffs11, ton11] = dopasuj(xData, yData,1,1);
    [blad12,leftCoeffs12, rightCoeffs12, ton12]= dopasuj(xData, yData,1,2);
    [blad21,leftCoeffs21, rightCoeffs21, ton21] = dopasuj(xData, yData,2,1);
    [blad22,leftCoeffs22, rightCoeffs22, ton22] = dopasuj(xData, yData,2,2);
    minimalnyBlad = min([blad11, blad12, blad21, blad22]);
    if(minimalnyBlad ==blad11)
        ton =ton11;
        coeffs =leftCoeffs11;
    elseif(minimalnyBlad ==blad12)
        ton =ton12;
        coeffs =leftCoeffs12;
    elseif(minimalnyBlad ==blad21)
        ton =ton21;
        coeffs =leftCoeffs21;
    else 
        ton =ton22;
        coeffs =leftCoeffs22;
    end
end

function [error, leftCoeffs, rightCoeffs, ton] = dopasuj(xData, yData, stopienLewy, stopienPrawy)
    len = length(xData);
    ton = floor(len/2);
    leftCoeffs = [];
    rightCoeffs = [];
    error = inf;

    [ton, error, leftCoeffs, rightCoeffs] = solveMiddlePoint(xData, yData', ton, stopienLewy, stopienPrawy); 
end