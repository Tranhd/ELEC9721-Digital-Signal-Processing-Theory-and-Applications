function [de,fixedx,err]= DecimalToFixedPoint(X,I,F)
% Function [de,fixedx,err]= DecimalToFixedPoint (X,I,F)
% e.g [3.625, 011.101, 0]=DecimalToFixedPoint(3.625, 3,3);

% Inputs:
% ? The number X
% ? Number of bits for I and F

%Outputs:
% ? Decimal equivalent of I.F
% ? fixedX - the fixed point representation (as a string)
% ? Error.

sign = 1;
if X < 0
    sign = -1;
end

l1 = -(I-1):F; % List of powers we can use
st1 = (sign*X)*pow2(l1); % multiply x by every such 2^power, to seperate coefficients
reminder = rem(st1,2); % Find the reminder when divided by 2
d2b = fix(reminder); % Fix the reminder for array of binary number


s1 = num2str(d2b(1:I));
s2 = num2str(d2b(I+1:end));
s1 = regexprep(s1,'[^\w'']','');
s2 = regexprep(s2,'[^\w'']','');
fixedx = strcat(s1,'.',s2);
de = sign*(bin2dec(s1) + 2^-F*bin2dec(s2));
err = abs(abs(X) - abs(de));
if sign < 0
    ls = zeros(1,length(d2b));
    ls(end) = 1;
    d2b = dec2bin(bin2dec(num2str((~d2b))) + bin2dec(num2str(ls)));
    fixedx = strcat(d2b(1:I),'.',d2b(I+1:end));
end
end

