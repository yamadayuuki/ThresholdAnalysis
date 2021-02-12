function p_ae_l1_ticronictest
X = 0.8;
i = 1;
d = p_ae_l1_t1cronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(10000*i))*d
    i = i + 1;
    d = ul1withdrawnoaecronicthreshold(X);
end
X
i
end