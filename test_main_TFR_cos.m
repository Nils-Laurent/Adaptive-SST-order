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

NR = 1;
RA = 1;
s_all = s1;
s_ref = s1;
IFs = IF1;

%% test main_TFR
Lx = length(s_all);
[STFT, ~] = sstn(s_all, 10^(-6), sigma_w);
N_f = size(STFT, 1);
Nfft = 2*N_f;

%% parameters
% SST reconstruction parameter (nb of coef. around the ridge)
d_vec = 0;

%% energy without noise
% EV : 4, D, Lx
[TFR_adaptive, ~] =...
    main_TFR(s_all, s_all, inf, Lx, Nfft, sigma_w, d_vec,NR,RA);

TFRsc(abs(TFR_adaptive));
TFRsc(log(abs(TFR_adaptive)));
