function u_l1_withdraw_noaecronictest
X = 0.5;
i = 1;
d = u_l1_withdraw_noaecronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(500*i))*d
    i = i + 1;
    d = u_l1_withdraw_noaecronicthreshold(X);
end
X
i
end