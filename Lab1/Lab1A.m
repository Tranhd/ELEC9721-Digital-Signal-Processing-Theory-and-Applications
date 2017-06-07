%% 1 
close all
clear all
clc
clf

f = 1000; %Hz
fs = 5e3; %Sampling frequency
t = [0:(1/fs):1];
sampledsine = sin(2*pi*f*t);
figure(1)
plot(t,sampledsine); %1s of the sampled sine.
figure(2)
t2 = [0:(1/fs):1/f];
sampledsine2 = sin(2*pi*f*t2); 
plot(t2,sampledsine2) %One period of the sampled signal.

%% 2
close all 
clc
clf
clear all

f = 1000; %Hz
fs = 5e3; %Sampling frequency
t = [0:(1/fs):1];
sampledsine = sin(2*pi*f*t);

N = 2048;
figure(1);
frqspec = (abs(fftshift(fft(sampledsine,N))));
F = [-N/2:(N-1)/2]/N
plot(F*fs,frqspec)

%Frequency resolution in terms of sampling frequency
%% 3
clear all
close all
clc
clf

f = 2250; %Hz
fs = 5e3; %Sampling frequency
t = [0:(1/fs):1];
sampledsine = sin(2*pi*f*t);
sampledsine(sampledsine > 0.3) = 0.3;
sampledsine(sampledsine < -0.3) = -0.3;

figure(1)
plot(t,sampledsine); %1s of the sampled sine.

%To make things clearer
figure(2)
t2 = [0:(1/(100*fs)):5/f];
sampledsine2 = sin(2*pi*f*t2); 
sampledsine2(sampledsine2 > 0.3) = 0.3;
sampledsine2(sampledsine2 < -0.3) = -0.3;
plot(t2,sampledsine2)


%% 4 
clear all
close all
clc
clf


f = 2250; %Hz
fs = 5e3; %Sampling frequency
t = [0:(1/fs):1];
sampledsine = sin(2*pi*f*t);
sampledsine(sampledsine > 0.3) = 0.3;
sampledsine(sampledsine < -0.3) = -0.3;

N = 2048;
figure(1);
frqspec = (abs(fftshift(fft(sampledsine,N))));
F = [-N/2:(N-1)/2]/N;
plot(F*fs,frqspec)
