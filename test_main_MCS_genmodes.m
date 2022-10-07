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
a2 = ones(size(a1));
% a2 = 1+ 5*Tx.^3 + 7*(1-Tx).^6;
% a1 = Tx.^0;
% a2 = a1;

phi1 = 50*Tx+30*Tx.^3-20*(1-Tx).^4;
phi2 = 340*Tx-2.*exp(-2*(Tx-0.2)).*sin(10*pi.*(Tx-0.2));

IF1 = 50+90*Tx.^2+80*(1-Tx).^3; 
IF2 = 340+4*exp(-2*(Tx-0.2)).*sin(14*pi.*(Tx-0.2))-28*pi.*exp(-2*(Tx-0.2)).*cos(14*pi.*(Tx-0.2)); 

s1 = a1.*exp(2*pi*1i*(phi1));
s2 = a2.*exp(2*pi*1i*(phi2));


Lx = length(s1);
[STFT, ~] = sstn(s1, 10^(-6), sigma_w);
N_f = size(STFT, 1);
Nfft = 2*N_f;

Tx = (0:(Lx-1))/Lx;
F_vec = (0:N_f-1)*Lx/Nfft;

xi0 = min(IF1) - 100;
xi1 = max(IF1) + 100;
F2 = F_vec.*(F_vec > xi0).*(F_vec < xi1);

gen_fig_TFR(Tx, F2, STFT, 'MCS_mode1');

[STFT, ~] = sstn(s2, 10^(-6), sigma_w);
xi0 = min(IF2) - 100;
xi1 = max(IF2) + 100;
F2 = F_vec.*(F_vec > xi0).*(F_vec < xi1);
gen_fig_TFR(Tx, F2, STFT, 'MCS_mode2');
