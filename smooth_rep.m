% By-Changqing Zhang
function [Z] =  smooth_rep(X,lambda)
W = X'*X;
L = diag(sum(W)) - W;
A_syl = X'*X;
B_syl = lambda*L;
C_syl = -X'*X;
Z = lyap(A_syl,B_syl,C_syl);
% CKSym = abs(Z)+abs(Z');
% C = SpectralClustering(CKSym,10);
% [A nmi avgent] = compute_nmi(gt,C);
% [f,p,r] = compute_f(gt,C);
end