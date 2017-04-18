function policy = initialize_policy(actions,explore,discount,basis)
% initialize_policy.m     E.Anderlini@ed.ac.uk     26/08/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function initializes the policy variable. It has been modified from
% original work from Duke University, whose disclaimer can be found below.
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

policy.explore  = explore;
policy.discount = discount;
policy.actions  = length(actions);
policy.basis    = basis;

% Obtaining the number of basis functions:
k = feval(basis);
% Initial weights:
policy.weights = zeros(k,1);  % Zeros
%policy.weights = ones(k,1);  % Ones
%policy.weights = rand(k,1);  % Random

end