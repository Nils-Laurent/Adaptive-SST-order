function [] = gen_fig_ridge_energy(Tx, Amp, EV, s_name)
% RMAP = 3;
% S1 = winter(RMAP);
% S2 = autumn(RMAP);
% NC = 2;
% newDefaultColors = [S1(1:NC, :); S2(1:NC, :)];
% c1 = [0.1, 0.1, 0.4];
c2 = [0.9290 0.6940 0.1250];
c2 = c2 + 1/2*([1, 1, 1] - c2);
% c3 = [0.4940 0.1840 0.5560];
cg50 = [0.3, 0.3, 0.3];
c3 = cg50;
c4 = [0.6350 0.0780 0.1840];
c4 = c4 + 1/2*([1, 0, 0] - c4);


% c_ord = [0.3010 0.7450 0.9330];
% c_amp = [0.6350 0.0780 0.1840];
c_amp = cg50;

% set(gca, 'ColorOrder', newDefaultColors, 'NextPlot', 'replacechildren');
% plot(Tx, EV(1, :), 'k-',...
%     'DisplayName', '$E_1$');

small_figplot('Time', 'Energy');
hold on;
plot(Tx, EV(2, :), '-',...
    'Color', c2,...
    'DisplayName', '$E_2$');
plot(Tx, EV(3, :), '-',...
    'Color', c3,...
    'DisplayName', '$E_3$');
plot(Tx, EV(4, :), '-',...
    'Color', c4,...
    'DisplayName', '$E_4$');
plot(Tx, Amp, 'k--',...
    'DisplayName', '$A$');
hold off;
small_legend('southeast');
xlim([min(Tx), max(Tx)]);
ytickformat('%.2f');

f_name = ['fig_energy_' s_name];
write(f_name);
end

