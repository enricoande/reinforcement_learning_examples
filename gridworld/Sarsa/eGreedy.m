function a = eGreedy( Q , marker, epsilon )
% eGreedy.m     E.Anderlini@ed.ac.uk     08/03/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to select a suitable action with an epsilon-greedy
% policy when only 5 actions are used.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r = rand;                    % generate a random number

%% Identifying any forbidden actions:
forbidden_actions = [];      % vector containing index of forbidden actions

switch marker(1)             % x-position
    case 1                   % min(x)
        forbidden_actions = [1];        % -dx
    case 2                   % max(x)
        forbidden_actions = [5];        % +dx
end

switch marker(2)             % y-position
    case 1                   % min(y)
        forbidden_actions = [forbidden_actions 4];   % -dy
    case 2                   % max(y)
        forbidden_actions = [forbidden_actions 2];   % +dy
end

%% Reducing the column of the Q-table to the allowed actions only:
if isempty(forbidden_actions)  % all actions allowed - normal state
     allowed_actions = [1 2 3 4 5];
     q = Q;                    % q:reduced Q-table (in this case, not reduced)
else 
    allowed_actions = [];      % vector containing index of allowed actions
    for i=1:5
        valid = true;
        for j=1:length(forbidden_actions)  % Identifying if the action is
            if forbidden_actions(j) == i   % allowed, i.e. valid, or not
                valid = false;
                break;                     % reduces the computational cost
            end
        end
        % If the action is valid, add it to the vector of allowed actions:
        if valid
            allowed_actions = [allowed_actions i];
        end
    end
    % Initialize the reduced Q-table column:
    q = [];
    for k=1:length(allowed_actions)
        q = [q Q(allowed_actions(k))];     % build the reduced Q-table
    end    
end

%% Select a suitable action using an epsilon-greedy strategy:
na = length(allowed_actions);

% Select the action that maximises Q(s)
if (r>epsilon)             
    [v a] = max(q);        % value, action 
% Choose a random action:
else                       
    a = randi(na);        % random integer based on a uniform distribution
end 
% Pick only from the allowed actions:
a = allowed_actions(a);

end