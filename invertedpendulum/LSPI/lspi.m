function [Q,S,V] = lspi(eps0,gamma,bt,repeats,episodes,...
    steps)
% lspi.m     E.Anderlini@ed.ac.uk     31/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to find the optimal policy for the inverted
% pendulum problem using LSPI.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Global memory:
global actionlist ns na;

%% Initialization:
% Set the basis function type:
if bt==1
    basis = 'basis_exact';
elseif bt==2
    basis = 'basis_rbf';
else
    error('At the moment, only options 1,2 supported');
end    

% Initialize the output variables:
V = false(repeats,episodes);
S = zeros(repeats,episodes);

%% Running the main loop:
for i=1:repeats
    epsilon = eps0;
    % Initialize the policy structure:
    policy = initialize_policy(actionlist,epsilon,gamma,basis);
    % Initialize list of samples:
    samples = [];
    for j=1:episodes
        [policy,samples,tmp,ef] = episode(policy,samples,steps);
        S(i,j) = tmp;
        V(i,j) = ef;
        % Update the weights with LSTDQ at predefined intervals:
        if mod(j,50)==0
            policy = lstdq(2,10,1e-5,samples,policy);
        end        
        % Update the exploration rate:
        epsilon = epsilon*0.999;
        policy.explore = epsilon;
    end
    disp(i);
end

%% Post-processing:
% Initialize the state-action value:
Q = zeros(ns,na);
% Calculate the state-action value for the discrete states:
for s=1:ns
    % Calculate the state-action values for the current state:
    for a=1:na
        Q(s,a) = Qvalue(s,a,policy);
    end
end

end