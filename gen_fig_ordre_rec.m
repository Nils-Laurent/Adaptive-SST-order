function [] = gen_fig_ordre_rec(snr_vec, rec_max, rec_order, s_name)
% rec_max : SNR, L_rep
% rec_order : SNR, L_rep, 4


numberOfDataSets = 5;
S1 = winter(numberOfDataSets);
newDefaultColors = S1;
% S2 = autumn(numberOfDataSets);
% newDefaultColors = [S1; S2];


Y_max = mean(rec_max, 2);
Y_ord = mean(rec_order, 2);
small_figplot('SNR in', 'SNR out');
set(gca, 'ColorOrder', newDefaultColors, 'NextPlot', 'replacechildren');
hold on;
% plot(snr_vec, Y_ord(:, 1), '--',...
%     'MarkerSize', 10,...
%     'DisplayName', 'SNRout $i=1$');
plot(snr_vec, Y_ord(:, 2), '-',...
    'MarkerSize', 10,...
    'DisplayName', '$N=2$');
plot(snr_vec, Y_ord(:, 3), '-o',...
    'MarkerSize', 10,...
    'DisplayName', '$N=3$');
plot(snr_vec, Y_ord(:, 4), '-s',...
    'MarkerSize', 10,...
    'DisplayName', '$N=4$');
plot(snr_vec, Y_max, '-*',...
    'MarkerSize', 10,...
    'DisplayName', '$\mathcal{N}$');
hold off;
small_legend('Best');

f_name = ['fig_ordre_SNR_' s_name];
% title(f_name);
write(f_name);

end