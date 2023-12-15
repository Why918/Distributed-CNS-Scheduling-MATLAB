function q = NPmap(P)
%% Define the navigation performance function q()
%  Input: P - Error covariance of the state estimate
%  Output: q - The navigation performance function to be defined

% The smaller q is, the higher navigation performance is

q = sqrt(trace(P));
end