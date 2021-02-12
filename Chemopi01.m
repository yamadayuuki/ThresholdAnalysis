function Chemopi01
tic
pi0 = 0.01;
[a,b] = pi0Chemothrestest(pi0);
c = b-a;
i = 1;
while(abs(c) > 0.0005*i)
    [a,b] = pi0Chemothrestest(pi0);
    c = b-a;
    pi0 = pi0 - (1/(1000*i))*c
    i = i + 1;
end
pi0
toc
end