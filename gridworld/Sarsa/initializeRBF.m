function [rbf,Theta] = initializeRBF(states,actions,spacing,mu)
% getRBF.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to create the vector of features for radial basis
% functions. Note that a uniform spacing is selected along the x- and
% y-axis.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Pre-processing:
% Get information on the number of radial basis functions:
nr = floor(max(states(:,1))/spacing)+1;     % no. rows
nc = floor(-min(states(:,2))/spacing)+1;    % no. columns
nphi = nr*nc;                               % no. radial basis functions
% Initialize output variable:
Theta = zeros(nphi,length(actions));

%% Determine the position of the centre:
centre = zeros(nphi,2);
k = 0;
for i=1:nr
    for j=1:nc
        k = k + 1;
        centre(k,1) = (i-1)*spacing;
        centre(k,2) = (nc-j)*(-spacing);
    end
end

%% Return output:
rbf.nphi   = nphi;
rbf.centre = centre;
rbf.width  = mu;

end