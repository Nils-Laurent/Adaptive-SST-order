function [gamma] = noise_TH(STFT)
    gamma = median(abs(real(STFT(:))))/0.6745;
end