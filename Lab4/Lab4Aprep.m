clc
clear all

[de,fixedx,err] = DecimalToFixedPoint(3.625,3,3); % Correct
[de,fixedx,err] = DecimalToFixedPoint(-3.625,3,3); % Correct
[de,fixedx,err] = DecimalToFixedPoint(4,4,1); % Correct
[de,fixedx,err] = DecimalToFixedPoint(-4,4,1); % Correct
[de,fixedx,err] = DecimalToFixedPoint(-8,4,1); % Correct
[de,fixedx,err] = DecimalToFixedPoint(0,4,1); % Correct
[de,fixedx,err] = DecimalToFixedPoint(3.925,3,3); % Not Correct, but correct error.


% x = -3.625;
% I = 3;
% F = 3;
% sign = 1;
% if x < 0
%     sign = -1;
% end
% 
% l1 = -(I-1):F; % List of powers we can use
% st1 = (sign*x)*pow2(l1); % multiply x by every such 2^power, to seperate coefficients
% reminder = rem(st1,2); % Find the reminder when divided by 2
% d2b = fix(reminder); % Fix the reminder for array of binary number
% 
% 
% s1 = num2str(d2b(1:I));
% s2 = num2str(d2b(I+1:end));
% s1 = regexprep(s1,'[^\w'']','');
% s2 = regexprep(s2,'[^\w'']','');
% spos = strcat(s1,'.',s2);
% error = abs(abs(x) - (bin2dec(s1) + 2^-F*bin2dec(s2)));
% if sign < 0
%     ls = zeros(1,length(d2b));
%     ls(end) = 1;
%     d2b = dec2bin(bin2dec(num2str((~d2b))) + bin2dec(num2str(ls)));
% end
% sneg = strcat(d2b(1:I),'.',d2b(I+1:end));



