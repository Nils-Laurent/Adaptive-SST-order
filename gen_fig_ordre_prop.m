function [] = gen_fig_ordre_prop(snr_vec, prop, s_name)
% prop : SNR, L_rep, Lx, 4

p_vec = mean(prop, 3); % average in time
p_vec = mean(p_vec, 2); % smooth using NR

small_figplot('SNR in', 'Proportion');
hold on;
plot(snr_vec, p_vec(:, 1), ':', 'DisplayName', '$p_1$');
plot(snr_vec, p_vec(:, 2), '-.', 'DisplayName', '$p_2$');
plot(snr_vec, p_vec(:, 3), '--', 'DisplayName', '$p_3$');
plot(snr_vec, p_vec(:, 4), 'DisplayName', '$p_4$');
hold off;
small_legend('Best');

f_name = ['fig_prop_SNR_' s_name];
% title(f_name);
write(f_name);
end