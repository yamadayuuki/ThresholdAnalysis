function p_ae_l2cronictest
X = 0.4;
i = 1;
d = -p_ae_l2cronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(5000*i))*d
    i = i + 1;
    d = -p_ae_l2cronicthreshold(X);
end
X
i
end