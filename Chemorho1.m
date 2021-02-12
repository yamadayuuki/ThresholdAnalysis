function Chemorho1
tic
rho = 0.4;
[a,b] = rhoChemothrestest(rho);
c = a-b;
i = 1;
while(abs(c) > 0.0001*i)
    [a,b] = rhoChemothrestest(rho);
    c = a-b;
    rho = rho - (1/(500*i))*c
    i = i + 1;
end
rho
toc
end