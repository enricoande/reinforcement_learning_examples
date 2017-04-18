function actionlist = buildActionlist(dB,dC)
% buildActionlist.m    E.Anderlini@ed.ac.uk    07/10/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function builds the action list for reactive control.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

actionB = [-dB 0 dB];
actionC = [dC 0 -dC];

k = 0;
for i=1:3
    for j=1:3
        k = k + 1;
        actionlist(k,1) = actionB(i);
        actionlist(k,2) = actionC(j);
    end
end


end