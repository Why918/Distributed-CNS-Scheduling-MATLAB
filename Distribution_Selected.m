function [dxy, bool] = Distribution_Selected(XY, d_max, p)
%% Display the geometric distributions of the selected agent and its neighbors
%  Input: XY - 2-D coordinates of all the agents
%         d_max - Maximum communication distance
%         p - 2-D coordinates of the selected agent
%  Output: dxy - 2-D coordinates of the neighbors
%          bool - A logic variable to determine whether the selected agent exists          

dxy = XY;
bool = 0;

x = find(XY(:,1) == p(1)); % Find the agents that match coordinate X
if ~any(x)
    return
end

for j = x'
    if XY(j,2) == p(2) % Find the agent that match coordinate X,Y
        bool = 1;
        break
    end
end

if bool == 0 % If the selected agent does not exist, return
    return 
end

sxy = XY(j,:);
XY(j,:) = [];
temp = sxy - XY;
r = sqrt(temp(:,1).^2 + temp(:,2).^2);

num = r > d_max; % Remove the agents out of the maximum communication distance
dxy = XY;
dxy(num,:) = [];

end