function [rbf,Theta] = initializeRBF(mu)
% getRBF.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to create the vector of features for radial basis
% functions. This function is specific to the inverted pendulum problem.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Global memory:
global na;

%% Pre-processing:
% Get information on the number of radial basis functions:
nphi = 9;                               % no. radial basis functions
% Initialize output variable:
Theta = zeros(nphi,na);

%% Determine the position of the centre:
centre = zeros(nphi,2);
k = 0;
for i=1:3
    for j=1:3
        k = k + 1;
        centre(k,1) = (i-2)*pi/4;  % N.B.: fixed to speed up code
        centre(k,2) = (j-2)*1;
    end
end

%% Return output:
rbf.nphi   = nphi;
rbf.centre = centre;
rbf.width  = mu;

end