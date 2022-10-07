function [tfr] = tfrstft_down(x,Nfft,h,Lh,downsamp)
 
 %x        : signal
 %N        : number of frequency bins
 %cas      : if 1, no assumption on h except it does not vanish at 0 
 %           if 2, use a filter with unit energy 
 %           if 3, use a filter with unit mean 
 %h        : the filter h used
 %Lh       : the filter is of length 2Lh+1
 %downsamp : the downsampling value between 1 and Lh.
 %shift    : the shift parameter, the value used for reconstruction are
 %           m*downsamp+shift (if downsamp = 1, shift =0)
 
 %tfr      : short time Fourier transform
 %norm2h   : the L2 norm of the filter on it support
 
x = x(:);
L = length(x);

if mod(length(x), downsamp) ~= 0
    error("downsamp doit diviser la taille de x");
end

% t = 1+Lh:downsamp:L-Lh; %the time instant, we consider the time instant shitfed by a factor shift.
t = 1:downsamp:L;
Lt = length(t);

tfr = zeros(Nfft,Lt) ;
trans  = zeros(1,Lt);

for n=1:length(t)
    tau = -min([Lh,t(n)-1]):min([Lh,L-t(n)]); 
    tfr(1:length(tau),n) = x(t(n)+tau,1).*h(Lh+1+tau);
    trans(n)  = tau(1);
end

% tfr=fft(tfr,Nfft); 
tfr = tfr.*exp(-2*1i*pi*(0:Nfft-1)'/Nfft*trans);

end 
