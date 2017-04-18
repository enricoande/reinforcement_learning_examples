function [Q,N,i,ef] = episode(Q,N,states,actions,markers,reward,alpha,...
    epsilon,gamma,steps)
% episode.m     E.Anderlini@ed.ac.uk     30/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs an episode of the Sarsa algorithm with discrete
% states for the gridworld problem. 
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
x=0; y=0;                            % starting position
s = discretizeState([x,y],states);   % initial state
na = length(actions);
% Select an action:
a = eGreedy(Q(s,:),markers(s,:),epsilon);

for i=2:steps
    % Update the count on the current state-action pair:
    N(s,a) = N(s,a) + 1;
    
    % Calculate the reward for the current state:
    r = reward(s);         %getReward(reward(s));
    
    % Take the action and land in a new state:
    x = x + actions(a,1);
    y = y + actions(a,2);
    sp = discretizeState([x,y],states);                  % new state

    % Select a new action:
    ap = eGreedy(Q(sp,:),markers(sp,:),epsilon);
    
    % Update the Q-table:
    Q(s,a) =  Q(s,a) + alpha * ( r + gamma*Q(sp,ap) - Q(s,a) );
    
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