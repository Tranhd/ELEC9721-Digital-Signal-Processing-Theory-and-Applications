%% Lab5

%% 2
clc
clf
clear all
close all

[speech,fs] = audioread('speech.wav');

% Upsample by 3.
speechup = zeros(1,3*length(speech));
k=1;
for i=1:length(speechup)
    if mod(i,3) == 0
        speechup(i) = speech(k);
        k = k+1;
    end
end
% Filter spec: LPF fc=8kHz order: 80
fsU = fs*3; 
n = 80;
fc = 8e3;
scaledfc = fc/(fsU/2);

f1 = [0.0 scaledfc-0.1 scaledfc+0.1 1];
a1 = [1.0 1.0 0.0 0.0];
b1 = firpm(n,f1,a1);
[h1,w1] = freqz(b1,1,1024,fsU);

% Filter.
speechfilt = filter(b1,1,speechup);

% Downsample
speechfinal = speechfilt(1:2:end);
fsfinal = fsU/2;

figure(1)
% Speech
subplot(4,1,1)
N = 2024; 
fftSpeech = abs(fftshift(fft(speech, N)));
F = [0:N/2]*(fs)/N;
plot(F,fftSpeech([N/2:end]))

% Speech after upsamples
subplot(4,1,2)
fftSpeechUp = abs(fftshift(fft(speechup, N)));
F = [0:N/2]*(fsU)/N;
plot(F,fftSpeechUp([N/2:end]))
hold on
plot(w1,abs(h1))

% Speech after lowpass
subplot(4,1,3)
fftSpeechFilt = abs(fftshift(fft(speechfilt, N)));
F = [0:N/2]*(fsU)/N;
plot(F,fftSpeechFilt([N/2:end]))

% Speech final
subplot(4,1,4)
fftspeechfinal = abs(fftshift(fft(speechfinal, N)));
F = [0:N/2]*(fsfinal)/N;
plot(F,fftspeechfinal([N/2:end]))

%% Play the sound
player1 = audioplayer(speech, fs);
play(player1);
pause(2.5)
player2 = audioplayer(speechfinal, fsfinal);
play(player2);

%% b)
clc
clf
clear all
close all

[speech,fs] = audioread('speech.wav');

% Filter spec: LPF fc=8kHz order: 80 
n = 80;
fc = 4e3;
scaledfc = fc/(fs/2);
 
f1 = [0.0 scaledfc-0.1 scaledfc+0.1 1];
a1 = [1.0 1.0 0.0 0.0];
b1 = firpm(n,f1,a1);
[h1,w1] = freqz(b1,1,1024,fs);

%Filter.
speechfilt1 = filter(b1,1,speech);

% Downsample by 2
speechDown = speechfilt1(1:2:end);
fsD = fs/2;

% Upsample by 3.
fsfinal = fsD*3;
speechup = zeros(1,3*length(speechDown));
k=1;
for i=1:length(speechup)
    if mod(i,3) == 0
        speechup(i) = speechDown(k);
        k = k+1;
    end
end

%Filter spec: LPF fc=8kHz order: 80 
n = 80;
fc = 4e3;
scaledfc2 = fc/(fsfinal/2);

f2 = [0.0 scaledfc2-0.1 scaledfc2+0.1 1];
a2 = [1.0 1.0 0.0 0.0];
b2 = firpm(n,f2,a2);
[h2,w2] = freqz(b2,1,1024,fsfinal);

%Filter.
speechfinal = filter(b2,1,speechup);

figure(1)
% Speech
subplot(5,1,1)
N = 2024; 
fftSpeech = abs(fftshift(fft(speech, N)));
F = [0:N/2]*(fs)/N;
plot(F,fftSpeech([N/2:end]))
hold on
plot(w1,abs(h1))

% Speech after first filter
subplot(5,1,2)
fftSpeechFilt1 = abs(fftshift(fft(speechfilt1, N)));
F = [0:N/2]*(fs)/N;
plot(F,fftSpeechFilt1([N/2:end]))

% Speech after Downsample
subplot(5,1,3)
fftspeechDown = abs(fftshift(fft(speechDown, N)));
F = [0:N/2]*(fsD)/N;
plot(F,fftspeechDown([N/2:end]))

% Speech after Upsample
subplot(5,1,4)
fftspeechup = abs(fftshift(fft(speechup, N)));
F = [0:N/2]*(fsfinal)/N;
plot(F,fftspeechup([N/2:end]))
hold on
plot(w2,abs(h2)/10)


% Final speach
subplot(5,1,5)
fftspeechfinal= abs(fftshift(fft(speechfinal, N)));
F = [0:N/2]*(fsfinal)/N;
plot(F,fftspeechfinal([N/2:end]))

%% Play
player1 = audioplayer(speech, fs);
play(player1);
pause(2.5)
player2 = audioplayer(speechfinal, fsfinal);
play(player2);