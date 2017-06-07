clc
clf
clear all
close all

a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N = [a b c d a];
D = [1 0 0 0 0];
y = filter(N,D,0);
freqz(N,D)

figure;
impz(N,D);
[h,t] = impz(N,D);
xlabel('time [n]','interpreter','latex','fontsize',16);
ylabel('Impulse response','interpreter','latex','fontsize',16);

Gain = @(x) (abs(2*a*cos(2*x*pi) + 2*b*cos(x*pi) + c));
GaindB = @(x) 20*log10(abs(2*a*cos(2*x*pi) + 2*b*cos(x*pi) + c));
Phase = @(x) -pi*2*x*180/pi;

figure;
fplot(GaindB, [0 1.2],1000,'b')
title('The gain','interpreter','latex','fontsize',16);
xlabel('Normalized frequency (*$\pi$)','interpreter','latex','fontsize',16);
ylabel('Magnitude (dB)','interpreter','latex','fontsize',16);
grid on

figure;
fplot(Phase,[0 1],'r')
title('The phase','interpreter','latex','fontsize',16);
xlabel('Normalized frequency (*$\pi$)','interpreter','latex','fontsize',16);
ylabel('Phase (degrees)','interpreter','latex','fontsize',16);
grid on

Dcgain = Gain(0)
Gain(0.52576);
threedb = @(x) (abs(GaindB(x)+3));
options = optimset('fminbnd');
optnew = optimset(options,'TolX',1e-10);
dbcut = fminbnd(threedb,0,1,optnew)
dbVal = Gain(dbcut);

% x = rand(1,10)
% my_conv(x)
% conv(h,x)


