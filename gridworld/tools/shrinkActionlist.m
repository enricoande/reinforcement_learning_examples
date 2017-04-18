function actions = shrinkActionlist( actionlist )
% shrinkActionlist.m     E.Anderlini@ed.ac.uk     08/03/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to shrink the action list to only 5 actions -
% removing king's moves (in chess).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


actions = zeros(5,2);
actions(1,:) = actionlist(2,:);
actions(2:4,:) = actionlist(4:6,:);
actions(5,:) = actionlist(8,:);


end