function p_with_l2cronictest
X = 0.58;
i = 1;
d = p_with_l2cronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(50000*i))*d
    i = i + 1;
    d = p_with_l2cronicthreshold(X);
end
X
i
end