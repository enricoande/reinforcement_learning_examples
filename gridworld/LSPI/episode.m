function [policy,samples,i,ef] = episode(policy,samples,markers,reward,...
    steps)
% episode.m     E.Anderlini@ed.ac.uk     02/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs an episode of the LSPI algorithm for the gridworld
% problem. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set global memory to speed up code: - dangerous
global actionlist statelist na ns;

%% Initialization:
% Find the position of the maximum reward - i.e. final position:
[ropt,copt] = find(reward == max(reward(:)));
xopt = ropt-1;                              % x-coordinate of optimal point
yopt = copt-size(reward,2);                 % y-coordinate of optimal point
sopt = discretizeState([xopt,yopt],statelist); % optimal state
% Initialize the exit flag:
ef = false;
% Starting position:
x=[0,0];                                    % starting position
s = discretizeState(x,statelist);           % initial state

%% Run the algorithm for the whole duration of the episode:
for i=2:steps
    % Calculate the reward for the current state:
    r = reward(s);         %getReward(reward(s));
    
    % Selecting an action using an epsilon-greedy policy:
    a = policy_function(policy,x,markers(s,:));    % 5 actions
    
    % Take the action and land in a new state:
    xp = x + actionlist(a,:);                      % new state
    sp = discretizeState(xp,statelist);            % new discrete state
    
    % If the sample is not stored yet, add it to the samples list:
    sample = [x,a,r,xp];
    if isempty(samples)
        samples = [samples;sample];
    else
        if ~ismember(sample,samples,'rows')
            samples = [samples;sample];
        end
    end
    
    % If the optimal position is found, exit:
    if s==sopt && sp==sopt
        ef = true;
        break;  
    end
    
    % Update the state:
    x = xp;
    s = sp;
end

end