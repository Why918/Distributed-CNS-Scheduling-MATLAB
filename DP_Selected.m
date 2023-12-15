function [NPR,Cost_DP,f,Cost,UNP1,t] = DP_Selected(p,sxy,rp,rd,rb,dmax,k)
%% APP生成选择智能体的最低通信vs.性能需求
% p-选择智能体的坐标，2×1
% sxy-邻居的坐标，(n-1)×2
% rp-GNSS噪声方差
% rd-相对距离噪声方差
% rb-相对方位噪声方差
% dmax-最大通信距离
% k-噪声因子

% NPR-导航性能需求
% Cost_DP-通信代价
% f-二维表
% t-运行时间

%% 集群规模1
n = 1 + size(sxy,1);
nn = n - 1;

%% 本地估计协方差设置
P0 = cell(1,n);
for i = 1 : n
    P0{i} = diag([rp,rp]);
end

%% 优化载体选择
xy1 = p';
P10 = P0{1};
NP10 = NPmap(P10);
dxy1 = xy1 - sxy;
r1 = sqrt(dxy1(:,1).^2 + dxy1(:,2).^2);

P20 = P0;
P20(1) = [];

%% 通信代价计算
data = 10; % 传输的数据量
Cost = data * exp(k * r1 / dmax);
Cost = roundn(Cost,-2);
step = 0.01;
Cost = fix(Cost/step);

%% 量测协方差设置
d2r = pi / 180;
R = diag([rd, rb * d2r^2]);

%% 协方差贡献计算
S = cell(1,nn);
C = inv(P10);
for i = 1 : nn
    H1 = [dxy1(i,1)/r1(i),dxy1(i,2)/r1(i); -dxy1(i,2)/r1(i)^2,dxy1(i,1)/r1(i)^2];
    H2 = -H1;
    S{i} = H1' / (R + H2 * P20{i} * H2') * H1;
    C = C + S{i};
end
P1 = inv(C);
UNP1 = NPmap(P1);

%% 动态规划算法
tic
sum_Cost = sum(Cost);

f = 1e4 * ones(nn + 1, sum_Cost + 1);
f(:,1) = UNP1;
g = repmat({C}, nn + 1, sum_Cost + 1);

max_Cost = 0;

for i = 1 : nn
    max_Cost = max_Cost + Cost(i);
    for j = 1 : max_Cost
            temp = max(0,j - Cost(i));
            g_temp = {g{i,temp + 1} - S{i}, g{i,j+1}};

            NP1 = NPmap(inv(g_temp{1}));
            [f(i+1,j+1), bool] = min([NP1, f(i,j+1)]);
            g(i+1,j+1) = g_temp(bool);
    end
end
t = toc;

%% 绘图
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