function c_med_t2cronictest
X = 2.3;
i = 1;
d = c_med_t2cronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(50*i))*d
    i = i + 1;
    d = c_med_t2cronicthreshold(X);
end
X
i
end