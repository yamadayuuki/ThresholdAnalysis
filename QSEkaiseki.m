L = 30;
CE = 2 * 10e+4;
CSE = 10e+4;
lgtQE = normrnd(0.6,1/6,1,10000000);
QE = exp(lgtQE)./(1+exp(lgtQE));
QE = mean(QE);
CT1 = 0;
CT2 = 1.5 * 10e+3;
CT3 = 2 * 10e+3;
PSE1 = 0;
lgtPSE = mvnrnd([-1.4 -1.1],[0.10 0.05; 0.05 0.25], 10000000).';
lgtPSE2 = lgtPSE(1,:);
lgtPSE3 = lgtPSE(2,:);
PSE2 = exp(lgtPSE2)./(1+exp(lgtPSE2));
PSE3 = exp(lgtPSE3)./(1 + exp(lgtPSE3));
PSE2 = mean(PSE2);
PSE3 = mean(PSE3);
PE1 = betarnd(15,85,1,10000000);
logOR = mvnrnd([-1.5 -1.75],[0.11 0.02; 0.02 0.06], 1*10000000).';
logOR2 = reshape(logOR(1,:), 1, 10000000);
logOR3 = reshape(logOR(2,:), 1, 10000000);
PE2 = 1./(1+(1-PE1)./(PE1.*exp(logOR2)));
PE3 = 1./(1+(1-PE1)./(PE1.*exp(logOR3)));
PE2 = mean(PE2);
PE3 = mean(PE3);
PE1 = 0.15;
lam = 75000;
P1  = (1-PSE1)*PE1*(lam*(L*(1+QE)/2)-CE) ...
        + (1-PSE1)*(1-PE1)*(lam*L) - CT1;
P21 = PSE2*PE2*(lam*(L*(1+QE)/2)-(CSE+CE)) ...
        + PSE2*(1-PE2)*(lam*L-CSE) ...
        + (1-PSE2)*PE2*(lam*(L*(1+QE)/2)-CE) ...
        + (1-PSE2)*(1-PE2)*(lam*L) - CT2;
P22 = -PSE2*PE2*lam - PSE2*(1 - PE2)*lam;
P31 = PSE3*PE3*(lam*(L*(1+QE)/2)-(CSE+CE)) ...
        + PSE3*(1-PE3)*(lam*L-CSE) ...
        + (1-PSE3)*PE3*(lam*(L*(1+QE)/2)-CE) ...
        + (1-PSE3)*(1-PE3)*(lam*L) - CT3;
P32 = -PSE3*PE3*lam - PSE3*(1 - PE3)*lam;
ab = (P1 - P21)/P22;
ac = (P1 - P31)/P32;
bc = (P21-P31)/(P32-P22);

x = linspace(-3,3);
f1 = 0*x + 2.160049587877568e+06;
f2 = P21 + P22*x;
f3 = P31 + P32*x;

plot(x,f1,'-g','DisplayName','f1');
hold on
plot(x,f2,'-r','DisplayName','f2');
plot(x,f3,'-b','DisplayName','f3');
hold off
grid on
xlabel('QSE');
ylabel('Value'); 

lgd = legend;
lgd.NumColumns =1;

saveas(gcf,'QSEkaiseki','epsc');


