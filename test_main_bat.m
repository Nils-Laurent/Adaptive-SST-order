close all
addpath('./common-tf-code');

%bat signal  
load -ascii batsig.txt
s = batsig;
s = s(145:end);
s = s(:).';
% s = [s fliplr(s)];
% s = s(1:512);

s = hilbert(s);

% sigma_w = 0.13;
sigma_w = 0.13;
% Lg = 65;
% clwin = 10;

% return;

s_ref = s;
IFs = [0, 512];
Amp = ones(size(s));
s_name = 'bat';
NR = 3;

s_all = s;
Lx = length(s_all);
[STFT, ~] = sstn(s_all, 10^(-6), sigma_w);
N_f = size(STFT, 1);
Nfft = 2*N_f;

Tx = (0:(Lx-1))/Lx;
F_vec = (0:N_f-1)*Lx/Nfft;

xi0 = min(IFs) - 100;
xi1 = max(IFs) + 100;
F2 = F_vec.*(F_vec > xi0).*(F_vec < xi1);

small_TFRsc(Tx, F_vec, abs(STFT));
return;
gen_fig_TFR(Tx, F2, STFT, s_name);
% return;

%% parameters
% IMPORTANT : L_rep > 2
L_rep = 100;
SNR_vec = [10, 20, 30, 40, 50];

% LD = length(d_vec);
%% window range
[g, Lh] = create_gaussian_window(Lx, Nfft, sigma_w, 10^(-3));
Lh2 = Lh*2;
Xw = Lh2+1:Lx-Lh2;

%% energy without noise
s_modes = zeros(Lx, NR);
sv_modes = zeros(4, Lx, NR);
for RA=1:NR
    % EV_i : 4, D, Lx
    % sv_i : 4, D, Lx
    [EV_i, smax_i, sv_i, pv_i] =...
        main(s_all, s_all, inf, Lx, Nfft, sigma_w, [0],NR,RA);

    gen_fig_ridge_energy(Tx(Xw), Amp(Xw), squeeze(EV_i(:, 1, Xw)), [s_name, '_r1']);
    
    s_modes(:, RA) = smax_i;
    sv_modes(:, :, RA) = squeeze(sv_i(:, :, :));
end

SR_ord = sum(sv_modes, 3);
SR_max = sum(s_modes, 2);
% [STFT_SR, ~] = sstn(SR_ord(1, :), 10^(-6), sigma_w)
% % gen_fig_TFR(Tx, F2, STFT_SR, [s_name, '_1']);
% [STFT_SR, ~] = sstn(SR_ord(1, :), 10^(-6), sigma_w)
% % gen_fig_TFR(Tx, F2, STFT_SR, [s_name, '_2']);
% [STFT_SR, ~] = sstn(SR_ord(1, :), 10^(-6), sigma_w)
% % gen_fig_TFR(Tx, F2, STFT_SR, [s_name, '_3']);
% [STFT_SR, ~] = sstn(SR_ord(1, :), 10^(-6), sigma_w)
% % gen_fig_TFR(Tx, F2, STFT_SR, [s_name, '_4']);

[STFT_SR, ~] = sstn(SR_max, 10^(-6), sigma_w);
gen_fig_TFR(Tx, F2, STFT_SR, [s_name, '_SR']);

snr(s_ref, s_ref(:) - SR_ord(1, :).')
snr(s_ref, s_ref(:) - SR_ord(2, :).')
snr(s_ref, s_ref(:) - SR_ord(3, :).')
snr(s_ref, s_ref(:) - SR_ord(4, :).')
snr(s_ref, s_ref(:) - SR_max(:))
