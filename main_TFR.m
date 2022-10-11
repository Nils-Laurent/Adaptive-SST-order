function [TFR, energy_vec, sr, s_vec, p_vec] =...
    main_TFR(s_in,sn,snr_in,Lx,N_f,sigma_w,d_vec,NR,RA)
%% main function
% ============== input
% s_in : vector of all modes
% sn : noisy signal
% snr_in : set of all considered SNRs
% Lx : length of the signal
% N_f : nb of frequency bins
% sigma_w : parameter for the gaussian window
% d_vec : range parameter for SST reconstruction
% NR : number of ridge
% RA : ridge to consider
% ============== output
% TFR : time frequency representation corresponding to the adaptive
% technique.
%
% energy_vec : energy concentration depending on the order
% s_vec : reconstruction of RA at all orders
% sr : reconstruction for the mode RA
% p_vec : chosen order for the reconstruction

LD = length(d_vec);
s_ref = s_in;
s_in = sigmerge(s_ref(:), sn(:), snr_in);
gamma = 10^(-6);

[STFT, t1, t2, t3, t4, om1, om2, om3, om4, ~] =...
    sstn_var(s_in, gamma, sigma_w,1:Lx,1:Lx);
% Nfft = Lx;
% Tx = (0:(Lx-1))/Lx;
% F_vec = (0:(Nfft-1))*Lx/Nfft;
% TFRsc(Tx, F_vec(1:N_f), abs(STFT));

% [g, Lh] = create_gaussian_window(Lx, Nfft, sigma_w, 10^(-3));

s_rec = zeros(1, Lx);
for n=1:Lx
    s_rec(n) = sigma_w*sum(STFT(:, n));
end
% figure;
% hold on;
% %plot(real(s_ref)./real(s_rec))
% %pause
% plot(real(s_rec), '-');
% plot(real(s_ref), '--');
% hold off;
% pause;

t_vec = zeros([4, size(t1)]);
t_vec(1, :, :, :) = t1;
t_vec(2, :, :, :) = t2;
t_vec(3, :, :, :) = t3;
t_vec(4, :, :, :) = t4;

energy_vec = zeros(4, LD, Lx);
s_vec = zeros(4, LD, Lx);
c_vec = zeros(4, Lx);
i0_vec = zeros(4, Lx);
for p=1:4
    t_p = squeeze(t_vec(p, :, :, :));
    
    % clwin = 55 for synthetic signals
    % clwin = 10 for bat signal
    cv = exridge_mult(t_p(:, :, 2), NR, 0, 0, 2);
    c = cv(RA, :);
    c_vec(p, :) = c;
%     TFRsc(abs(t_p(:, :, 2))); hold on; plot(cv.');

    for id=1:LD
        d = d_vec(id);
        for n=1:Lx
            k0 = max(1, c(n) - d);
            k1 = min(N_f, c(n) + d);
            S0_d = t_p(k0:k1, n, :);
            [v0, i0] = max(abs(sum(S0_d, 1)));
            i0_vec(p, n) = i0;
            energy_vec(p, id, n) = sigma_w*v0;
            s_vec(p, id, n) = sigma_w*sum(S0_d(:, 1, i0));
        end
    end
end

TFR = zeros(size(STFT));

[~, id_min] = min(d_vec);
p_vec = zeros(LD, Lx, 4);
sr = zeros(LD, Lx);
for id=1:LD
    for n=1:Lx
        [~, p0] = max(energy_vec(:, id_min, n));
        p_vec(id, n, p0) = 1;
        sr(id, n) = s_vec(p0, id, n);
        TFR(c_vec(p0, n), n) = sigma_w*t_vec(p0, c_vec(p0, n), n, i0_vec(p0, n));
%         TFR(c_vec(p0, n), n) = 1;
    end
end

% figure;
% hold on;
% plot(real(s_ref), '-');
% % plot(squeeze(real(s_vec(1, 1, :))), '--');
% plot(squeeze(real(s_vec(2, 1, :))), '--');
% plot(squeeze(real(s_vec(3, 1, :))), '-.');
% plot(squeeze(real(s_vec(4, 1, :))), '-r');
% snr(s_ref.', s_ref.' - squeeze(s_vec(4, 1, :)))
% hold off;
% snr(s_ref.', s_ref.' - squeeze(s_vec(4, 1, :)))

% figure;
% hold on;
% plot(squeeze(imag(s_vec(1, 1, :))), ':');
% plot(squeeze(imag(s_vec(2, 1, :))), '--');
% plot(squeeze(imag(s_vec(3, 1, :))), '-.');
% plot(squeeze(imag(s_vec(4, 1, :))), '-');
% hold off;
% pause;

% p_vec = p_vec/Lx;

% figure;
% hold on;
% plot(energy_vec(1, :), ':', 'DisplayName', 'Ordre 1');
% plot(energy_vec(2, :), '--', 'DisplayName', 'Ordre 2');
% plot(energy_vec(3, :), '-.', 'DisplayName', 'Ordre 3');
% plot(energy_vec(4, :), '-', 'DisplayName', 'Ordre 4');
% hold off;

end

