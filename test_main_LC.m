%% 

close all;
addpath('./common-tf-code');

Lx = 1024;
Nfft = nan;

Tx = (0:(Lx - 1))/Lx;

%% sig def
xi1 = 50;
xi2 = 350; % 50, 250
IP1 = xi1*Tx + xi2*Tx.^2/2;
s1 = exp(2i*pi*IP1);

IF1 = xi1 + xi2*Tx;
% global IF_tmp;
% IF_tmp = IF1;
IF1_g = round(IF1*Nfft/Lx) + 1;
Amp = ones(size(s1));

%% TF
sigma_w = 0.04;
s_name = 'LC';
% restriction sur [O.4, O.6] secondes

main_test(s1,s1,IF1,Amp,sigma_w,s_name);
