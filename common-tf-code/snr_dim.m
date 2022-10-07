function Y = snr_dim(s,arg2,dim)

if nargin > 2
%     Ls = length(s);
    if dim == 2
        s = s(:).';
    else
        s = s(:);
    end
    Y_sz = size(arg2);
    Y_sz(dim) = 1;
    Y = squeeze(zeros(Y_sz));
    for idx = 1:numel(Y)
        I_Y = cell(1, ndims(Y));
        [I_Y{:}] = ind2sub(size(Y),idx);
        I_s = [I_Y(1:dim-1), {':'}, I_Y(dim:end)];
        
%         sn = squeeze(arg2(I_s{:}));
%         figure;
%         hold on;
%         plot(real(s), '-');
%         plot(real(sn), '--');
%         hold off;
%         
%         figure;
%         hold on;
%         plot(imag(s), '-');
%         plot(imag(sn), '--');
%         hold off;
        
        Y(I_Y{:}) = snr(s, s - squeeze(arg2(I_s{:})));
    end
end

end

