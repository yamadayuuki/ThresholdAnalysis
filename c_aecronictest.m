function c_aecronictest
X = 7;
i = 1;
d = -c_aecronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/i)*d
    i = i + 1;
    d = -c_aecronicthreshold(X);
end
X
i
end