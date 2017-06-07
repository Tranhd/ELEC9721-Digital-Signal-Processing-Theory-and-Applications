function [X]= FixedPointToDecimal (BinX,I,F)
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
X = sign*sum(binaryarray.*pow2(powers));
end

