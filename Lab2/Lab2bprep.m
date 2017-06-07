clear all
clc
close all
clf


% Load
load('s'); %To load mat file.
load('speech')
%%
a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N = [a b c d a];
D = [1 0 0 0 0];
ts = 0:1/8000:(length(s)-1)/8000;

soundhand(s, 8000, 0, 1, N, D)


%% Play and filter
Fs = 8000; %hz
len = max([length(s)/Fs length(speech)/Fs])
sound(s,Fs)
pause(len)
sound(speech,Fs)
pause(len)


a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N = [a b c d a];
D = [1 0 0 0 0];

% To filter x using N, D:
%N(1)zmax + .. N(end-1)z + N(end)/ D(1)zmax ... + D(end)
[sfiltered,zf] = filter(N,D,s);
[speechfiltered,zf2] = filter(N,D,speech);

sound(sfiltered,Fs)
pause(len)
sound(speechfiltered,Fs)



%% Plot time and frequency
N = 2048;

figure(1)
subplot(2,1,1)
ts = 0:1/Fs:(length(s)-1)/Fs;
plot(ts,s)
title('Time domain before filtering')


sfreq = fftshift(fft(s,N));
F = ([-N/2:(N-1)/2]/N)*Fs;
subplot(2,1,2)
plot(F,abs(sfreq));
title('Frequency domain before filtering')

figure(2)
subplot(2,1,1)
ts = 0:1/Fs:(length(sfiltered)-1)/Fs;
plot(ts,sfiltered)
title('Time domain after filtering')

sfilteredfreq = fftshift(fft(sfiltered,N));
F = ([-N/2:(N-1)/2]/N)*Fs;
subplot(2,1,2)
plot(F,abs(sfilteredfreq));
title('Frequency domain after filtering')

