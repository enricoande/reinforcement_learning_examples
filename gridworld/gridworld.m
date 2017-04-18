% gridworld.m      E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is used to assess the performance of different reinforcement
% learning algorithms for a two-dimensional gridworld problem.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
close all;

%% Allocate global memory to speed up code: - dangeours
global statelist actionlist ns na;

%% Create the two-dimensional grid-world:
% Add the directory with the functions to the current path:
addpath('./tools');
% Reward function:
R = zeros(7,5);
R(5,3) = 1;
% Initialize the states list:
statelist = buildStatelist(size(R,1),size(R,2));
% Mark the position of all states for the application of constraints:
markers = getMarkers(statelist);
% Initialize the actions list:
actionlist = buildActionlist(1,1);
actionlist = shrinkActionlist(actionlist);       % reducing number of actions to 5 to aid convergence
% Store the number of states and actions:
ns = length(statelist);
na = length(actionlist);  % very dangerous
% Remove the directory with the functions to the current path:
rmpath('./tools');

%% Initialize the reinforcement learning paramters:
alpha = 0.4;                % learning rate
epsilon = 0.6;              % exploration rate
gamma = 0.95;               % discount factor
steps = 5000;               % no. of steps per episode
episodes = 1000;            % no. of episodes
repeats = 100;              % no. of repeats

%% Apply Sarsa to find the optimal policy:
% % addpath('./Sarsa');
% % tic;
% % % Discrete, exact states:
% % [Qsarsa,~,Ssarsa,Vsarsa] = Sarsa(statelist,actionlist,markers,R,...
% %     alpha,epsilon,gamma,repeats,episodes,steps);
% % save('data/sarsa.mat','Qsarsa','Ssarsa','Vsarsa');
load('data/sarsa.mat');
% % toc;
% % tic;
% % % Radial basis functions:
% % [QsarsaFA,~,SsarsaFA,VsarsaFA] = SarsaFA(statelist,actionlist,...
% %     markers,R,alpha,epsilon,gamma,repeats,episodes,steps);
% % save('data/sarsaFA.mat','QsarsaFA','SsarsaFA','VsarsaFA');
load('data/sarsaFA.mat');
% % toc;
% % rmpath('./Sarsa');

%% Apply Q-learning to find the optimal policy:
% % addpath('./Qlearning');
% % tic;
% % % Discrete, exact states:
% % [Qql,~ ,Sql,Vql] = Qlearning(statelist,actionlist,markers,R,alpha,...
% %     epsilon,gamma,repeats,episodes,steps);
% % save('data/ql.mat','Qql','Sql','Vql');
load('data/ql.mat');
% % toc;
% % tic;
% % % Radial basis functions:
% % [QqlFA,~,SqlFA,VqlFA] = QlearningFA(statelist,actionlist,...
% %     markers,R,alpha,epsilon,gamma,repeats,episodes,steps);
% % save('data/qlFA.mat','QqlFA','SqlFA','VqlFA');
load('data/qlFA.mat');
% % toc;
% % rmpath('./Qlearning');

%% Apply LSPI to find the optimal policy:
% addpath('./LSPI');
% tic;
% % Tabular representation:
% [Qlspi,Slspi,Vlspi] = lspi(markers,R,epsilon,gamma,1,repeats,episodes,...
%     steps);
% save('data/lspi.mat','Qlspi','Slspi','Vlspi');
% toc;
load('data/lspi.mat');
% tic;
% % Radial basis functions representation:
% [Qlspi_rbf,Slspi_rbf,Vlspi_rbf] = lspi(markers,R,epsilon,gamma,2,...
%     repeats,episodes,steps);
% save('data/lspi_rbf.mat','Qlspi_rbf','Slspi_rbf','Vlspi_rbf');
% toc;
load('data/lspi_rbf.mat');
% rmpath('./LSPI');

%% Apply NFQ to find the optimal policy:
% addpath('./NFQ');
% tic;
% % Neural fitted Q-iteration:
% [Qnfq,Snfq,Vnfq] = nfq(R,markers,epsilon,gamma,repeats,episodes,steps);
% save('data/nfq.mat','Qnfq','Snfq','Vnfq');
% toc;
% rmpath('./NFQ');

%% Post-processing:
addpath('./postprocessing');
% Plot the final policy to check for convergence:
% plotPolicy(Qsarsa,statelist,actionlist,R);
% plotPolicy(Qql,statelist,actionlist,R);
% plotPolicy(QsarsaFA,statelist,actionlist,R);
% plotPolicy(QqlFA,statelist,actionlist,R);
% plotPolicy(Qlspi,statelist,actionlist,R);
% plotPolicy(Qlspi_rbf,statelist,actionlist,R);
% plotPolicy(Qnfq,statelist,actionlist,R);

% Plot the convergence behaviour:
plotRL(Ssarsa,SsarsaFA,Sql,SqlFA,Slspi,Slspi_rbf);

% figure;
% plotLearning(Snfq);

rmpath('./postprocessing');