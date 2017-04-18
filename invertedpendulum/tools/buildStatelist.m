function statelist = buildStatelist()
% buildStatelist.m    E.Anderlini@ed.ac.uk    18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function builds the statelist for the inverted pendulum problem.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Input data:
% State variables:
theta = (-pi/4:pi/4:pi/4);
theta_dot = (-1:1:1);
% No. discrete values:
nt  = length(theta);
ndt = length(theta_dot);
ns = nt*ndt;

%% Initialize the states list:
statelist = zeros(ns,2); 

%% Create the states list:
k = 0;
for i=1:nt
    for j=1:ndt
        k = k + 1;
        statelist(k,1) = theta(i);
        statelist(k,2) = theta_dot(j);
    end
end

end