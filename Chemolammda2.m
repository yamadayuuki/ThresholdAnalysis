function Chemolammda2
tic
lammda2 = 0.9;
[a,b] = lammda2Chemothrestest(lammda2);
c = a-b;
i = 1;
while(abs(c) > 0.000001*i)
    [a,b] = lammda2Chemothrestest(lammda2);
    c = a-b;
    lammda2 = lammda2 - (1/(300*i))*c
    i = i + 1;
end
lammda2
i
toc
end