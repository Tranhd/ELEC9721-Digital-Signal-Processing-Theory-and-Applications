%% 1 
clc
clear all
close all
clf

x=zeros(10,128);
t1=[0:1/128:1-1/128]; 
z=cos(2*pi*2*t1); % Frequency 2
x(1,:)=z; %First row of x is z, dimensions of x is 10x128.
xpadded=reshape(x,1,1280); %rehaspes x to an 1x1280 array.
xnotpadded = x(1,:);
index = find(x~=0); %Non zero values spread out with distance 10 indexes. 
figure(1);
plot(xpadded) %Like sampled signals every tenth time instant.


T = (1/128)/10;
fs = 1/T;
f = 2*10;
N = 1280;
F = [-N/2:(N-1)/2]*fs/N;
Xf = (fftshift(fft(xpadded,N)));


figure(2);
subplot(1,2,1);plot(F,abs(Xf));
title('ABS')

index = (F<128-2*f | F>128+2*f);
Xf(index)=0;
subplot(1,2,2);plot(F,abs(Xf),'r')
title('Filtered')


% Xfn = (fftshift(fft(xnotpadded,N)));
% figure(3)
% plot(F*fs,abs(Xfn))
% 
% X = zeros(10,128);
% X(1,:) = Xfn;
% X = reshape(X,1,1280);

%% 2 
clc
figure(4)
subplot(1,2,1);plot(t1,z)
y = abs(ifft((Xf),N));
subplot(1,2,2);plot(y);
