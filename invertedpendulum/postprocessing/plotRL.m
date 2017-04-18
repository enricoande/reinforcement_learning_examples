function plotRL(Ssarsa,SsarsaFA,Sql,SqlFA,Slspi,Slspi_rbf)
% plotRL.m     E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to visualize the learning behaviour of the
% different algorithms in the same figure.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
subplot(3,2,1);
plotLearning(Ssarsa);
title('\textbf{Sarsa - discrete states}','Interpreter','Latex');
subplot(3,2,2);
plotLearning(SsarsaFA);
title('\textbf{Sarsa - radial basis functions}','Interpreter','Latex');
subplot(3,2,3);
plotLearning(Sql);
title('\textbf{Q-learning - discrete states}','Interpreter','Latex');
subplot(3,2,4);
plotLearning(SqlFA);
title('\textbf{Q-learning - radial basis functions}','Interpreter','Latex');
subplot(3,2,5);
plotLearning(Slspi);
title('\textbf{LSPI - discrete states}','Interpreter','Latex');
subplot(3,2,6);
plotLearning(Slspi_rbf);
title('\textbf{LSPI - radial basis functions}','Interpreter','Latex');
set(gcf,'color','w');

end