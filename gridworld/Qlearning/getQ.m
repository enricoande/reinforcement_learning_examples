function Q = getQ(Theta,phi,na)
% getQ.m     E.Anderlini@ed.ac.uk     30/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function returns the approximate state-action value function for
% linear approximation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Q:
Q = zeros(1,na);

% Calculate Q:
for a=1:na
    Q(a) = phi' * Theta(:,a);
end

end