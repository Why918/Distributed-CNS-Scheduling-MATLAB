function xy = Distribution_generator(n)
%% 载体位置设置

r = 0;
while find(r == 0)
    xy = randi([0,400],n,2);
    for j = 1 : n - 1
        temp = j + 1 : n;
        dxy = xy(j,:) - xy(temp,:);
        r = dxy(:,1).^2 + dxy(:,2).^2;
        if find(r == 0)
            break
        end
    end
end

end