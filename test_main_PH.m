%% 

close all;
addpath('./common-tf-code');

Lx = 1024;
Nfft = nan;

Tx = (0:(Lx - 1))/Lx;

%% sig def
xi1 = 200;
xi2 = 0;
IP1 = xi1*Tx + xi2*Tx.^2/2;
% A1 = 5*ones(1, Lx);
s1 = exp(2i*pi*IP1);

IF1 = xi1 + xi2*Tx;
% IF1_g = round(IF1*Nfft/Lx) + 1;
Amp = ones(size(s1));

%% TF
sigma_w = 0.04;
s_name = 'PH';

main_test(s1,s1,IF1,Amp,sigma_w,s_name);