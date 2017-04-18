function phi = basis_rbf(state, action)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% basis_rbf.m     E.Anderlini@ed.ac.uk     02/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is taken from chain_basis_rbf.m and has been modified
% extensively for use with the gridworld problem. The original
% description can be found hereafter.
%
% Copyright 2000-2002 
%
% Michail G. Lagoudakis (mgl@cs.duke.edu)
% Ronald Parr (parr@cs.duke.edu)
%
% Department of Computer Science
% Box 90129
% Duke University, NC 27708
% 
%
% phi = chain_basis_rbf(state, action)
%
% Computes a number of radial basis functions (on "state") with means
% spread uniformly over the chain. This block of basis functions is
% duplicated for each action. The "action" determines which segment
% will be active.
%
% For greater information on the use of radial basis functions with
% reinforcement learning or dynamic programming see:
% Geramifard, et al. (2013). 'A Tutorial on Linear Function Approximators
% for Dynamic Programming and Reinforcement Learning'. Foundations and 
% Trends in Machine Learning, Vol. 6, No. 4, pp. 418-419.
%
% N.B.: The design of the RBFs is fixed (i.e. their centres and width) in
% order to speed up the code.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Use global and persistent memory to speed up code:
global statelist na;
persistent centres mu nrbf nbasis;

% Initialize the position of the centres and the width of the RBFs:
if isempty(centres)
    spacing = 2;
    nr = floor(max(statelist(:,1))/spacing)+1;     % no. rows
    nc = floor(-min(statelist(:,2))/spacing)+1;    % no. columns
    nrbf = nr*nc;             % no. radial basis functions per action
    nbasis = (nrbf+1)*na;     % no. basis functions 
    mu = 2;                   % width of the RBFs 
    centres = zeros(nrbf,2);  % position of centres of the RBFs
    k = 0;
    for i=1:nr
        for j=1:nc
            k = k + 1;
            centres(k,1) = (i-1)*spacing;
            centres(k,2) = (nc-j)*(-spacing);
        end
    end
end

%% Return the number of features if there are not enough input variables:
if nargin < 1
    phi=nbasis;
    return;
end

%% Otherwise return the actual features:
phi = zeros(nbasis,1);

% Find the starting position:    - this is because the matrix Theta is
base = (action-1) * (nbasis/na); % converted into a line vector

% Compute the RBFs:
for i=1:nrbf
    phi(base+i) = exp(-norm(state-centres(i,:))^2/(2*mu));
end
% ... and the constant:
phi(base+nrbf+1) = 1;

end