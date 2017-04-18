function phi = getPhi(state,rbf)
% getPhi.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function returns the features for the current state with radial
% basis functions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize output variable:
phi = zeros(rbf.nphi,1);

for i=1:rbf.nphi
    phi(i) = exp(-norm(state-rbf.centre(i,:))^2/(2*rbf.width));
end

end