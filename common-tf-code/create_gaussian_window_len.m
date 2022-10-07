function [g, Lh, sigma_w] = create_gaussian_window_len(Fs, Nfft, Lw_i, prec)

% prec = 10^(-3);

Lh = floor(Lw_i/2);
Lw = 2*Lh + 1;
sigma_w = (Lh - 1)/(Fs*sqrt(-log(prec)/pi))

t=(1:Lw)'/Fs - (Lh + 1)/Fs;
g = exp(-(t/sigma_w).^2 * pi);

if 2*Lh + 1 > Nfft
    fprintf("[Warning] 2*Lh+1 > Nfft, simga_w = %f\n", sigma_w);
end


[~, Lh2] = create_gaussian_window(Fs, Nfft, sigma_w, prec);
if Lh ~= Lh2
    error("Lh ~= Lh2");
end

end