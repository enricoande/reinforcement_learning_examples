function [X,Y,U,V,Xgrid,Ygrid,Mgrid] = prepareOutput(Q,states,actions,r,c)
% prepareOutput.m     E.Anderlini@ed.ac.uk     09/03/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to prepare the data for the grid world plot,
% including the optimum location, policy and maximum Q-value for each
% state-action pair. An enlarged grid is also returned, since this is
% required for pcolor.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Obtaining the action corresponding to the maximum Q-value for each state:
[v i] = max(Q,[],2);
x = states(:,1);
y = states(:,2);
% Converting the vectors to matrices:
M = vec2mat(v,c);
I = vec2mat(i,c);
X = vec2mat(x,c);
Y = vec2mat(y,c);
clear x y i v;
% Creating position matrices of size (r+1)x(c+1) for pcolor plot:
xgrid = [-0.5:1:max(X(:))+0.5];
ygrid = [min(Y(:))-0.5:1:0.5];
[Xgrid,Ygrid] = meshgrid(xgrid,ygrid);
Xgrid = Xgrid;
Ygrid = Ygrid;
Mgrid = zeros(size(M,1)+1,size(M,2)+1);
Mgrid(1:r,1:c)=M;
Mgrid(end,:) = NaN;
Mgrid(:,end) = NaN;
clear xgrid ygrid;
% Determine the orientation of the vectors (policy) based on I:
[U,V] = getVectors(I,actions);

end