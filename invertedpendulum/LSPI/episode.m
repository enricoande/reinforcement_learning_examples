function [policy,samples,i,ef] = episode(policy,samples,steps)
% episode.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs an episode of the LSPI algorithm for the gridworld
% problem. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Global memory:
global actionlist;

%% Initialization:
% Initialize the exit flag:
ef = false;
% Starting position:
x=[0,0];                         % starting position

%% Run the algorithm for the whole duration of the episode:
for i=2:steps
    % Select a new action using an epsilon-greedy policy:
    a = policy_function(policy,x);
       
    % Take the action and land in a new state:
    u = actionlist(a)+rand*20-10; % apply uniform noise to action selection 
    xp = updateMotions(x,u);      % new continuous state

    if abs(xp(1))<=pi/2
        % Set the reward for the current state:
        r = 0;
        
        % If the sample is not stored yet, add it to the samples list:
        sample = [x,a,r,xp];
        if isempty(samples)
            samples = [samples;sample];
        else
            if ~ismembertol(sample,samples,0.1,'ByRows',true)
                samples = [samples;sample];
            end
        end
    
    % If the pendulum falls, exit:
    else
        % Set the reward for the current state:
        r = -1;
        
        % If the sample is not stored yet, add it to the samples list:
        sample = [x,a,r,xp];
        if isempty(samples)
            samples = [samples;sample];
        else
            if ~ismembertol(sample,samples,0.1,'ByRows',true)
                samples = [samples;sample];
            end
        end
        
        % Set the exit flag to true:
        ef = true;
        
        % Exit the loop/function:
        break;  
    end
    
    % Update the state:
    x = xp;
end

end