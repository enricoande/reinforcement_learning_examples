function plotLearning(S,s,e)
% plotLearning.m     E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to plot the learning behaviour of the selected
% reinforcement learning algorithm.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get the mean and standard deviation:
m = mean(S,1);
% s = std(S,0,1);
c = (confidence_intervals(S,95))';
mi = min(S,[],1);
ma = max(S,[],1);

%% Plot the number of steps versus number of episodes:
% figure;
% errorbar(m,c(1,:));  %,c(2,:)
plot(m(s:e));
hold on;
plot(mi(s:e));
hold on;
plot(ma(s:e));
hold off;
xlabel('Number of episodes','Interpreter','Latex');
ylabel('Steps per episode','Interpreter','Latex');
l=legend('mean','best','worst','Location','Best');
set(l,'Interpreter','Latex');
set(gca,'TickLabelInterpreter','latex');
set(gcf,'color','w');

end