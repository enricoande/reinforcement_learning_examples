function [samples,i,ef] = episode(net,samples,markers,reward,epsilon,steps)
% episode.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs an episode of the NFQ algorithm for the gridworld
% problem. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Global variables:
global na actionlist;

%% Initialization:
% Find the position of the maximum reward - i.e. final position:
[ropt,copt] = find(reward == max(reward(:)));
xopt = ropt-1;                              % x-coordinate of optimal point
yopt = copt-size(reward,2);                 % y-coordinate of optimal point
sopt = discretizeState([xopt,yopt]);        % optimal state
% Initialize the state-action value function:
Q = zeros(1,na);
% Initialize the exit flag:
ef = false;
% Starting position:
x=[0,0];                                    % starting position
s = discretizeState(x);                     % initial discrete state

%% Run the algorithm for the whole duration of the episode:
for i=2:steps
    % Calculate the reward for the current state:
    r = reward(s);
    
    % Calculate the action-value for the current state:
    for j=1:na
        Q(j) = net([x';actionlist(j,:)']);
    end
    % Select a new action using an epsilon-greedy policy:
    a = eGreedy(Q,markers(s,:),epsilon);
       
    % Take the action and land in a new state:
    xp = x+actionlist(a,:);
    sp = discretizeState(xp);                % new discrete state

    % If the sample is not stored yet, add it to the samples list:
    sample = [x';a;r;xp'];
    if isempty(samples)
        samples = [samples,sample];
    else
        if ~ismember(sample',samples','rows')
            samples = [samples,sample];
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