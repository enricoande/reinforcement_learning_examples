function s  = discretizeState( x, statelist )
% discretizeState.m    E.Anderlini@ed.ac.uk     08/06/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function outputs the entry in the state list that is closest to the
% current continuous states.
% x is a vector of dimensions (1 x n) and statelist a matrix of dimensions
% ((nw x nB) x n). For this simple discretization, the Eucledian distance 
% between the continuous states and each row of the states list is 
% calculated through an external function. Working with vectors and 
% matrices is much faster in Matlab, since their operations rely on 
% pre-compiled, quick C routines. Hence, the continuous states vector is 
% transformed in a matrix of dimensions ((nw x nB) x n) with an identical 
% entry for each row.
%
% Input:
% x:         vector of current continous states
% statelist: list of states
% Output:
% s:         entry of the states list closest to the current continuous
%            state
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copy the row vector entries (continuous states) to all rows:
x = repmat(x,size(statelist,1),1);
% Select the row corresponding to the minimum Eucledian distance:
[~,s] = min(edist(statelist,x));

end