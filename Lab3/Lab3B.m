clear all
clc
clf
close all

%% 1
fs = 8000; %Sampling frequency
Wp = [1500/(fs/2), 2000/(fs/2)]; %Passband
Ws = [1000/(fs/2), 2500/(fs/2)]; %Stopband 
n= 22; %Order

b = fir1(n,Wp,rectwin(n+1));
figure(1)
[H,w] = freqz(b);
w = w*fs/(2*pi);
subplot(2,1,1)
plot(w,phase(H))
xlabel('Hz')
ylabel('Degrees')
title('Phase response')
subplot(2,1,2)
plot(w,20*log10(abs(H)))
xlabel('Hz')
ylabel('dB')
title('Magnitude response')

%% 2
close all
clf
clear all
clc


fs = 8000; %Sampling frequency
Wp = [1500/(fs/2), 2000/(fs/2)]; %Passband
Ws = [1000/(fs/2), 2500/(fs/2)]; %Stopband 
n=22; %Order
f = [0 Ws(1) Wp Ws(end) 1];
m = [0 0 1 1 0 0];

b = fir2(n,f,m,rectwin(n+1));
figure(1)
[H,w] = freqz(b);
w = w*fs/(2*pi);
subplot(2,1,1)
plot(w,phase(H))
xlabel('Hz')
ylabel('Degrees')
title('Phase response')
subplot(2,1,2)
plot(w,20*log10(abs(H)))
xlabel('Hz')
ylabel('dB')
title('Magnitude response')

%% 3 
clc
clf
clear all
close all

fs = 8000; %Sampling frequency
Wp = [1500/(fs/2), 2000/(fs/2)]; %Passband
Ws = [1000/(fs/2), 2500/(fs/2)]; %Stopband 
Rp = 1; %Passband ripple
Rs = 30; %Stopband attenuation
eps = 10e-10;
% f = [Ws(1) (Wp(1)-eps) Wp (Wp(end)+eps) Ws(end)];
% m = [0 0 1 1 0 0];
f = [0 Ws(1) Wp Ws(end) 1];
m = [0 0 1 1 0 0];

Passbandripple = 10;
Stopbandattenuation = -10;
n=10;
while(Passbandripple > Rp && Stopbandattenuation > -Rs)
    b = firpm(n,f,m);
    [H,w] = freqz(b);
    w=w/(pi);
    Hdb = 20*log10(abs(H));
    Passabandripple = abs(max(Hdb(w>Wp(1) & w < Wp(end)))-min(Hdb(w>Wp(1) & w < Wp(end))))
    Stopbandattenuation = min(Hdb((w>Ws(1) & w < Wp(1)) | ((w>Wp(end) & w < Ws(end)))))
    n = n+1;
end
st = zeros(1,length(w));
st((w>Ws(1) & w < Wp(1)) | ((w>Wp(end) & w < Ws(end)))) = Stopbandattenuation;
figure(1)
[H,w] = freqz(b);
w = w*fs/(2*pi);
subplot(2,1,1)
plot(w,phase(H))
xlabel('Hz')
ylabel('Degrees')
title('Phase response')
subplot(2,1,2)
plot(w,20*log10(abs(H)))
hold on
plot([0, 1000],[Stopbandattenuation Stopbandattenuation],'r')
hold on
plot([2500, 4000],[Stopbandattenuation Stopbandattenuation],'r');
hold on
xlabel('Hz')
ylabel('dB')
title('Magnitude response')

%% 5
clear all
close all
clc
clf

fs = 8000; %Sampling frequency
Wp = [1500/(fs/2), 2000/(fs/2)]; %Passband
Ws = [1000/(fs/2), 2500/(fs/2)]; %Stopband 
bd = 500;
thetac = mean(Wp)*pi;
thetab = ((Wp(end)-Wp(1))/2)*pi;
N= 22; %Order
Beta = N/2;

n = 0:N-1;

h = (1./(pi*(n-Beta))).*(sin((thetac+thetab)*(n-Beta)) - sin((thetac-thetab)*(n-Beta)));
h(12)=1

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