function [dxy, bool] = Distribution_Selected(XY, d_max, p)
%% 输出选定的载体
dxy = XY;
bool = 0;

x = find(XY(:,1) == p(1));
if ~any(x)
    return
end

for j = x'
    if XY(j,2) == p(2)
        bool = 1;
        break
    end
end

if bool == 0
    return
end

sxy = XY(j,:);
XY(j,:) = [];
temp = sxy - XY;
r = sqrt(temp(:,1).^2 + temp(:,2).^2);

num = r > d_max;
dxy = XY;
dxy(num,:) = [];

end