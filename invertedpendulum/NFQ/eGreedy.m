function a = eGreedy( Q, epsilon )
% eGreedy.m     E.Anderlini@ed.ac.uk     31/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to select a suitable action with an epsilon-greedy
% policy and no constraints.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r = rand;                  % generate a random number

%% Select a suitable action using an epsilon-greedy strategy:
na = size(Q,2);            % no. actions

% Select the action that maximises Q(s)
if (r>epsilon)             
    [~,a] = max(Q);        % value, action 
% Choose a random action:
else                       
    a = randi(na);         % random integer based on a uniform distribution
end

end