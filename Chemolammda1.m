function Chemolammda1
tic
lammda1 = 0.3;
[a,b] = lammda1Chemothrestest(lammda1);
c = a-b;
i = 1;
while(abs(c) > 0.000001*i)
    [a,b] = lammda1Chemothrestest(lammda1);
    c = a-b;
    lammda1 = lammda1 - (1/(500*i))*c
    i = i + 1;
end
lammda1
i
toc
end