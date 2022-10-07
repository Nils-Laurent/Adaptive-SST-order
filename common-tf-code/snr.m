function res = snr(s,n)

% if nargin > 2
% %     Ls = length(s);
%     if dim == 2
%         s = s(:).';
%     else
%         s = s(:);
%     end
%     Y_sz = size(arg2);
%     Y_sz(dim) = 1;
%     Y = squeeze(zeros(Y_sz));
%     for idx = 1:numel(Y)
%         I_Y = cell(1, ndims(Y));
%         [I_Y{:}] = ind2sub(size(Y),idx);
%         I_s = [I_Y(1:dim-1), {':'}, I_Y(dim:end)];
%         Y(I_Y{:}) = snr(s, s - squeeze(arg2(I_s{:})));
%     end
%     res = Y;
%     return;
% end

if length(size(s)) == 2 && length(size(n)) == 2
    if min(size(s)) == 1 && min(size(n)) == 1
        s = s(:);
        n = n(:);
    end
end

%SNR computes the SNR. s : signal and n: noise

rms = @(x) sqrt(mean(abs(x).^2));
res = 20 * log10(rms(s)/rms(n));

end

