function [] = gen_fig_TFR(Tx, Freq, STFT, s_name)

F_ = Freq > 0;
small_TFRsc(Tx, Freq(F_), abs(STFT(F_, :)));
write(['fig_TFR_' s_name]);

end

