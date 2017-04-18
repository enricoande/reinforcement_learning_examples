function markers = getMarkers(statelist)
% markers.m    E.Anderlini@ed.ac.uk    05/03/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function marks every state as: lower boundary, normal point or upper
% boundary with respect to the x- and y-axes. This distinction is necessary
% in order to avoid the incorrect action selection later on.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


markers = zeros(length(statelist),1);
for i=1:length(statelist)
    switch statelist(i,1)      % x position
        case 0                     % left boundary
            markers(i,1) = 1;
        case max(statelist(:,1))   % right boundary 
            markers(i,1) = 2;
        otherwise                  % in-between value
            markers(i,1) = 3;
    end
    
    switch statelist(i,2)      % y-position
        case min(statelist(:,2))
            markers(i,2) = 1;      % lower boundary
        case 0
            markers(i,2) = 2;      % upper boundary
        otherwise
            markers(i,2) = 3;      % in-between value
    end
end


end