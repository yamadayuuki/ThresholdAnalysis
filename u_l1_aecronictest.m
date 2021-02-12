function u_l1_aecronictest
X = 0.585;
i = 1;
d = -1*u_l1_aecronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(500*i))*d
    i = i + 1;
    d = -1*u_l1_aecronicthreshold(X);
end
X
i
end