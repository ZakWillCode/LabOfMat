function [v]= nonideal()
%This function is used to show the non ideal frequency reponse curve to an
%operational amplifier, this uses the single pole model
%Set values for components
R=1000;C=1e-8;K=95;
f=logspace(-1,6,10000);
w=2*pi*f;
nideal=K;dideal=[C*R*C*R 5*C*R  K+5];
hi=polyval(nideal,j*w)./polyval(dideal,j*w);
%fu=2000e6;omega_u=2*pi*fu;fb=0;omega_b=2*pi*fb;Ro=30;

%Establish frequency response points 
fu=25e6;omega_u=2*pi*fu;fb=fu/(10^5.5);omega_b=2*pi*fb;Ro=0.2*fu/100e3;

%determine transfer function of non ideal opamp
n2=C*K*R*Ro+C*R*Ro;
n1=C*K*R*Ro*omega_b+C*R*Ro*omega_b+K*Ro+3*Ro;
n0=-K*R*omega_u+K*Ro*omega_b+3*Ro*omega_b;
n=[n2,n1,n0];
d3=C^2*K*R^2*Ro+2*C^2*R^2*Ro+C^2*K*R^3+C^2*R^3;
d2=C^2*R^3*omega_u+C^2*K*R^2*Ro*omega_b+2*C^2*R^2*Ro*omega_b+C^2*K*R^3*omega_b+C^2*R^3*omega_b+3*C*K*R*Ro+8*C*R*Ro+4*C*K*R^2+5*C*R^2;
d1=5*C*R^2*omega_u+3*C*K*R*Ro*omega_b+8*C*R*Ro*omega_b+4*C*K*R^2*omega_b+5*C*R^2*omega_b+K*Ro+3*Ro+2*K*R+5*R;
d0=K*R*omega_u+5*R*omega_u+K*Ro*omega_b+3*Ro*omega_b+2*K*R*omega_b+5*R*omega_b;
d=[d3,d2,d1,d0];

%plotting output of data
v=roots(d);
h=polyval(n,j*w)./polyval(d,j*w);
semilogx(f,20*log10(abs(hi)),f,20*log10(abs(h)));grid;