function X = p_ae_l1_t1cronicthreshold(a)
prob_novel=0.3;
cost_novel=6;

%MENZIES N
%N<-5000
%ALL N
%N<-100000
%experiment
N = 1000;

%Costs
%Treatment costs are considered known and taken from the literature. The novel treatment is assumed to be
%6 times more expensive than Oxycodone
c_t1 = 2.632729166666670000;
c_t2 = 9.2011500000*cost_novel;

%The comedication cost per cycle - this is for complications associated with the pain medication
%Costs based on a previous study so inflation needs to be taken into account
PriceIndex0910 = 268.6;
PriceIndex1213 = 289.1;
Inflation = PriceIndex1213/PriceIndex0910;


[c_med_t1_alpha,c_med_t1_beta,~] = gammapar(2.1*Inflation);
c_med_t1 = gamrnd(c_med_t1_alpha,1/c_med_t1_beta,N,1);

%Novel theraphy gives an improvement on Oxycodone so the cost is based on this improvement
[c_med_t2_alpha,c_med_t2_beta,~] = gammapar(0.04*Inflation*(1-prob_novel));
c_med_t2 = gamrnd(c_med_t2_alpha,1/c_med_t2_beta,N,1);
%c_med_t2 = repmat(a,N,1);
%Costs of adverse events
[c_ae_alpha,c_ae_bata,~] = gammapar(6.991009409);
c_ae = gamrnd(c_ae_alpha,1/c_ae_bata,N,1);

%The cost of withdrawing from the theraphy is the same irrespective of the reason you withdaw
[c_withdraw_alpha,c_withdraw_beta,~] = gammapar(106.911031273);
c_withdraw_ae = gamrnd(c_withdraw_alpha,1/c_withdraw_beta,N,1);
c_withdraw = gamrnd(c_withdraw_alpha,1/c_withdraw_beta,N,1);

%Cost of discontinuing treatment is based on visiting the GP
[c_dist_alpha,c_dist_beta,~] = gammapar(18.5);
c_dist = gamrnd(c_dist_alpha,1/c_dist_beta,N,1);

%Cost of second round of treatment
c_l2 = 9.2011500000+0.04*Inflation;

%Cost of third round of treatment
c_l3 = 2.632729166666670000+2.1*Inflation;
%%Utilities%%
%No adverse effects for the first treatment
[u_l1_noae_alpha,u_l1_noae_beta] = betapar(0.695000000);
u_l1_noae = betarnd(u_l1_noae_alpha,u_l1_noae_beta,N,1);
%u_l1_noae = repmat(a,N,1);

%Adverse effects
[u_l1_ae_alpha,u_l1_ae_beta] = betapar(0.583000000);
u_l1_ae = betarnd(u_l1_ae_alpha,u_l1_ae_beta,N,1);

%Withdraw from treatment due to adverse effects
[u_l1_withdraw_ae_alpha,u_l1_withdraw_ae_beta] = betapar(0.503000000);
u_l1_withdraw_ae = betarnd(u_l1_withdraw_ae_alpha,u_l1_withdraw_ae_beta,N,1);

%Withdraw due to other reasons
[u_l1_withdraw_noae_alpha,u_l1_withdraw_noae_beta] = betapar(0.405000000);
u_l1_withdraw_noae = betarnd(u_l1_withdraw_noae_alpha,u_l1_withdraw_noae_beta,N,1);

%Multiplier to give the utilities when on the 2nd treatment options
u_l2 = 0.900;

%Utility for 3rd case of treatment
u_l3 = (u_l1_noae+u_l1_ae)/2;

%Discontinuing treatment
u_dist = u_l1_withdraw_noae*0.8;

%%Transition Probabilities%%
%For the first round of treatments
%probability of adverse effects
%[p_ae_l1_t1_alpha,p_ae_l1_t1_beta] = betapar(0.436159243);
%p_ae_l1_t1 = betarnd(p_ae_l1_t1_alpha,p_ae_l1_t1_beta,N,1);
p_ae_l1_t1 = repmat(a,N,1);
p_ae_l1_t2 = p_ae_l1_t1*(1-prob_novel);

%probility of withdrawal due to adverse effects
[p_with_ae_l1_t1_alpha,p_with_ae_l1_t1_beta] = betapar(0.055739588);
p_with_ae_l1_t1 = betarnd(p_with_ae_l1_t1_alpha,p_with_ae_l1_t1_beta,N,1);
[p_with_ae_l1_t2_alpha,p_with_ae_l1_t2_beta] = betapar(0.022958454);
p_with_ae_l1_t2 = betarnd(p_with_ae_l1_t2_alpha,p_with_ae_l1_t2_beta,N,1);

%probability of withdrawal due to other reasons
[p_with_l1_t1_alpha,p_with_l1_t1_beta] = betapar(0.012741455);
p_with_l1_t1 = betarnd(p_with_l1_t1_alpha,p_with_l1_t1_beta,N,1);

[p_with_l1_t2_alpha,p_with_l1_t2_beta] = betapar(0.001612408);
p_with_l1_t2 = betarnd(p_with_l1_t2_alpha,p_with_l1_t2_beta,N,1);

