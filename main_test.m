function [] = main_test(s_all,s_ref,IFs,Amp,sigma_w,s_name,NR,RA)

if nargin == 6
    NR = 1;
    RA = 1;
end

s_name_all = [s_name sprintf('_rALL')];
s_name = [s_name sprintf('_r%u', RA)];

Lx = length(s_all);
[STFT, ~] = sstn(s_all, 10^(-6), sigma_w);
[STFT_REF, ~] = sstn(s_ref, 10^(-6), sigma_w);
N_f = size(STFT, 1);
Nfft = 2*N_f;

Tx = (0:(Lx-1))/Lx;
F_vec = (0:N_f-1)*Lx/Nfft;

xi0 = min(IFs) - 100;
xi1 = max(IFs) + 100;
F2 = F_vec.*(F_vec > xi0).*(F_vec < xi1);


%% parameters
% d_vec = [0, 1];
d_vec = 0;
% IMPORTANT : L_rep > 2
L_rep = 100;
SNR_vec = [10, 20, 30, 40, 50];
% SNR_vec = [20, 30];
% L_rep = 2;

LD = length(d_vec);
%% window range
[g, Lh] = create_gaussian_window(Lx, Nfft, sigma_w, 10^(-3));
Lh2 = Lh*2;
Xw = Lh2+1:Lx-Lh2;
gen_fig_TFR(Tx(Xw), F2, STFT, s_name_all);
gen_fig_TFR(Tx(Xw), F2, STFT_REF, s_name);
% return;

%% energy without noise
% EV : 4, D, Lx
[EV, smax, sv, pv] =...
    main(s_all, s_all, inf, Lx, Nfft, sigma_w, d_vec,NR,RA);

for id=1:LD
    d = d_vec(id);
    if s_name == "MCS_r2"
        gen_fig_ridge_e_mult(Tx(Xw), Amp(Xw), squeeze(EV(:, id, Xw)), [s_name sprintf('_d%u', d)]);
    else
        gen_fig_ridge_energy(Tx(Xw), Amp(Xw), squeeze(EV(:, id, Xw)), [s_name sprintf('_d%u', d)]);
    end
end


% return;

%% noise parameters

L_SNR = length(SNR_vec);

%% noisy simulations

% From main
% EV : 4, LD, Lx
% sv : 4, LD, Lx
% sr : LD, Lx
% pv : LD, Lx, 4

% data_energy = zeros(L_SNR, L_rep, 4, LD, Lx);
% data_rec_max = zeros(L_SNR, L_rep, LD);
% data_rec_o = zeros(L_SNR, L_rep, 4, LD);
% data_p_vec = zeros(L_SNR, L_rep, LD, Lx, 4);
% for n_snr = 1:L_SNR
%     snr_in = SNR_vec(n_snr);
%     for m=1:L_rep
%         sn = randn(1, Lx) + 1i*randn(1, Lx);
%         [EV, smax, sv, pv] =...
%             main(s_all, sn, snr_in, Lx, Nfft, sigma_w, d_vec,NR,RA);
%         data_energy(n_snr, m, :, :, :) = EV;%mean(EV(:, :, Xw), 3);
%         data_rec_max(n_snr, m, :) = snr_dim(s_ref(Xw), smax(:, Xw), 2);
%         data_rec_o(n_snr, m, :, :) = snr_dim(s_ref(Xw), sv(:, :, Xw), 3);
%         data_p_vec(n_snr, m, :, :, :) = pv;
%         fprintf("snr_in = %d, m = %u\n", snr_in, m);
%     end
% end
% save(['data_ordre_' s_name '.mat'],...
%     "data_energy", "data_rec_max", "data_rec_o", "data_p_vec");
load(['data_ordre_' s_name '.mat']);

tmp = data_energy(1, :, :, :, :);
de_10db = zeros(L_rep, 4, LD, Lx);
de_10db(:, :, :, :) = data_energy(1, :, :, :, :);

q95 = zeros(4, LD, Lx);
q95(:, :, :) = quantile(de_10db, .95, 1);
e_max = zeros(4, LD, Lx);
e_max(:, :, :) = max(de_10db, [], 1);

for id=1:LD
    d = d_vec(id);
    s_name_d = [s_name sprintf('_d%u', d)];

    gen_fig_ordre_rec(SNR_vec, squeeze(data_rec_max(:, :, id)),...
        squeeze(data_rec_o(:, :, :, id)),...
        s_name_d);
    
    gen_fig_q95(Tx(Xw), squeeze(e_max(:, id, Xw)), squeeze(q95(:, id, Xw)),...
        Amp(Xw), s_name_d);
end

end

