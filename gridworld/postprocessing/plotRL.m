function plotRL(Ssarsa,SsarsaFA,Sql,SqlFA,Slspi,Slspi_rbf)
% plotRL.m     E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to visualize the learning behaviour of the
% different algorithms in the same figure.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
subplot(3,2,1);
plotLearning(Ssarsa,1,40);
title('\textbf{Sarsa - discrete states}','Interpreter','Latex');
subplot(3,2,2);
plotLearning(SsarsaFA,1,600);
title('\textbf{Sarsa - radial basis functions}','Interpreter','Latex');
subplot(3,2,3);
plotLearning(Sql,1,40);
title('\textbf{Q-learning - discrete states}','Interpreter','Latex');
subplot(3,2,4);
plotLearning(SqlFA,1,300);
title('\textbf{Q-learning - radial basis functions}','Interpreter','Latex');
subplot(3,2,5);
plotLearning(Slspi,1,400);
title('\textbf{LSPI - discrete states}','Interpreter','Latex');
subplot(3,2,6);
plotLearning(Slspi_rbf,1,600);
title('\textbf{LSPI - radial basis functions}','Interpreter','Latex');
set(gcf,'color','w');

end