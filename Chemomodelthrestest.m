function [P1, P2] = Chemomodelthrestest
tic
N2 = 10000;
dresss_cost = 110;
dressn_cost = 420;
wtp = 30000;
% Safety Data
num_pat = 111; % Number of patients in observed data
num_se = 27;   % Number of patients with side effects, given standard-of-care
num_amb = 17;  % Number of patient with hospital care following side effect, given stardard-or-care
num_death = 1; % Number of Deaths
% Priors recovery
m_1_3 =  0.45;
v_1_3 = 0.02;
p1_1_3 = ((1 - m_1_3)/v_1_3 - 1/ m_1_3) * (m_1_3 ^2);
p2_1_3  = p1_1_3 * (1/m_1_3 - 1);

m_2_3 = 0.35;
v_2_3 = 0.02;
p1_2_3 = ((1 - m_2_3)/v_2_3 - 1/ m_2_3) * (m_2_3 ^2);
p2_2_3  = p1_2_3 * (1/m_2_3 - 1);
% Probability reduction (=1-rho) of side effect given new treatment 
% pi[2] <- rho * pi[1]
m_rho = 0.65; % Mean 
s_rho = 0.1; % Standard deviation
%tau_rho = 1/s_rho^2; % Precision

% Costs
% Cost of ambulatory care 
mu_amb = 2300; % Mean
sd_amb = 90;  % Standard deviation
m_amb = log(mu_amb) - 0.5*log(1 + sd_amb^2/mu_amb^2);
s_amb = sqrt(log(1 + sd_amb^2/mu_amb^2));

% Cost of hospitalization
mu_hosp = 6500;
sd_hosp = 980;
m_hosp = log(mu_hosp) - 0.5*log(1 + sd_hosp^2/mu_hosp^2);
s_hosp = sqrt(log(1 + sd_hosp^2/mu_hosp^2));

%Cost of Death
mu_death = 4200;
sd_death = 560;
m_death = log(mu_death) - 0.5*log(1 + sd_death^2/mu_death^2);
s_death = sqrt(log(1 + sd_death^2/mu_death^2));
%tau_death = 1/s_death ^ 2;
% Effects
% QALY on Chemo
mu_chemo = 0.98;
var_chemo = 0.001;
p1_chemo = ((1 - mu_chemo)/var_chemo - 1/ mu_chemo) * (mu_chemo ^2);
p2_chemo = p1_chemo * (1/mu_chemo - 1);

% QALY on Amb
mu_e_amb =  0.5;
var_e_amb =  0.02;
p1_amb = ((1 - mu_e_amb)/var_e_amb - 1/ mu_e_amb) * (mu_e_amb ^2);
p2_amb = p1_amb * (1/mu_e_amb - 1);

% QALY on hosp
mu_e_hosp =  0.2;
var_e_hosp = 0.03;
p1_hosp = ((1 - mu_e_hosp)/var_e_hosp - 1/ mu_e_hosp) * (mu_e_hosp ^2);
p2_hosp = p1_hosp * (1/mu_e_hosp - 1);

% Number of patients in the population to model
NN = 1000;

% Time Horizon on Side Effects
Th = 15;

pi0 = betarnd(num_se + 1,num_pat - num_se + 1,N2,1);
rho = normrnd(m_rho,s_rho,N2,1);
pi1 = pi0.*rho;
gamma = betarnd(num_amb + 1,num_se - num_amb + 1,N2,1);
gamma2 = betarnd(num_death + 1, num_se - num_amb - num_death  + 4,N2,1);
lambda_1_3_fix = betarnd(p1_1_3,p2_1_3,N2,1);
lambda_2_3_fix = betarnd(p1_2_3,p2_2_3,N2,1);

lambda_1_2 = (1 - gamma)./Th;
lambda_1_3 = (1 - lambda_1_2) .* lambda_1_3_fix;
lambda_1_1 = (1 - lambda_1_3_fix) .* (1 - lambda_1_2);
lambda_2_4 = gamma2 ./ Th;
lambda_2_3 = (1 - lambda_2_4) .* lambda_2_3_fix;
lambda_2_2 = (1 - lambda_2_3_fix) .* (1 - lambda_2_4);
    
e_chemo = betarnd(p1_chemo,p2_chemo,N2,1);
e_amb = betarnd(p1_amb,p2_amb,N2,1);
e_hosp = betarnd(p1_hosp,p2_hosp,N2,1);
    
SE0 = binornd(NN,pi0,N2,1);
SE1 = binornd(NN,pi1,N2,1);
    
c_amb = lognrnd(m_amb,s_amb,N2,1);
c_hosp = lognrnd(m_hosp,s_hosp,N2,1);
c_death = lognrnd(m_death,s_death,N2,1);
    
q_chemo0 = (NN - SE0) .* e_chemo .* 16;
q_chemo1 = (NN - SE1) .* e_chemo .* 16;

MM_mat = zeros([4 4 N2]);
LL_mat = zeros([4 4 N2]);
LL_mat(1,1,:) = ones([N2 1]);
LL_mat(2,2,:) = ones([N2 1]);
LL_mat(3,3,:) = ones([N2 1]);
LL_mat(4,4,:) = ones([N2 1]);
MM_mat(1,1,:) = lambda_1_1;
MM_mat(1,2,:) = lambda_1_2;
MM_mat(1,3,:) = lambda_1_3;
MM_mat(2,2,:) = lambda_2_2;
MM_mat(2,3,:) = lambda_2_3;
MM_mat(2,4,:) = lambda_2_4;
MM_mat(3,3,:) = ones([N2 1]);
MM_mat(4,4,:) = ones([N2 1]);
for i = 1:N2
    for k = 1:15
        LL_mat(:,:,i) = LL_mat(:,:,i) + MM_mat(:,:,i)^k;
    end
end
NB = zeros(N2,2);
for i = 1:N2
   NB(i,1) = -dresss_cost + (1/(NN*(Th + 1)))*[SE0(i) 0 0 0]*LL_mat(:,:,i)*[wtp*e_amb(i)- c_amb(i);wtp*e_hosp(i) - c_hosp(i);wtp*e_chemo(i);-c_death(i)] + wtp*q_chemo0(i)/(NN*(Th + 1));
   NB(i,2) = -dressn_cost + (1/(NN*(Th + 1)))*[SE1(i) 0 0 0]*LL_mat(:,:,i)*[wtp*e_amb(i)- c_amb(i);wtp*e_hosp(i) - c_hosp(i);wtp*e_chemo(i);-c_death(i)] + wtp*q_chemo1(i)/(NN*(Th + 1));
end
P1 = NB(:,1);
P2 = NB(:,2);
toc
end
