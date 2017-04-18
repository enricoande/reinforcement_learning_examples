function [Q,N,S,V] = QlearningFA(states,actions,markers,R,alp0,eps0,gamma,...
    repeats,episodes,steps)
% sarsaFA.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to find the optimal policy for the gridworld
% problem using Q-learning with function approximation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization:
[rbf,Theta] = initializeRBF(states,actions,2,2);
% Initialize the output variables:
Q = zeros(length(states),length(actions));  % Q-table
N = zeros(size(Q,1),size(Q,2));      % no. visits to each state-action pair
V = false(repeats,episodes);
S = zeros(repeats,episodes);

%% Running the main loop:
for i=1:repeats
    alpha = alp0;
    epsilon = eps0;
    for j=1:episodes
        [rbf,Theta,N,tmp,ef] = episodeFA(rbf,Theta,N,states,actions,...
            markers,R,alpha,epsilon,gamma,steps);
        S(i,j) = tmp;
        V(i,j) = ef;
        % Update the learning and exploration rates:
        alpha = alpha*0.99;
        epsilon = epsilon*0.99;
    end
end

%% Post-processing:
% Calculate the state-action value for the discrete states:
for s=1:length(states)
    phi = getPhi(states(s),rbf);
    Q(s,:) = getQ(Theta,phi,length(actions));
end

end