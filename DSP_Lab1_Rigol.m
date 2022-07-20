% clear all; close all;
%Import data from excel
[d,s] = xlsread('RIGOL_data.xlsx');
v = d(:,1);         
T=1/(5*10^5);

%Determine window and number of samples
N=1000;
t=[0:(N-1)]*T;
N1=1000;

%Plot time domain data
figure;plot(v);

%Get FFT
yfft=(1/N1)*fft(v(1:N1));

Compare to square wave 
f = 1625;
Fs = 1000;
N2 = 64;
T2 = 1/Fs;
t2=[0:(N2-1)]*T2;
s = sin(2*pi*f*t2);
figure;plot(s);

sfft =(1/N2)*fft(s(1:N2));
figure;vline_plot_fft(sfft,N2/2,N2*T2);

find the difference between each plot
diffRigol = sfft - yfft;
trapz(diffRigol);



figure;vline_plot_fft(yfft,N1/2,N1*T);
title('FFT, Rigol');