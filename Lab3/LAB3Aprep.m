%% Impulse invariant transform
clear all
clc
clf
close all

cf = 250;
wd= cf*2*pi;
fs = 2e3;
T = 1/fs;


K = sqrt(2)*wd*exp(T*wd/sqrt(2))*sin(T*wd/sqrt(2))*T;
b1 = -2*exp(T*wd/sqrt(2))*cos(T*wd/sqrt(2));
b2 = exp(2*wd*T/sqrt(2));

BZ = [0 K 0];
AZ = [b2 b1 1];

b = [0 0 wd^2];
a = [1 sqrt(2)*wd wd^2];
[bz,az] = impinvar(b,a,fs); % Impvar scales by 1/fs. Hence multiply by fs.
freqz(bz,az)
title('Matlab transform')
figure;
freqz(BZ,AZ)
title('Theory')

[h,f] = freqz(bz,az,2024,fs);
[H,F] = freqz(BZ,AZ,2024,fs);


% Same answer for both, not exactly 250 Hz but pretty close.
% More accurate answer if we increase sampling frequency.
i = find(abs(abs(h) - abs(h(1))/sqrt(2)) < 0.001);
Cutoff_matlab = f(i)
i = find(abs(abs(H) - abs(H(1))/sqrt(2)) < 0.001);
Cutoff_Theory = F(i)

%% Bilinear transform

clear all
close all
clc
clf

cf = 250;
wd= cf*2*pi;
fs = 2e3;
T = 1/fs;

% Prewarp:
wd = 2/T*tan(wd*T/2);

den = 4 + wd*sqrt(2)*2*T+ wd^2*T^2;
a0 = (wd^2*T^2)/den;
a1 = 2*a0;
a2 = a0;
b1 = (2*wd^2*T^2 - 8)/den;
b2 = (4-wd*sqrt(2)*2*T + wd^2*T^2)/den;
BZ = [a0 a1 a2];
AZ = [1 b1 b2];

wd2 = cf*2*pi;
b = [0 0 wd2^2];
a = [1 sqrt(2)*wd2 wd2^2];
[bz,az] = bilinear(b,a,fs); 
freqz(bz,az)
title('Matlab transform')
figure;
freqz(BZ,AZ)
title('Theory')

[h,f] = freqz(bz,az,2024,fs);
[H,F] = freqz(BZ,AZ,2024,fs);


% Not the same answer for both, exact answer for the calculation and warping done on paper.
% But not when using Matlabs built in function.
% More accurate answer if we increase sampling frequency.
i = find(abs(abs(h) - abs(h(1))/sqrt(2)) < 0.001);
f(i)
i = find(abs(abs(H) - abs(H(1))/sqrt(2)) < 0.001);
F(i)
