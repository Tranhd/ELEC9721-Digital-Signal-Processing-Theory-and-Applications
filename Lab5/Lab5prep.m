clear all
close all
clc
clf

fs = 16000; %Sampling frequency

% Frequencies of x
f1 = 500;
f2 = 1500;
f3 = 4500;

% Create the signal.
n= 0:2023;
x = cos(2*pi*f1/fs.*n) + cos(2*pi*f2/fs.*n) + cos(2*pi*f3/fs.*n);

% Frequency amplitude spectrum.
N = 2024; 
fftX = abs(fftshift(fft(x, N)));
F = [0:N/2]*(fs)/N;

% Filter 1 spec: LPF fc=4kHz order: 20 Filter 2 spec: LPF fc=7.5kHz order: 20.
n = 20;
fc1 = 4000;
fc2 = 7500;
scaledfc1 = fc1/(fs/2);
scaledfc2 = fc2/(fs/2);


f1 = [0 0.3 scaledfc1 0.6 0.75 1];
a1 = [1.0 1.0 1.0 0.0 0.0 0];
b1 = firpm(n,f1,a1);
[h1,w1] = freqz(b1,1,512,fs);

f2 = [0 0.6 0.75 scaledfc2 0.99 1];
a2 = [1.0 1.0 1.0 0.0 0.0 0.0];
b2 = firpm(n,f2,a2);
[h2,w2] = freqz(b2,1,512,fs);


figure(1)
subplot(3,1,1)
plot(F,fftX([N/2:end]))
hold on
plot(w1,abs(h1)*max(fftX))
xlabel('Hz')
ylabel('X(f)')
title('Filter cutoff 4 kHz')

subplot(3,1,1)
x11 = filter(b1,1,x);
fftX11 = abs(fftshift(fft(x11, N)));
subplot(3,1,2)
plot(F,fftX11([N/2:end]))

subplot(3,1,3)
x11down = x11(1:3:end);
fsnew = fs/3;
Fnew = [0:N/2]*(fsnew)/N;
fftX11down = abs(fftshift(fft(x11down, N)));
plot(Fnew,fftX11down([N/2:end]))


figure(2)
subplot(3,1,1)
plot(F,fftX([N/2:end]))
hold on
plot(w2,abs(h2)*max(fftX))
xlabel('Hz')
ylabel('X(f)')
title('Filter cutoff 7.5 kHz')

subplot(3,1,2)
x12 = filter(b2,1,x);
fftX12 = abs(fftshift(fft(x12, N)));
plot(F,fftX12([N/2:end]))

subplot(3,1,3)
x12down = x12(1:3:end);
fftX12down = abs(fftshift(fft(x12down, N)));
plot(Fnew,fftX12down([N/2:end]))

