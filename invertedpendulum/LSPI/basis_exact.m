function phi = basis_exact(state,action)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% basis_exact.m     E.Anderlini@ed.ac.uk     11/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is taken from chain_basis_exact.m and has been modified for
% the application to the gridworld problem. The original description can be
% found hereafter.
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
% phi = chain_basis_exact(state, action)
%
% Computes indicator basis functions for each pair (state,action)
% There is no approximation in this case. This basis is equivalent
% to having a tabular representation of the Q-function. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define global and persistent memory to reduce computational cost:
global ns na;
persistent numbasis;

if isempty(numbasis)
    numbasis = ns*na;
end

%% Return the number of features if there are not enough input variables:
if nargin < 1
    phi = numbasis;
    return;
end

%% Otherwise, return the actual active feature:
phi = zeros(numbasis,1);

% Find the current discrete state:
s = discretizeState(state);

% Find the starting position of the block:
base = (action-1) * ns;

% Set the indicator:
phi(base+s) = 1;   

end