function Chemogamma1
tic
gamma1 = 0.5;
[a,b] = gamma1Chemothrestest(gamma1);
c = a-b;
i = 1;
while(abs(c) > 0.000001*i)
    [a,b] = gamma1Chemothrestest(gamma1);
    c = a-b;
    gamma1 = gamma1 - (1/(30*i))*c;
    i = i + 1;
end
gamma1
i
toc
end