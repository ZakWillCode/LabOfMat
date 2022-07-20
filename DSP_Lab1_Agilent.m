clear all; close all;
%Import data from excel
[d,s] = xlsread('AGILENT_Square_data.xlsx');
v = d(:,1);         
T=1/400000;

%Determine window and number of samples
N=1600;
t=[0:(N-1)]*T;
N1=1600;

%Plot time domain data
figure;plot(v);

%Get FFT
yfft=(1/N1)*fft(v(1:N1));

%Compare to square wave 
f = 12.5;
Fs = 5000;
N2 = 10000;
T2 = 1/Fs;
t2=[0:(N2-1)]*T2;
s = 2*square(2*pi*f*t2);

sfft =(1/N2)*fft(s(1:N2));
figure;vline_plot_fft(sfft,N2/2,N2*T);

%Plot data
figure;vline_plot_fft(yfft,N1/2,N1*T);
title('FFT, Agilent');