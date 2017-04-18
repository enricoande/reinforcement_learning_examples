function a = policy_function( policy, state )
% policy_function.m     E.Anderlini@ed.ac.uk     31/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function selects an action based on the current state using an
% epsilon-greedy exploration strategy.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Estimate the Q-function for the current state:
% Initialize the Q-values for the current state:
Q = zeros(policy.actions,1);
% Calculate the state-action values for the current state:
for a=1:policy.actions
    Q(a) = Qvalue(state,a,policy);
end

%% Apply an epsilon-greedy exploration policy:
a = eGreedy(Q,policy.explore);

end