%% Lab2A
%% 2
clear all
close all
clc
clf

a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N = [a b c d a];
D = [1 0 0 0 0];
[h,t] = impz(N,D);


x = [1 2 5 7 9 11 9 7 5 3 1];
[y,t] = my_conv(x);
figure(1)
plot(t,y,'r')
hold on
plot(t,conv(h,x),'c--')
title('My conv function','interpreter','latex','fontsize',16);
h = legend('My conv','Matlabs conv','interpreter','location','best')
set(h,'Interpreter','latex','fontsize',16);

%% 3 
figure(2)
subplot(2,2,1)
plot(x)
title('input X','interpreter','latex','fontsize',16);

subplot(2,2,2)
plot(y)
title('Filtered with convolution','interpreter','latex','fontsize',16);

[y2,zf] = filter(N,D,x); %Filter returns x filtered but at the same length.
subplot(2,2,3) 
plot(y2) % So y2 are missing the last values, but found in zf.
title('Filtered with matlabs filter function','interpreter','latex','fontsize',16);

subplot(2,2,4) 
plot([y2 zf']) % So y2 are missing the last values, but found in zf.
% Contains the values that are supposed to go as input to "next sequence"
% or delayed values, in this case we have 4 delayed values.
title('Corrected','interpreter','latex','fontsize',16);

%% 4
figure(3)

fy = fft(y,11);
yfromfreq = ifft(fy);
fy2 = fft(y,15);
yfromfreq2 = ifft(fy2);

subplot(1,2,1);plot(yfromfreq)
title('11 Samples','interpreter','latex','fontsize',16);
subplot(1,2,2);plot(yfromfreq2)
title('15 Samples','interpreter','latex','fontsize',16);

length(y) + length(h) - 1

