function [Z, E] = diverse_rep(D, num_views, lambda, beta)
% D:V types of features
N = size(D{1},2);
K_complement = zeros(N,N);
H = ones(N,N)*(1/N)*(-1) + eye(N);

for v=1:num_views
    %D{v} = D{v}./repmat(sqrt(sum(D{v}.^2,1)),size(D{v},1),1);
    [Z{v}] = smooth_rep(D{v},lambda);
    W{v} = D{v}'*D{v};
    %W{v} = W{v}/max(max(abs(W{v})));
    L{v} = diag(sum(W{v})) - W{v};
end

ObjVal = zeros(30,1);
IterNum = 10;
kk = 1;
for iter = 1:IterNum
    %% Update each view
    for v=1:num_views
%        
        K_complement = K_complement*0;
        for k=1:num_views
            if (k==v) 
                continue;
            end
            K_complement =  K_complement + H*Z{k}'*Z{k}*H;                    
         end
         [Z{v}] =  SMR_mtv(D{v},K_complement,lambda,beta);
         
         
          %% calculate objective value
        for vv=1:num_views
            K{vv}=Z{vv}'*Z{vv};
        end
        term1 = 0;
        term2 = 0;
        term3 = 0;
        for vvv=1:num_views
            term1 = term1 + norm(D{vvv}-D{vvv}*Z{vvv},'fro')^2;
            term2 = term2 + trace(Z{vvv}*L{vvv}*Z{vvv}');
            for www = 1:num_views
                if (abs(www-vvv)>0)
                    term3 = term3 + trace(H*K{vvv}*H*K{www});
                end
            end
        end   
      ObjVal(kk,1) = term1 + lambda*term2 + beta*term3;
      kk =kk+1;
      term3;
    end
end