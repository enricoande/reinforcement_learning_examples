function [rbf,Theta,i,ef] = episodeFA(rbf,Theta,alpha,epsilon,gamma,...
    steps)
% episodeFA.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs an episode of the Q-learning algorithm with function
% approximation for the inverted pendulum problem. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Global variables:
global na actionlist;   %statelist actionlist;

%% Initialization:
% Initialize the exit flag:
ef = false;
% Starting position:
x=[0,0];                         % starting position
% Get the features for the current state:
phi = getPhi(x,rbf);
Q = getQ(Theta,phi,na);

for i=2:steps 
    % Select an action:
    a = eGreedy(Q,epsilon);
    % Take the action and land in a new state:
    u = actionlist(a)+rand*20-10;    % apply uniform noise to action selection 
    xp = updateMotions(x,u);         % new continuous state
    
    if abs(xp(1))<=pi/2
        % Set the reward for the current state:
        r = 0;
        % Calculate change in weights:
        delta = r-Q(a);

        % Get the features for the new state:
        phi = getPhi(x,rbf);
        Q = getQ(Theta,phi,na);

        % Update the weight matrix:
        delta = delta + gamma * max(Q);
        Theta(:,a) = Theta(:,a) + alpha*delta*phi;
    
    % If the pendulum falls, exit:
    else
        % Set the reward for the current state:
        r = -1;
        % Calculate change in weights:
        delta = r-Q(a);
        
        % Get the features for the new state:
        phi = getPhi(x,rbf);
        Q = getQ(Theta,phi,na);

        % Update the weight matrix:
        delta = delta + gamma * max(Q);
        Theta(:,a) = Theta(:,a) + alpha*delta*phi;
        
        % Set the exit flag to true:
        ef = true;
        
        % Exit the loop/function:
        break;  
    end
    
    % Update the state and action:
    x = xp;
end

end