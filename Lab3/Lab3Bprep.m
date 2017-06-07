clear all
clc
clf
close all

% fs = 2500;
% Wp = 500/(fs/2);
% Ws = 600/(fs/2);
% Rp = 0.5; %Passband ripple
% Rs = 20; %Stopband attenuation
% 
% [n1,wn1] = buttord(Wp,Ws,Rp,Rs);
% [B1,A1] = butter(n1,wn1);
% freqz(B1,A1); 

fs = 2500;
passband = [0 500];
stopband = [600 1250];
fc = (passband(end) + stopband(1))/2;
N = 21;
Beta = (N-1)/2;
thetac = fc/fs * 2*pi;
n = 0:N-1;
thetanopi = fc/fs * 2;

h = sinc(thetanopi*(n-Beta))*thetanopi;
%h = sin(thetac*(n-Beta))./(pi*(n-Beta))
figure(1)
stem(n,h)
title('Impulse response')

figure(2)
[H,w] = freqz(h);
w = w*fs/(2*pi);
subplot(2,1,1)
plot(w,phase(H))
xlabel('Hz')
title('Phase response (Freqz)')
subplot(2,1,2)
plot(w,abs(H))
xlabel('Hz')
title('Magnitude response (Freqz)')

Nf = 2024; 
Hfft = (fftshift(fft(h, Nf)));
Hfft = Hfft((length(Hfft)+1)/2:end);
F = ([0:(Nf-1)/2]/Nf)*fs;
figure(3)
subplot(2,1,1)
plot(F,phase(Hfft))
xlabel('Hz')
title('Phase response (FFT)')
subplot(2,1,2)
plot(F,abs(Hfft))
xlabel('Hz')
title('Magnitude response (FFT)')


% h2 = sinc(thetanopi*(n-Beta))*thetanopi;
% hamming = h2.*hamming(21)';
% blackman = h2.*blackman(21)';
% [H2,w] = freqz(blackman);
% [H,w] = freqz(hamming);
% w = w*fs/(2*pi);
% figure(4)
% subplot(2,1,1)
% plot(w,phase(H),w,phase(H2))
% xlabel('Hz')
% title('Phase response (Freqz)')
% subplot(2,1,2)
% plot(w,abs(H),w,abs(H2))
% xlabel('Hz')
% title('Magnitude response (Freqz)')