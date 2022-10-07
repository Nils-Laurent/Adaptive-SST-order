function [STFT,T1,T2, omega, omega2, QM, t] =...
    sst2_down_gauss(s,sigma_w,Lx,Nfft,R,w_prec,gamma)

%% sst2_down_gauss : computes the STFT of a signal and different versions of synchrosqueezing
%
% INPUTS:   
%   s: real or complex signal
%   sigma: the variance of the Gaussian window
%   Nfft: number of frequency bins
%   gamma: threshold on the STFT for reassignment
% OUTPUTS:   
%   STFT : the short-time Fourier transform
%   SST  : standard synchrosqueezing
%   VSST1: vertical second-order synchrosqueezing [1]
% REFERENCES
% [1] Behera, R., Meignen, S., & Oberlin, T. (2015). Theoretical Analysis
% of the Second-order Synchrosqueezing Transform. To appear in ACHA

if mod(length(s), R) ~= 0
    error("R doit diviser la taille de s");
end

s = s(:);
L = length(s);

%[g, Lh, sigma] = create_gaussian_window_len(Fs, Nfft, sigma_w);
[g, Lh] = create_gaussian_window(Lx, Nfft, sigma_w, w_prec);

% t   = (Lh+1):R:(L-Lh);
t = 1:R:L;
Nt   = length(t);

% Window definition

n0   = (0:2*Lh)'-Lh;
t0  = n0/Lx;
t0  = t0(:);
a   = pi/sigma_w^2;
gp  = -2*a*t0.*g;
gpp = (-2*a+4*a^2*t0.^2).*g; % g''

% Initialization
STFT  = zeros(Nfft,Nt);
T1   = zeros(Nfft,Nt);
T2 = zeros(Nfft,Nt);

omega  = zeros(Nfft,Nt);
t_gd     = zeros(Nfft,Nt);
omega2 = zeros(Nfft,Nt);
QM  = zeros(Nfft,Nt);

%% Computes STFT and reassignment operators

for n=1:Nt
 	% STFT, window g
 	tau = -min([Lh,t(n)-1]):min([Lh,L-t(n)]);
    vg = fft(s(t(n)+tau).*g(Lh+tau+1),Nfft);

	% Storing STFT
    STFT(:, n) = vg.*exp(-2*1i*pi*(0:Nfft-1)'/Nfft*tau(1))/Lx;
     
 	% STFT, window xg
 	vxg = fft(s(t(n)+tau).*(tau)'/Lx.*g(Lh+tau+1),Nfft);

    % operator Lx (dtau)
	
    t_gd(:,n) = vxg./vg;
 	
    % STFT, window gp
 	vgp = fft(s(t(n)+tau).*gp(Lh+tau+1),Nfft);
    
    % operator omega
    omega(:,n) = Lx*(0:Nfft-1)'/Nfft-real(vgp/2/1i/pi./vg);    
 	
    
    % STFT, window gpp
 	vgpp  = fft(s(t(n)+tau).*gpp(Lh+tau+1),Nfft);
       
    %STFT, windox xgp
 	vxgp  = fft(s(t(n)+tau).*(tau)'/Lx.*gp(Lh+tau+1),Nfft);
    
       
 	%computation of the two different omega 
        
    QM(:,n) = 1/2/1i/pi*(vgpp.*vg-vgp.^2)./(vxg.*vgp-vxgp.*vg);
       
    %new omega2
    omega2(:,n) = omega(:,n) - real(QM(:,n)).*real(t_gd(:,n))...
                              + imag(QM(:,n)).*imag(t_gd(:,n));
end

 %% reassignment step
for n=1:Nt
    for eta=1:Nfft
        if abs(STFT(eta,n)) > gamma
           k = 1+round(Nfft/Lx*omega(eta,n));
            if (k >= 1) && (k <= Nfft)
             % original reassignment
             T1(k,n) = T1(k,n) + STFT(eta,n);
            end
            %reassignment using new omega2
            k = 1+round(Nfft/Lx*omega2(eta,n));
            if k>=1 && k<=Nfft
                % second-order Vertical reassignment: VSST
                T2(k,n) = T2(k,n) + STFT(eta,n);
            end 
        end
    end
end

end