%probability of discontinuation
[p_dist_l1_alpha,p_dist_l1_beta] = betapar(0.050000000);
p_dist_l1 = betarnd(p_dist_l1_alpha,p_dist_l1_beta,N,1);

%For the second round of treatment that only has one treatment

%probability of adverse effects
[p_ae_l2_t1_alpha,p_ae_l2_t1_beta] = betapar(0.463500000);
p_ae_l2_t1 = betarnd(p_ae_l2_t1_alpha,p_ae_l2_t1_beta,N,1);

[p_ae_l2_t2_alpha,p_ae_l2_t2_beta] = betapar(0.463500000);
p_ae_l2_t2 = betarnd(p_ae_l2_t2_alpha,p_ae_l2_t2_beta,N,1);

%probability of withdrawal due to adverse effects
[p_with_ae_l2_t1_alpha,p_with_ae_l2_t1_beta] = betapar(0.032797792);
p_with_ae_l2_t1 = betarnd(p_with_ae_l2_t1_alpha,p_with_ae_l2_t1_beta,N,1);

[p_with_ae_l2_t2_alpha,p_with_ae_l2_t2_beta] = betapar(0.032797792);
p_with_ae_l2_t2 = betarnd(p_with_ae_l2_t2_alpha,p_with_ae_l2_t2_beta,N,1);

%probability of withdrawal due to other reasons
[p_with_l2_t1_alpha,p_with_l2_t1_beta] = betapar(0.002303439);
p_with_l2_t1 = betarnd(p_with_l2_t1_alpha,p_with_l2_t1_beta,N,1);
p_with_l2_t2 = p_with_l2_t1;

%probability of discontinuation
%[p_dist_l2_alpha,p_dist_l2_beta] = betapar(0.100000000);
%p_dist_l2 = betarnd(p_dist_l2_alpha,p_dist_l2_beta,N,1);

%%%Transition Matrices%%%
%First line of treatment l1
%For treatment 1 t1

No_AE_l1_t1 = [(1-p_with_ae_l1_t1-p_with_l1_t1).*(1-p_ae_l1_t1)...,
    (1-p_with_ae_l1_t1-p_with_l1_t1).*(p_ae_l1_t1)...,
    p_with_ae_l1_t1...,
    p_with_l1_t1...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)];

AE_l1_t1 = [(1-p_with_ae_l1_t1-p_with_l1_t1).*(1-p_ae_l1_t1)...,
    (1-p_with_ae_l1_t1-p_with_l1_t1).*(p_ae_l1_t1)...,
    p_with_ae_l1_t1...,
    p_with_l1_t1...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)];

With_AE_l1_t1 = [zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    (1-p_dist_l1).*(1-p_ae_l2_t1)...,
    (1-p_dist_l1).*p_ae_l2_t1...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    p_dist_l1];

With_l1_t1 = [zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    (1-p_dist_l1).*(1-p_ae_l2_t1)...,
    (1-p_dist_l1).*p_ae_l2_t1...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    p_dist_l1];

%Second line of treatment l2
No_AE_l2_t1 = [zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    (1-p_with_ae_l2_t1-p_with_l2_t1).*(1-p_ae_l2_t1)...,
    (1-p_with_ae_l2_t1-p_with_l2_t1).*p_ae_l2_t1...,
    p_with_ae_l2_t1...,
    p_with_l2_t1...,
    zeros(N,1)...,
    zeros(N,1)];

AE_l2_t1 = [zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    zeros(N,1)...,
    (1-p_with_ae_l2_t1-p_with_l2_t1).*(1-p_ae_l2_t1)...,
    (1-p_with_ae_l2_t1-p_with_l2_t1).*p_ae_l2_t1...,
    p_with_ae_l2_t1...,
    p_with_l2_t1...,
    zeros(N,1)...,
    zeros(N,1)];

%First line of treatment l1
%For treatment 2 t2

No_AE_l1_t2 = [(1-p_with_ae_l1_t2-p_with_l1_t2).*(1-p_ae_l1_t2),...
    (1-p_with_ae_l1_t2-p_with_l1_t2).*p_ae_l1_t2,...
    p_with_ae_l1_t2,...
    p_with_l1_t2,...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1)];

AE_l1_t2 = [(1-p_with_ae_l1_t2-p_with_l1_t2).*(1-p_ae_l1_t2),...
    (1-p_with_ae_l1_t2-p_with_l1_t2).*p_ae_l1_t2,...
    p_with_ae_l1_t2,...
    p_with_l1_t2,...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1)];

With_AE_l1_t2 = [zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    (1-p_dist_l1).*(1-p_ae_l2_t2),...
    (1-p_dist_l1).*p_ae_l2_t2,...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    p_dist_l1];

With_l1_t2 = [zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    (1-p_dist_l1).*(1-p_ae_l2_t2),...
    (1-p_dist_l1).*p_ae_l2_t2,...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    p_dist_l1];

