function [Q,N,i,ef] = episode(Q,N,states,actions,alpha,epsilon,gamma,steps)
% episode.m     E.Anderlini@ed.ac.uk     31/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs an episode of the Q-learning algorithm with discrete
% states for the inverted pendulum problem. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization:
% Initialize the exit flag:
ef = false;
% Starting position:
x=[0,0];                         % starting position
s = discretizeState(x,states);   % initial state

for i=2:steps
    % Select an action:
    a = eGreedy(Q(s,:),epsilon);
    
    % Update the count on the current state-action pair:
    N(s,a) = N(s,a) + 1;
    
    % Take the action and land in a new state:
    u = actions(a)+rand*20-10;    % apply uniform noise to action selection 
    xp = updateMotions(x,u);         % new continuous state
    sp = discretizeState(xp,states); % new discrete state

    if abs(xp(1))<=pi/2
        % Set the reward for the current state:
        r = 0;

        % Select a new action:
        ap = eGreedy(Q(sp,:),epsilon);

        % Update the Q-table:
        Q(s,a) =  Q(s,a) + alpha * ( r + gamma*Q(sp,ap) - Q(s,a) );
    
    % If the pendulum falls, exit:
    else
        % Set the reward for the current state:
        r = -1;

        % Update the Q-table:
        Q(s,a) =  Q(s,a) + alpha * ( r + gamma*max(Q(sp,:)) - Q(s,a) );
        
        % Set the exit flag to true:
        ef = true;
        
        % Exit the loop/function:
        break;  
    end
    
    % Update the state:
    x = xp;
    s = sp;
end

end