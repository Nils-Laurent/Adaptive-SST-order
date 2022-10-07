function [] = ...
    gen_fig_var(prefix, c, var_up2, var_down2, ...
    Int_X, F_vec, Tx, TFR_X, STFT_R)

Lx = length(Tx);
Nfft = size(TFR_X, 1);
c_f = Lx/Nfft*(c-1);
I_norm = Int_X/norm(Int_X, 1);
norm_var = (norm(var_up2, 1) + norm(var_down2, 1));
varU_norm = var_up2/norm_var;
varD_norm = var_down2/norm_var;

F_ = F_vec > 0;
T_ = Tx > 0;

small_TFRsc(Tx(T_), F_vec(F_), abs(STFT_R(F_, T_)));
hold on;
plot(Tx(T_), c_f(T_), 'r-');
hold off;
write(['fig_' prefix '_TFR']);

small_TFRsc(Tx(T_), F_vec(F_), TFR_X(F_, T_));
hold on;
plot(Tx(T_), c_f(T_), 'r-');
hold off;
write(['fig_' prefix '_TFR_interf']);

small_figplot('Time', 'Normalized');
hold on;
plot(Tx(T_), I_norm(T_), 'k--', 'DisplayName', '$\mathcal{L}_{f_1, f_2}$');
plot(Tx(T_), varU_norm(T_), 'r-', 'DisplayName', '$\Lambda_f^{\psi +}$');
plot(Tx(T_), varD_norm(T_), 'b-', 'DisplayName', '$\Lambda_f^{\psi -}$');
hold off;
small_legend('northeast');
write(['fig_' prefix '_var']);

end

