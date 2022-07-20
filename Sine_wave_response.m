%clear all; close all; 
%Define TF and input variables
wn = 2*pi*4;
%Dampening factor calculated using Damp = (1/wn)*ln(Amplitude ratio) 
Damp =0.00495;

N = [wn^2]
D = [1 , 2*wn*Damp, wn^2 + (wn*Damp)^2]
sys = tf(N,D)
%Find poles of the system
[r,p,k] = residue(N,D)
figure;zplane(r,p)

%Impulse with sine as input to system

t = 0:0.0001:50;
u = sin(2*pi*3*t);
x = lsim(sys,u,t);   % u,t define the input signal
lx = length(x)-1 %Reduce array lenght by one
x = x(1:lx);
AvgArea = 0;

%for index = 1:1000
%   y = 0;
    y = awgn(x, 20); % Add white noise
    Area = trapz(y)
%    AvgArea = Area+AvgArea
%end
%AvgArea = AvgArea/index

figure;plot(y);grid; % plot system 
title('Simulated system');

Take the FFT of x
T=1/(1*10^4);
N=10000
N1=20000;
yfft=(1/N1)*fft(x(1:N1));
figure;vline_plot_fft(yfft,N1/2,N1*T);
title('FFT, underdamped simulated system');


