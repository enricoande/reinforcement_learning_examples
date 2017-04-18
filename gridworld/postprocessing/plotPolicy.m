function plotPolicy(Q,statelist,actionlist,R)
% plotPolicy.m     E.Anderlini@ed.ac.uk     30/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function plots the final policy of the selected reinforcement
% learning algorithm.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Find the final point:
% Obtaining the optimal position on the grid:
[ropt,copt] = find(R == max(R(:)));
xopt = ropt-1;           % x-coordinate of optimal point
yopt = copt-size(R,2);   % y-coordinate of optimal point

%% Get the data for the grid world plot:
% Find the number of rows and columns of R:
[r,c] = size(R);
[X,Y,U,V,Xgrid,Ygrid,Mgrid] = prepareOutput(Q,statelist,actionlist,r,c);

%% Plotting the grid world:
figure;
pcolor(Xgrid,Ygrid,Mgrid');
hold on;
quiver(X,Y,U,V,'m','Linewidth',3,'AutoScale','off');
hold on;
plot(xopt,yopt,'g.','Markersize',50);
hold off;
xlabel('x','Interpreter','Latex');
ylabel('y','Interpreter','Latex');
title('Discrete Q function','Interpreter','Latex');
% colormap('jet');
cb = colorbar;
ylabel(cb,'max(Q(s,a))','Interpreter','Latex');
set(gcf,'color','w');

end