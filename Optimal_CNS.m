function [Link, NP, min_Cost] = Optimal_CNS(f,Cost,NPR)
%% APP生成选择智能体的最低通信vs.性能需求1
% p-选择智能体的坐标，2×1
% sxy-邻居的坐标，(n-1)×2
% vp-GNSS噪声方差

%% 集群规模
nn = size(f,1) - 1;
step = 0.01;

temp = find(f(end,:) <= NPR);
temp = temp(end);
opt_Cost = temp - 1;

min_Cost = (size(f,2) - 1 - opt_Cost) * step;
NP = f(end, opt_Cost + 1);

Link = true(nn,1);
j = opt_Cost;
for i = nn : -1 : 1
    if f(i + 1, j + 1) ~= f(i, j + 1)
        Link(i) = false;
        j = j - Cost(i);
    end
end

end