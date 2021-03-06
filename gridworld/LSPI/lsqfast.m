function [w, A, b] = lsqfast(samples,policy,new_policy,firsttime,markers)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqfast.m     E.Anderlini@ed.ac.uk     25/08/2016
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
% [w, A, b] = lsqfast(samples, policy, new_policy, firsttime)
%
% Evaluates the "policy" using the set of "samples", that is, it
% learns a set of weights for the basis specified in new_policy to
% form the approximate Q-value of the "policy" and the improved
% "new_policy". The approximation is the fixed point of the Bellman
% equation.
%
% "firsttime" is a boolean to indicate whether this is the first
% time this set of samples is processed. Preprossesing of the set is
% triggered if "firstime"==true.
%
% Returns the learned weights w and the matrices A and b of the
% linear system Aw=b. 
%
% See also lsq.m for a slower (incremental) implementation. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

persistent Phihat;
persistent Rhat;
global statelist;

%% Initialize variables:
howmany = size(samples,1);
k = feval(new_policy.basis);
% A = zeros(k, k);
% b = zeros(k, 1);
PiPhihat = zeros(howmany,k);

%% Precompute Phihat and Rhat for all subsequent iterations:
if firsttime
    Phihat = zeros(howmany,k);
    Rhat = zeros(howmany,1);

    for i=1:howmany
        phi = feval(new_policy.basis, samples(i,1:2), samples(i,3));
        Phihat(i,:) = phi';
        Rhat(i) = samples(i,4);
    end
end

%% Loop through the samples:
for i=1:howmany
    % Find corresponding discrete state:
    sp = discretizeState(samples(i,5:6),statelist);
    % Compute the policy and the corresponding basis at the next state:
    nextaction = policy_function(policy, samples(i,5:6),markers(sp,:));
    nextphi = feval(new_policy.basis,samples(i,5:6),nextaction);
    PiPhihat(i,:) = nextphi';
end

%% Compute the matrices A and b:
A = Phihat' * (Phihat - new_policy.discount * PiPhihat);
b = Phihat' * Rhat;

%% Solve the system to find w:
rankA = rank(A);

% disp(['Rank of matrix A : ' num2str(rankA)]);
if rankA==k
%     disp('A is a full rank matrix!!!');
    w = A\b;
else
%     disp(['WARNING: A is lower rank!!! Should be ' num2str(k)]);
    w = pinv(A)*b;
end
  
end