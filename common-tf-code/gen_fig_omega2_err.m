function [] = gen_fig_omega2_err(prefix, c, omega2, IF_m, Tx, Lx, Nfft)


T_ = Tx > 0;
o22 = omega2(:).';
small_figplot('Time', 'Frequency');
hold on;
plot(Tx(T_), o22(T_) - IF_m(T_), 'r-', 'DisplayName', "$\widehat{\omega}^{[2]} - \phi_1'$");
hold off;
small_legend('northeast');
write(['fig_' prefix '_IF_err']);

end