%Second line of treatment l2
No_AE_l2_t2 = [zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    (1-p_with_ae_l2_t2-p_with_l2_t2).*(1-p_ae_l2_t2),...
    (1-p_with_ae_l2_t2-p_with_l2_t2).*p_ae_l2_t2,...
    p_with_ae_l2_t2,...
    p_with_l2_t2,...
    zeros(N,1),...
    zeros(N,1)];

AE_l2_t2 = [zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    zeros(N,1),...
    (1-p_with_ae_l2_t2-p_with_l2_t2).*(1-p_ae_l2_t2),...
    (1-p_with_ae_l2_t2-p_with_l2_t2).*p_ae_l2_t2,...
    p_with_ae_l2_t2,...
    p_with_l2_t2,...
    zeros(N,1),...
    zeros(N,1)];

With_AE_l2 = [zeros(N,9),ones(N,1)];
%1-p_dist_l2,p.dist_l2
With_l2 = [zeros(N,9),ones(N,1)];
%1-p_dist_l2,p_dist_l2)

%%Absorbing states
Subs_treat = [zeros(N,8),ones(N,1),zeros(N,1)];

Dist = [zeros(N,9),ones(N,1)];



PSA_Trans_Mat_t1 = NaN(10,10,N);
PSA_Trans_Mat_t1(1,:,:) = No_AE_l1_t1.';
PSA_Trans_Mat_t1(2,:,:) = AE_l1_t1.';
PSA_Trans_Mat_t1(3,:,:) = With_AE_l1_t1.';
PSA_Trans_Mat_t1(4,:,:) = With_l1_t1.';
PSA_Trans_Mat_t1(5,:,:) = No_AE_l2_t1.';
PSA_Trans_Mat_t1(6,:,:) = AE_l2_t1.';
PSA_Trans_Mat_t1(7,:,:) = With_AE_l2.';
PSA_Trans_Mat_t1(8,:,:) = With_l2.';
PSA_Trans_Mat_t1(9,:,:) = Subs_treat.';
PSA_Trans_Mat_t1(10,:,:) = Dist.';

PSA_Trans_Mat_t2 = PSA_Trans_Mat_t1;
PSA_Trans_Mat_t2(1,:,:) = No_AE_l1_t2.';
PSA_Trans_Mat_t2(2,:,:) = AE_l1_t2.';
PSA_Trans_Mat_t2(3,:,:) = With_AE_l1_t2.';
PSA_Trans_Mat_t2(4,:,:) = With_l1_t2.';
PSA_Trans_Mat_t2(5,:,:) = No_AE_l2_t2.';
PSA_Trans_Mat_t2(6,:,:) = AE_l2_t2.';

c_Mat_t1 = [c_t1 + c_med_t1,...
    c_t1+c_med_t1+c_ae,...
    c_withdraw_ae,...
    c_withdraw,...
    ones(N,1)*c_l2,...
    c_l2+c_ae,...
    c_withdraw_ae,...
    c_withdraw,...
    ones(N,1)*c_l3,...
    c_dist];

c_Mat_t2 = [c_t2 + c_med_t2,...
    c_t2+c_med_t2+c_ae,...
    c_withdraw_ae,...
    c_withdraw,...
    ones(N,1)*c_l2,...
    c_l2+c_ae,...
    c_withdraw_ae,...
    c_withdraw,...
    ones(N,1)*c_l3,...
    c_dist];

u_Mat = [u_l1_noae,...
    u_l1_ae,...
    u_l1_withdraw_ae,...
    u_l1_withdraw_noae,...
    u_l1_noae*u_l2,...
    u_l1_ae*u_l2,...
    u_l1_withdraw_ae*u_l2,...
    u_l1_withdraw_noae*u_l2,...
    u_l3,...
    u_dist]*7/365.25;

%Time_Horizen = 52;
%InitVector = [1,0,0,0,0,0,0,0,0,0];

Prob_Array_1 = NaN(52,10,N);
for i = 1:N
    Prob_Array_1(:,:,i) = Markov_Prob(PSA_Trans_Mat_t1(:,:,i));
end

Prob_Array_2 = NaN(52,10,N);
for i = 1:N
    Prob_Array_2(:,:,i) = Markov_Prob(PSA_Trans_Mat_t2(:,:,i));
end

costs_t1 = NaN(N,1);
for i = 1:N
    costs_t1(i) = sum(Prob_Array_1(:,:,i)*(c_Mat_t1(i,:).'));
end

costs_t2 = NaN(N,1);
for i = 1:N
    costs_t2(i) = sum(Prob_Array_2(:,:,i)*(c_Mat_t2(i,:).'));
end

effects_t1 = NaN(N,1);
for i = 1:N
    effects_t1(i) = sum(Prob_Array_1(:,:,i)*(u_Mat(i,:).'));
end

effects_t2 = NaN(N,1);
for i = 1:N
    effects_t2(i) = sum(Prob_Array_2(:,:,i)*(u_Mat(i,:).'));
end

discount_15 = (1.035 - (1/1.035)^15)/0.035;
NB = discount_15*[effects_t1*20000 - costs_t1,...
    effects_t2*20000 - costs_t2];
INB = NB(:,1) - NB(:,2);
X = mean(INB);
end