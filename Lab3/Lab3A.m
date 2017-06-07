%% 2
clear all
close all 
clc
clf

fs = 8000; %Sampling frequency
Wp = [1500/(fs/2), 2000/(fs/2)]; %Passband
Ws = [1000/(fs/2), 2500/(fs/2)]; %Stopband 
Rp = 0.5; %Passband ripple
Rs = 20; %Stopband attenuation

[n1,wn1] = buttord(Wp,Ws,Rp,Rs);
[n2,wn2] = cheb1ord(Wp,Ws,Rp,Rs);
[n3,wn3] = cheb2ord(Wp,Ws,Rp,Rs);
[n4,wn4] = ellipord(Wp,Ws,Rp,Rs);

[B1,A1] = butter(n1,wn1);
[B2,A2] = cheby1(n2,Rp,wn2);
[B3,A3] = cheby2(n3,Rs,wn3); 
[B4,A4] = ellip(n4,Rp,Rs,wn4);

[h1,w1] = freqz(B1,A1,1024,fs); 
[h2,w2] = freqz(B2,A2,1024,fs);
[h3,w3] = freqz(B3,A3,1024,fs);
[h4,w4] = freqz(B4,A4,1024,fs);

mag1 = 20*log10(abs(h1)); 
mag2 = 20*log10(abs(h2));
mag3 = 20*log10(abs(h3));
mag4 = 20*log10(abs(h4));

plot(w1,mag1,w2,mag2,w3,mag3,w4,mag4); legend('Butterworth','Chebysev1','Chebysev2','Elliptic',3);
grid on; xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

% Observations:
% As expected the butterworth filter does not have any ripple
% Chebyshev type 1 has passband ripple
% Chebyshev type 2 has stopband ripple
% elliptic has both ripple in stopband and passband

% Chebyshev type 2 and elliptic, who suffers from ripple in the stopband
% Does attenuate strongly att the specified frequencies but bounces rapidly
% up, much as a notch filter (Not good(?)).

%Elliptic does not assymptotically attenuate higher and lower frequencies.

%The order of the filter is 4 for elliptic and 6 for the rest
%% 3
close all
clc
clf
fs = 8000; 
n = 0:2023; 
x = sin(2*pi*600/fs*n) + sin(2*pi*1100/fs*n) + sin(2*pi*1700/fs*n) + sin(2*pi*2300/fs*n) + sin(2*pi*2800/fs*n);
N = 2024; 
BeforfiltFFT = abs(fftshift(fft(x, N)));
F = ([-N/2:(N-1)/2]/N)*fs;

figure(1)
plot(F,BeforfiltFFT)
hold on
plot(w1,max(BeforfiltFFT)*abs(h1),'r')
hold on
plot(-w1,max(BeforfiltFFT)*abs(h1),'r')


out = filter(B1,A1,x);
N = 1024; 
AfterfiltFFT = abs(fftshift(fft(out, N)));
F = ([-N/2:(N-1)/2]/N)*fs;
figure(2)
plot(F,AfterfiltFFT)


