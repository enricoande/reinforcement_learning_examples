function qvalue = Qvalue(state, action, policy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Qvalue.m     E.Anderlini@ed.ac.uk     25/08/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function has been modified for real-time application in 1D maze
% problem. The original description can be found hereafter.
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
% qvalue = Qvalue(state, action, policy)
%   
% Returns Q^policy(state,action) = 
%             policy.basis(state,action)' * policy.weights
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


phi = feval(policy.basis, state, action);
qvalue = phi' * policy.weights;


end