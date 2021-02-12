function p_with_ae_l1_t1cronictest
X = 0.05;
i = 1;
d = -p_with_ae_l1_t1cronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(100000*i))*d
    i = i + 1;
    d = -p_with_ae_l1_t1cronicthreshold(X);
end
X
i
end