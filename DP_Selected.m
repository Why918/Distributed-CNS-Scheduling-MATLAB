function [NPR,Cost_DP,f,Cost,UNP1,t] = DP_Selected(p,sxy,rp,rd,rb,dmax,k)
%% Perform dynamic programming of the selected agent
%  Input: p - 2-D coordinates of the selected agent
%         sxy - 2-D coordinates of the neighbors
%         rp - GNSS noise variance
%         rd - Relative distance noise variance
%         rb - Relative bearing noise variance
%         dmax - Maximum communication distance
%         k - Noise factor
%  Output: NPR - All the possible navigation performance requirements
%          Cost_DP - The corresponding minimum communication cost
%          f - The last row of the design CNS table 
%          Cost - Communication cost of each relative measurement
%          UNP1: The highest navigation performance of the selected agent
%          t - Running time of dynamic programming

%% Number of swarm
n = 1 + size(sxy,1);
nn = n - 1;

%% Error covariance of local estimate
P0 = cell(1,n);
for i = 1 : n
    P0{i} = diag([rp,rp]);
end

%% Select the agent
xy1 = p';
P10 = P0{1};
NP10 = NPmap(P10);
dxy1 = xy1 - sxy;
r1 = sqrt(dxy1(:,1).^2 + dxy1(:,2).^2);

P20 = P0;
P20(1) = [];

%% Calculate communication cost
data = 10;
Cost = data * exp(k * r1 / dmax);
Cost = roundn(Cost,-2);
step = 0.01;
Cost = fix(Cost/step);

%% Relative measurement covariance
d2r = pi / 180;
R = diag([rd, rb * d2r^2]);

%% Calculate information gain
S = cell(1,nn);
C = inv(P10);
for i = 1 : nn
    H1 = [dxy1(i,1)/r1(i),dxy1(i,2)/r1(i); -dxy1(i,2)/r1(i)^2,dxy1(i,1)/r1(i)^2];
    H2 = -H1;
    S{i} = H1' / (R + H2 * P20{i} * H2') * H1;
    C = C + S{i};
end
P1 = inv(C);
UNP1 = NPmap(P1); % The highest navigation performance

%% Dynamic programming
tic
sum_Cost = sum(Cost);

f = 1e4 * ones(nn + 1, sum_Cost + 1); % Initialize f
f(:,1) = UNP1;
g = repmat({C}, nn + 1, sum_Cost + 1); % Initialize g

max_Cost = 0;

for i = 1 : nn
    max_Cost = max_Cost + Cost(i);
    for j = 1 : max_Cost
            temp = max(0,j - Cost(i));
            g_temp = {g{i,temp + 1} - S{i}, g{i,j+1}};

            NP1 = NPmap(inv(g_temp{1}));
            [f(i+1,j+1), bool] = min([NP1, f(i,j+1)]); % state transition
            g(i+1,j+1) = g_temp(bool);
    end
end
t = toc;

%% Calculate the minimum communication cost corresponding to different navigation performance requirements
NPR = UNP1 : 0.01 : NP10 + 0.5;
Cost_DP = zeros(1,length(NPR));
j = 1;
for RP = NPR
    temp = find(f(end,:) <= RP);
    temp = temp(end);
    Cost_DP(j) = temp - 1;
    j = j + 1;
end
Cost_DP = (sum_Cost - Cost_DP) * step;

end