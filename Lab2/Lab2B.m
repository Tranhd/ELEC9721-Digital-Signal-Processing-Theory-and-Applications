%% Lab 2B
% 1
clear all
close all
clc

load('s')
load('speech')
Fs = 8000;
a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N = [a b c d a];
D = [1 0 0 0 0];

%soundhand(s, Fs, play, plotting, Numcoeff, Dencoeff)
soundhand(speech, 8000, 1, 1, N, D)


%% 2
clc
close all
clf
clear all
load('speech')


Fs = 8000;
a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N1 = [a b c d a];
D = [1 0 0 0 0];

tot = [];
out = [];
filtot = [];
[h,t] = impz(N1,D,12);
N = 12;
i = 1;
filt = fft(h,N);
while i < length(speech)-12-1
    temp = fft(speech(i:i+12-1),N);
    tot = [tot temp];
    filtered = filt.*temp;
    filtot = [filtot filtered];
    temp2 = ifft(filtered);
    out = [out temp2'];
    i = i+12;
end
figure(1)
plot(out(1:100))
title('Time domain filtered signal')
figure(2)
plot(abs(tot(1:100)))
title('Frequency domain signal')

figure(3)
plot(abs(filtot(1:100)))
title('Frequency domain filtered signal')
soundhand(speech, 8000, 0, 1, N1, D)
sound(out)
%% 3 Overlapp save
clc
close all
clf
clear all
load('speech')
s = speech';



Fs = 8000;
a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N1 = [a b c d a];
D = [1 0 0 0 0];

tot = [];
out = [];
filtot = [];
[h,t] = impz(N1,D);
h = h';

M = length(h);
L = 12;
N = L+M-1;

i = 1;
s1 = [zeros(1,M-1) s(i:i+L-1)];
i = i+L;
h1 = [h zeros(1,L-1)];

yprime = ifft(fft(s1).*fft(h1));
yprime;
y = [];
y = [y yprime(M:end)];
tobeappended = yprime(length(yprime)-M+2:end);

freqspec = [];

while i < length(s)-12-1
    s1 = [tobeappended s(i:i+L-1)];
    freqspec = [freqspec fft(s1).*fft(h1)];
    yprime = ifft(fft(s1).*fft(h1));
    y = [y yprime(M:end)];
    tobeappended = yprime(length(yprime)-M+2:end);
    i = i+L;
end
plot(y(1:100))
figure;
plot(abs(freqspec(1:100)))
soundhand(speech, 8000, 0, 1, N, D)
sound(y)


%% 4 Overlapp add
clc
close all
clf
clear all
load('s')


Fs = 8000;
a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N1 = [a b c d a];
D = [1 0 0 0 0];

tot = [];
out = [];
filtot = [];
[h,t] = impz(N1,D);
h = h';

M = length(h);
L = 12;
N = L+M-1;

i = 1;
s1 = [s(i:i+L-1) zeros(1,M-1)];
i = i+L;
h1 = [h zeros(1,L-1)];

yprime = ifft(fft(s1).*fft(h1));
yprime;
y = [];
y = yprime;
tobeadded = yprime(1:M-1);
freqspec = [];

while i < length(s)-12-1
    s1 = [s(i:i+L-1) zeros(1,M-1)];
    freqspec = [freqspec fft(s1).*fft(h1)];
    yprime = ifft(fft(s1).*fft(h1));
    y = [y(1:length(y)-M+1) y(length(y)-M+2:end)+yprime(1:M-1) yprime];
    tobeadded = yprime(1:length(yprime)-M+1);
    i = i+L;
end
plot(y(1:100))
figure;
plot(abs(freqspec(1:100)))

