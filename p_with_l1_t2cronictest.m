function p_with_l1_t2cronictest
X = 0.001;
i = 1;
d = p_with_l1_t2cronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(100000*i))*d
    i = i + 1;
    d = p_with_l1_t2cronicthreshold(X);
end
X
i
end