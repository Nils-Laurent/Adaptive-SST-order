%% 

close all;
addpath('./common-tf-code');

%% sig def
% Lx = 400;
% Nfft = 20*Lx;
Lx = 1024;
% Nfft = 512;
Nfft = nan;

Tx = (0:(Lx - 1))/Lx;

k = 1;
Y_ = 2*k*pi;
Z_ = pi/2;
phi1 = 100*Tx + 50/Y_*cos(Y_*Tx + Z_);
IF1 = 100 -50*sin(Y_*Tx + Z_);
% IF1g = round(IF1*Nfft/Lx) + 1;
CR1 = -50*Y_*cos(Y_*Tx + Z_);

s1 = exp(2i*pi*phi1);
Amp = ones(size(s1));

%% TFR
sigma_w = 0.05;
s_name = 'cos';
% restriction sur [O.4, O.6] secondes

main_test(s1,s1,IF1,Amp,sigma_w,s_name);
