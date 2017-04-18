function [rbf,Theta,N,i,ef] = episodeFA(rbf,Theta,N,states,actions,...
    markers,reward,alpha,epsilon,gamma,steps)
% episodeFA.m     E.Anderlini@ed.ac.uk     30/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs an episode of the Sarsa algorithm with function
% approximation for the gridworld problem. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization:
% Find the position of the maximum reward - i.e. final position:
[ropt,copt] = find(reward == max(reward(:)));
xopt = ropt-1;                              % x-coordinate of optimal point
yopt = copt-size(reward,2);                 % y-coordinate of optimal point
sopt = discretizeState([xopt,yopt],states); % optimal state
% Initialize the exit flag:
ef = false;
% Starting position:
x = [0,0];                                  % starting position
s = discretizeState(x,states);              % initial state
% Get the features for the current state:
phi = getPhi(x,rbf);
Q = getQ(Theta,phi,length(actions));
% Select an action:
a = eGreedy(Q,markers(s,:),epsilon);

for i=2:steps
    % Update the count on the current state-action pair:
    N(s,a) = N(s,a) + 1;
    
    % Calculate the reward for the current state:
    r = reward(s);         %getReward(reward(s));
    % Calculate change in weights:
    delta = r-Q(a);
    
    % Take the action and land in a new state:
    x = x + actions(a,:);
    sp = discretizeState(x,states);                  % new state

    % Get the features for the new state:
    phi = getPhi(x,rbf);
    Q = getQ(Theta,phi,length(actions));
    % Select a new action:
    ap = eGreedy(Q,markers(sp,:),epsilon);
    
    % Update the weight matrix:
    delta = delta + gamma * Q(ap);
    Theta(:,a) = Theta(:,a) + alpha*delta*phi;
    
    % If the optimal position is found, exit:
    if s==sopt && sp==sopt
        ef = true;
        break;  
    end
    
    % Update the state and action:
    s = sp;
    a = ap;
end

end