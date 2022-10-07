function [] = gen_fig_ridge_e_mult(Tx, Amp, EV, s_name)
% RMAP = 3;
% S1 = winter(RMAP);
% S2 = autumn(RMAP);
% NC = 2;
% newDefaultColors = [S1(1:NC, :); S2(1:NC, :)];
% c1 = [0.1, 0.1, 0.4];
% c2 = [0.4940 0.1840 0.5560];
% c3 = [0.4660 0.6740 0.1880];
% c4 = [0.6350 0.0780 0.1840];

cg50 = [0.3, 0.3, 0.3];

c_ord = [0.3010 0.7450 0.9330];
% c_amp = [0.6350 0.0780 0.1840];
c_amp = cg50;

% set(gca, 'ColorOrder', newDefaultColors, 'NextPlot', 'replacechildren');
% plot(Tx, EV(1, :), 'k-',...
%     'DisplayName', '$E_1$');

%% fig E2

small_figplot('Time', 'Energy');
hold on;
plot(Tx, EV(2, :), '-',...
    'Color', c_ord,...
    'DisplayName', '$E_2$');
plot(Tx, Amp, '--',...
    'Color', c_amp,...
    'DisplayName', '$A$');
hold off;
small_legend('southeast');
xlim([min(Tx), max(Tx)]);
ytickformat('%.2f');

f_name = ['fig_energy_' s_name '_E2'];
write(f_name);

%% fig E3
small_figplot('Time', 'Energy');
hold on;
plot(Tx, EV(3, :), '-',...
    'Color', c_ord,...
    'DisplayName', '$E_3$');
plot(Tx, Amp, '--',...
    'Color', c_amp,...
    'DisplayName', '$A$');
hold off;
small_legend('southeast');
xlim([min(Tx), max(Tx)]);
ytickformat('%.2f');

f_name = ['fig_energy_' s_name '_E3'];
write(f_name);

%% fig E4
small_figplot('Time', 'Energy');
hold on;
plot(Tx, EV(4, :), '-',...
    'Color', c_ord,...
    'DisplayName', '$E_4$');
plot(Tx, Amp, '--',...
    'Color', c_amp,...
    'DisplayName', '$A$');
hold off;
small_legend('southeast');
xlim([min(Tx), max(Tx)]);
ytickformat('%.2f');

f_name = ['fig_energy_' s_name '_E4'];
write(f_name);
end

