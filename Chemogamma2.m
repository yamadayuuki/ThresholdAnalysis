function Chemogamma2
tic
gamma2 = 0.5;
[a,b] = gamma2Chemothrestest(gamma2);
c = b-a;
i = 1;
while(abs(c) > 0.000001*i)
    [a,b] = gamma2Chemothrestest(gamma2);
    c = b-a;
    gamma2 = gamma2 - (1/(3*i))*c
    i = i + 1;
end
gamma2
i
toc
end