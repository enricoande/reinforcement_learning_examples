 function statelist = buildStatelist(nx,ny)
% buildStatelist.m    E.Anderlini@ed.ac.uk    05/03/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function builds the statelist for a 2D maze with its origin at 0 and
% the points being located in the third quadrant.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ns = nx * ny;                       % no. states
x = [0:1:(nx-1)];
y = [-(ny-1):1:0];
statelist = zeros(ns,2);            % 2D states list

% The following order is necessary in order to have the states in the
% correct order for the vectorized form of the reward:
k = 0;
for i=1:ny
    for j=1:nx
        k = k + 1;
        statelist(k,1) = x(j);
        statelist(k,2) = y(i);
    end
end


end