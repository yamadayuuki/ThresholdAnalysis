function p_dist_l1cronictest
X = 0.1;
i = 1;
d = -p_dist_l1cronicthreshold(X);
while(abs(d) > 0.0005*i)
    X = X - (1/(5000*i))*d
    i = i + 1;
    d = -p_dist_l1cronicthreshold(X);
end
X
i
end