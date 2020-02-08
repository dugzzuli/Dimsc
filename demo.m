clear all;
load('ORL_mtv.mat');

for i=1:1
[NMIi(i) ACCi(i) ARi(i) Fi(i) Pi(i) Ri(i)] = diverse_msc(X,gt,1,100);
end

NMI = mean(NMIi);ACC = mean(ACCi);AR = mean(ARi);F = mean(Fi);P = mean(Pi);R = mean(Ri);