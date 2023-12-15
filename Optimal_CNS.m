function [Link, NP, min_Cost] = Optimal_CNS(f,Cost,NPR)
%% Find the optimal CNS based on the offline design CNSs and the input navigation performance requirement
%  Input: f - The offline design CNSs
%         Cost - Communication cost of each relative measurement
%         NPR - The input navigation performance requirement
%  Output: Link - The actually used communication links
%          NP - Navigation performance of the optimal CNS
%          min_Cost - Communication cost of the optimal CNS

nn = size(f,1) - 1;
step = 0.01;

temp = find(f(end,:) <= NPR); % Find the optimal CNS
temp = temp(end);
opt_Cost = temp - 1;

min_Cost = (size(f,2) - 1 - opt_Cost) * step; % Calculate communication cost of the optimal CNS
NP = f(end, opt_Cost + 1); % Calculate navigation performance of the optimal CNS

Link = true(nn,1);
j = opt_Cost;
for i = nn : -1 : 1
    if f(i + 1, j + 1) ~= f(i, j + 1) % Determine whether agent j communicates with the selected agent
        Link(i) = false;
        j = j - Cost(i);
    end
end

end