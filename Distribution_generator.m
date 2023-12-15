function xy = Distribution_generator(n)
%% Randomly generate geometric distributions of the multi-agent system
%  Input: n - Number of agents
%  Output: xy - 2-D coordinates of all the agents

r = 0;
while find(r == 0) % Determine whether the positions overlap
    xy = randi([0,400],n,2);
    for j = 1 : n - 1
        temp = j + 1 : n;
        dxy = xy(j,:) - xy(temp,:);
        r = dxy(:,1).^2 + dxy(:,2).^2; % Calculate the distance between agents
        if find(r == 0)
            break
        end
    end
end

end