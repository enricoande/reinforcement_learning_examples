function [Q,N,S,V] = sarsa(states,actions,alp0,eps0,gamma,repeats,...
    episodes,steps)
% sarsa.m     E.Anderlini@ed.ac.uk     31/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to find the optimal policy for the inverted
% pendulum problem using Sarsa.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization:
% Initialize the input variables:
Q = zeros(length(states),length(actions));
N = zeros(size(Q));
% Initialize the output variables:
V = false(repeats,episodes);
S = zeros(repeats,episodes);

%% Running the main loop:
for i=1:repeats
%     rng(i);
    alpha = alp0;
    epsilon = eps0;
    for j=1:episodes
        [Q,N,tmp,l] = episode(Q,N,states,actions,alpha,epsilon,gamma,...
            steps);
        S(i,j) = tmp;
        V(i,j) = l;
        % Update the learning and exploration rates:
        alpha = alpha*0.99;
        epsilon = epsilon*0.99;
    end
end

end