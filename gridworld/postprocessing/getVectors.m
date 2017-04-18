function [U,V] = getVectors( I,actionlist )
% getVectors.m     E.Anderlini@ed.ac.uk     09/03/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to obtain the vectors of the policy plot based on
% the integer of the action corresponding to the maximum Q-value for each
% state. Both the cases of 5 actions (up,down,right,left) and 9 actions
% (King's moves) are treated.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


U = zeros(size(I));
V = zeros(size(I));
r = size(I,1);
c = size(I,2);
actionlist = actionlist/2;

for i=1:r
    for j=1:c
        U(i,j)=actionlist(I(i,j),1);
        V(i,j)=actionlist(I(i,j),2);
    end
end


end