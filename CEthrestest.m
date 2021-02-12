%CEは他の変数との掛け合わせではないので閾値が存在しない。
function [P1,P2,P3] = CEthrestest(a)
N2 = 1000;
QSE = normrnd(0.7,0.1,1,N2);
CSE = normrnd(100000,1000,1,N2);
PSE1 = zeros(1,N2);
lgtPSE = mvnrnd([-1.4 -1.1],[0.10 0.05; 0.05 0.25], N2).';
lgtPSE2 = lgtPSE(1,:);
lgtPSE3 = lgtPSE(2,:);
PSE2 = exp(lgtPSE2)./(1+exp(lgtPSE2));
PSE3 = exp(lgtPSE3)./(1 + exp(lgtPSE3));
lam = 7.5*10^4;
L = normrnd(30,5,1,N2);
lgtQE = normrnd(0.6,1/6,1,N2);
QE = exp(lgtQE)./(1+exp(lgtQE));
CE = repmat(a,1,N2);
CT1 = zeros(1,N2);
CT = mvnrnd([15*10^3 2*10^4],[300 100; 100 500], 1*N2).';
CT2 = reshape(CT(1,:), 1, N2);
CT3 = reshape(CT(2,:), 1, N2);
PE1 = betarnd(15,85,1,N2);
logOR = mvnrnd([-1.5 -1.75],[0.11 0.02; 0.02 0.06], 1*N2).';
logOR2 = reshape(logOR(1,:), 1, N2);
logOR3 = reshape(logOR(2,:), 1, N2);
PE2 = 1./(1+(1-PE1)./(PE1.*exp(logOR2)));
PE3 = 1./(1+(1-PE1)./(PE1.*exp(logOR3)));


P1 = PSE1.*PE1.*(lam*(L.*(1+QE)./2-QSE)-(CSE+CE)) ...
        + PSE1.*(1-PE1).*(lam*(L-QSE)-CSE) ...
        + (1-PSE1).*PE1.*(lam*(L.*(1+QE)./2)-CE) ...
        + (1-PSE1).*(1-PE1).*(lam*L) - CT1;
P2 = PSE2.*PE2.*(lam*(L.*(1+QE)./2-QSE)-(CSE+CE)) ...
        + PSE2.*(1-PE2).*(lam*(L-QSE)-CSE) ...
        + (1-PSE2).*PE2.*(lam*(L.*(1+QE)./2)-CE) ...
        + (1-PSE2).*(1-PE2).*(lam*L) - CT2;
P3 = PSE3.*PE3.*(lam*(L.*(1+QE)./2-QSE)-(CSE+CE)) ...
        + PSE3.*(1-PE3).*(lam*(L-QSE)-CSE) ...
        + (1-PSE3).*PE3.*(lam*(L.*(1+QE)./2)-CE) ...
        + (1-PSE3).*(1-PE3).*(lam*L) - CT3;
P1 = mean(P1);
P2 = mean(P2);
P3 = mean(P3);
end