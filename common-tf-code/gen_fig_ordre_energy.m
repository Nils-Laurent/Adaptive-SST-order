function [] = gen_fig_ordre_snr(snr_vec,energy_im, s_name)
%% variance en fonction du SNR sur N réalisations

% Y = log(var_im);
% small_figplot('SNR in', 'log frequency');
% hold on;
% boxplot(squeeze(Y(:, :, 1)).', snr_vec(1:5), 'Color', [0, 0, 0]);
% plot(median(Y(:, :, 1), 2), 'k--', "DisplayName", "$m$");
% hold off;

Y1 = log(mean(energy_im, 2));
small_figplot('SNR in', 'SST energy');
hold on;
plot(snr_vec, Y1(:, 1), ':', 'DisplayName', '$E^a_1$');
plot(snr_vec, Y1(:, 2), '-.', 'DisplayName', '$E^a_2$');
plot(snr_vec, Y1(:, 3), '--', 'DisplayName', '$E^a_3$');
plot(snr_vec, Y1(:, 4), 'DisplayName', '$E^a_4$');
hold off;
small_legend('northeast');
write(['fig_ordre_a_' s_name]);
% title("mean");

Y2 = log(median(energy_im, 2));
small_figplot('SNR in', 'SST energy');
hold on;
plot(snr_vec, Y2(:, 1), ':', 'DisplayName', '$E^d_1$');
plot(snr_vec, Y2(:, 2), '-.', 'DisplayName', '$E^d_2$');
plot(snr_vec, Y2(:, 3), '--', 'DisplayName', '$E^d_3$');
plot(snr_vec, Y2(:, 4), 'DisplayName', '$E^d_4$');
hold off;
small_legend('northeast');
write(['fig_ordre_d_' s_name]);
% title("median");
end