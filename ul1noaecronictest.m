function ul1noaecronictest
X = 0.4;
i = 1;
d = -1*ul1noaecronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(10000*i))*d
    i = i + 1;
    d = -1*ul1noaecronicthreshold(X);
end
X
i
end