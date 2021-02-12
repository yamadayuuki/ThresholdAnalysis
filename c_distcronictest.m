function c_distcronictest
X = 18.5;
i = 1;
d = -c_distcronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/i)*d
    i = i + 1;
    d = -c_distcronicthreshold(X);
end
X
i
end