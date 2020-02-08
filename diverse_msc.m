
function [NMI ACC AR F P R] = diverse_msc(X,gt,lambda_s,lambda_v)
%data preparation
D{1} = X{1};
D{2} = X{2};
D{3} = X{3};
view_num = 3;
N = size(D{1},2);
clusNum = size(unique(gt),1);

%representation
Z = diverse_rep(D, view_num, lambda_s, lambda_v);
%spectral Clustering
CKSym = zeros(N,N);
for v=1:view_num
    CKSym =CKSym + abs(Z{v})+abs(Z{v}');
end

C = SpectralClustering(CKSym,clusNum);
[A NMI avgent] = compute_nmi(gt,C);
[F,P,R] = compute_f(gt,C);
[AR,RI,MI,HI]=RandIndex(gt,C);
C = bestMap(gt,C);
ACC = length(find(gt == C))/length(gt);
%[Acc,rand_index,match]=AccMeasure(gt,C);
%[confusion_matrix,trace_max]=confusion_compute(label_predict,num_each_class);

