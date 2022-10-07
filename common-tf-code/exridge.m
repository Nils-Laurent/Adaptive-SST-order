function [c,e] = exridge(Tx,lambda,beta,jump)
% exridge : extracts  the ridge curve by maximising some energy. 
%   The result is an approximation computd by a greedy algorithm.
%   The algorithm uses several random initializations and then
%   forward/backward search.
%
% INPUTS:   
%   Tx : synchrosqueezed transform
%   lambda : the paremeter associated with first derivative penalization
%   beta   : the parameter associated with the second derivative penalization 
% OUTPUTS:  
%   c : vector containing the indexes of the ridge. length :size(Tx,2).
%   e : energy of the returned ridge, scalar.


%Et = log(abs(Tx)+eps^0.25);
Et     = abs(Tx).^2;
[na,N] = size(Tx);

% Parameters of the algorithm.
da = jump; 
ng = min(60,floor(N/8)); % Number of random initializations.

ccur = zeros(1,N);
c = ccur;    
e = -Inf;

cr_shift = @(v_idx, shift)(max(1,min(na,v_idx+shift)));
%     function [idx_shift] = internal_cr_shift(cr, )
%         idx_shift = max(1,idx-da):min(na,idx+da);
%     end

for k = floor(linspace(N/(ng+1),N-N/(ng+1),ng))
    [ecur,idx] = max(Et(:,k));        
    ccur(k) = idx;
    Iq = max(1,idx-da):min(na,idx+da);
    [ecur,idx] = max(Et(Iq,k-1));        
    ccur(k-1) = Iq(idx);
   
    cr = (ccur(k) - ccur(k-1));
%     idx = ccur(k) + cr;
    idx = cr_shift(ccur(k), cr);
    % forward step
    for b=k+1:N
     etmp = -Inf;
     a=max(1,idx-da):min(na,idx+da);
     
     [y, idx] = max(Et(a,b));
     idx = a(idx);
     ccur(b) = idx;
     etmp = y;
     ecur = ecur + etmp;
     
     cr = (ccur(b) - ccur(b-1));
%      idx = idx + cr;
     idx = cr_shift(idx, cr);
    end

    cr = (ccur(k+1) - ccur(k));
%     idx = ccur(k) - cr;
    idx = cr_shift(ccur(k), -cr);
    
    % backward step
    for b=k-1:-1:1
     etmp = -Inf;
     a=max(1,idx-da):min(na,idx+da);
     
     [y, idx] = max(Et(a,b));
     idx = a(idx);
     ccur(b) = idx;
     etmp = y;
     ecur = ecur + etmp;

     cr = (ccur(b+1) - ccur(b));
%      idx = idx - cr;
     idx = cr_shift(idx, -cr);
    end
    
    if ecur> e
        e = ecur;
        c = ccur;
    end
end

end
