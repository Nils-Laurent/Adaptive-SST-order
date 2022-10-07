close all;
addpath('./common-tf-code');

%% def MCS
Lx = 1024;
fs = 0:Lx/2;
gamma = 0;
% sigma_w = 0.05;
sigma_w = 0.03;

Tx = (0:Lx-1)/Lx;

% Choice of time and frequency bins
ft =1:Lx/2;bt=1:Lx;

%% Signal definition
a1 = exp(2*(1-Tx).^3 + 1.5*Tx.^4);
% a2 = ones(size(a1));
a2 = 1+ 5*Tx.^3 + 7*(1-Tx).^6;
% a1 = Tx.^0;
% a2 = a1;

phi1 = 50*Tx+30*Tx.^3-20*(1-Tx).^4;
phi2 = 340*Tx-2.*exp(-2*(Tx-0.2)).*sin(14*pi.*(Tx-0.2));

IF1 = 50+90*Tx.^2+80*(1-Tx).^3; 
IF2 = 340+4*exp(-2*(Tx-0.2)).*sin(14*pi.*(Tx-0.2))-28*pi.*exp(-2*(Tx-0.2)).*cos(14*pi.*(Tx-0.2)); 

s1 = a1.*exp(2*pi*1i*(phi1));
s2 = a2.*exp(2*pi*1i*(phi2));

s = s1+s2;
 
s_name = 'MCS2';
NR = 2;
RA = 1;
main_test(s, s1, [IF1, IF2], a1, sigma_w,s_name,NR,RA);
RA = 2;
main_test(s, s2, [IF1, IF2], a2, sigma_w,s_name,NR,RA);
