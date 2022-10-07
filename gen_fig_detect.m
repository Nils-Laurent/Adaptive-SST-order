function [] = gen_fig_detect(prefix, omega2_r, IF_m, X_inter,...
    var_up2, var_down2, Int_X, Tx, STFT)


I_norm = Int_X/norm(Int_X, 2);
norm_var = (norm(var_up2, 2) + norm(var_down2, 2));
varU_norm = var_up2/norm_var;
varD_norm = var_down2/norm_var;

T_ = Tx > 0;

c_int = omega2_r - IF_m;

Int_sup = c_int(T_);
Int_sup(~X_inter(T_)) = nan;
Int_low = c_int(T_);
Int_low(X_inter(T_)) = nan;
small_figplot('Time', 'Normalized');
hold on;
plot(Tx(T_), Int_sup, 'r--', 'DisplayName', "$\widehat{\omega}^{[2]} - \phi_1'$");
plot(Tx(T_), Int_low, 'k-', 'DisplayName', "$\widehat{\omega}^{[2]} - \phi_1'$");
hold off;
small_legend('northeast');

c_int = Int_X;

Int_sup = c_int(T_);
Int_sup(~X_inter(T_)) = nan;
Int_low = c_int(T_);
Int_low(X_inter(T_)) = nan;
small_figplot('time', 'normalized');
hold on;
plot(Tx(T_), Int_sup, 'r--', 'DisplayName', "$\mathcal{L}_{f_1, f_2}$");
plot(Tx(T_), Int_low, 'k-', 'DisplayName', "$\mathcal{L}_{f_1, f_2}$");
hold off;
small_legend('northeast');

% Cmp = STFT;
% Cmp(:, X_inter) = 0;
% TFRsc(abs(Cmp));

end

