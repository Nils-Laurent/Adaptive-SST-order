function [] = gen_fig_q95(Tx, e_max, q95, m_amp, s_name)

c2 = [0.9290 0.6940 0.1250];
c2 = c2 + 1/2*([1, 1, 1] - c2);
% c3 = [0.4940 0.1840 0.5560];
cg50 = [0.3, 0.3, 0.3];
c3 = cg50;
c4 = [0.6350 0.0780 0.1840];
c4 = c4 + 1/2*([1, 0, 0] - c4);

small_figplot('Time', 'Energy');
hold on;
hdlY(1) = plot(Tx, q95(2, :), '-',...
    'Color', c2,...
    'DisplayName', '$N=2$');
hdlY(2) = plot(Tx, q95(3, :), '-',...
    'Color', c3,...
    'DisplayName', '$N=3$');
hdlY(3) = plot(Tx, q95(4, :), '-',...
    'Color', c4,...
    'DisplayName', '$N=4$');
hdlY(4) = plot(Tx, m_amp, 'k--',...
    'DisplayName', '$A$');
hold off;
xlim([min(Tx) max(Tx)]);
YL_ = ylim;
YL_(2) = YL_(2) + (YL_(2) - YL_(1))*0.075;
ylim(YL_);

% lgd = legend;
% lgd.FontSize = 20;
% set(lgd, 'Interpreter', 'latex', 'Location', 'Northeast',...
%     'Orientation', 'horizontal');

%% ERROR in the paper: normaly 2 <= N <= 4
% key{1} = '$N=1$';%2
% key{2} = '$N=2$';%3
% key{3} = '$N=3$';%4
%% FIX
key{1} = '$N=2$';%2
key{2} = '$N=3$';%3
key{3} = '$N=4$';%4
%%
key{4} = '$A$';
% gridLegend(hdlY, 2, key, 'Location', 'Northwest');

gridLegend(hdlY, 2, key, 'Location', 'north',...
    'Interpreter', 'latex',...
    'Fontsize', 24,...
    'Orientation', 'Horizontal');

f_name = ['fig_ordre_q95_' s_name];
write(f_name);
return;


% small_figplot('SNR in', 'SNR out');
% hold on;
% plot(snr_vec, e_max(2, :), 'b-',...
%     'MarkerSize', 10,...
%     'DisplayName', 'q95 $i=2$');
% plot(snr_vec, e_max(3, :), 'g-',...
%     'MarkerSize', 10,...
%     'DisplayName', 'q95 $i=3$');
% plot(snr_vec, e_max(4, :), 'r-',...
%     'MarkerSize', 10,...
%     'DisplayName', 'q95 $i=4$');
% hold off;
% small_legend('Best');
% 
% f_name = ['fig_ordre_e_max_' s_name];
% write(f_name);
end