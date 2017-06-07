%% lab 4A
%% 1)
clear all
clc
[X,BinX,Errx] = DecimalToFixedPoint(0.7,2,2);
[Y,BinY,Erry] = DecimalToFixedPoint(8/3,3,3);
[Z,BinZ,Errz] = DecimalToFixedPoint(9.8765,4,4);

% 2)

X2 = FixedPointToDecimal(BinX,2,2)
Y2 = FixedPointToDecimal(BinY,3,3)
Z2 = FixedPointToDecimal(BinZ,4,4)
temp = FixedPointToDecimal('101.011',3,3)


%% 2 
clc
clear all
%function [X]= FixedPointToDecimal (fixedx,I,F)
%e.g. [3.625]= FixedPointToDecimal (011.101, 3,3)
BinX = '00.10'
C = strsplit(BinX,'.');
mosts = C{1};
less = C{2};
F = length(mosts);
I = length(less);
binaryarray = zeros(1,(I+F));
sign=1;
if str2num(mosts(1))
    sign = -1;
end
for i=1:(I+F)
    if i <= I
        binaryarray(i) = str2num(mosts(i));
    else
        binaryarray(i) = str2num(less(i-F));
    end
end
if sign < 0
    binaryarray = ~binaryarray;
    for i=1:length(binaryarray)
        if(binaryarray(end-i+1) == 0)
            binaryarray(end-i+1) = 1;
        else
            i = i+1;
        end
    end
end

res = 0;
j=1;
for i=-(I-1):F
    res = res + binaryarray(j)*2^(i);
    j = j+1;
end

powers1 = -I:0;
powers2 = 1:F-1;
powers = [fliplr(powers2) fliplr(powers1)];
st1 = sign*sum(binaryarray.*pow2(powers))

