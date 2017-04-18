function [Q,S,V] = qlearnFA(alp0,eps0,gamma,repeats,episodes,...
    steps)
% sarsaFA.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to find the optimal policy for the inverted
% pendulum problem using Q-learning with function approximation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Global variables to speed up code: - dangerous
global ns na statelist;

%% Initialization:
[rbf,Theta] = initializeRBF(1);
% Initialize the output variables:
Q = zeros(ns,na);      % Q-table
V = false(repeats,episodes);
S = zeros(repeats,episodes);

%% Running the main loop:
for i=1:repeats
    alpha = alp0;
    epsilon = eps0;
    for j=1:episodes
        [rbf,Theta,tmp,ef] = episodeFA(rbf,Theta,alpha,epsilon,gamma,...
            steps);
        S(i,j) = tmp;
        V(i,j) = ef;
        % Update the learning and exploration rates:
        alpha = alpha*0.99;
        epsilon = epsilon*0.99;
    end
end

%% Post-processing:
% Calculate the state-action value for the discrete states:
for s=1:ns
    phi = getPhi(statelist(s),rbf);
    Q(s,:) = getQ(Theta,phi,na);
end

end