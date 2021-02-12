function c_withdrawcronictest
X = 100;
i = 1;
d = -c_withdrawcronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/i)*d
    i = i + 1;
    d = -c_withdrawcronicthreshold(X);
end
X
i
end