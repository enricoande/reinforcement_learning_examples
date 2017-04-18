% invertedpendulum.m      E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is used to assess the performance of different reinforcement
% learning algorithms for the inverted pendulum problem.
% This problem, also known as cart-pole control problem, is a popular test
% of reinforcement learning algorithms, e.g. Sutton and Barto (2010),
% Lagoudakis (2003) and Riedmiller (2005), and control schemes alike, e.g.
% https://uk.mathworks.com/help/mpc/examples/control-of-an-inverted-pendulum-on-a-cart.html
% https://uk.mathworks.com/help/mpc/ug/gain-scheduled-mpc-control-of-an-inverted-pendulum-on-a-cart.html
% for model predictive control.
% N.B.: The purpose of this script is to show the effectiveness of LSPI in
% dealing with a small number of data points and the advantages of function
% approximation. For this reason, the same number of features has been
% used for both tabular and radial basis functions. A much larger number of
% discrete states would be required for convergence as shown in Geramifard
% (2013). Additionally, Sarsa and Q-learning with function approximation
% would need experience replay for convergence (Geramifard, 2013).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
close all;

%% Define global memory: - dangerous, but efficient
global statelist actionlist ns na;

%% Make the results reproducible:
rng(0);           % fixed seed for the random number generator

addpath('./tools');
%% Create the two-dimensional grid-world:
% Initialize the states list:
statelist = buildStatelist();
ns = length(statelist);
% Initialize the actions list:
actionlist = [-50,0,50];
na = length(actionlist);

%% Initialize the reinforcement learning paramters:
alpha = 0.4;                % learning rate
epsilon = 0.6;              % exploration rate
gamma = 0.95;               % discount factor
steps = 3000;               % no. of steps per episode
episodes = 1000;            % no. of episodes
repeats = 100;              % no. of repeats

%% Apply Sarsa to find the optimal policy:
% addpath('./Sarsa');
% tic;
% % Discrete, exact states:
% [Qsarsa,~,Ssarsa,Vsarsa] = sarsa(statelist,actionlist,alpha,epsilon,...
%     gamma,repeats,episodes,steps);
% save('data/sarsa.mat','Qsarsa','Ssarsa','Vsarsa');
load('data/sarsa.mat');
% toc;
% tic;
% % Radial basis functions:
% [QsarsaFA,SsarsaFA,VsarsaFA] = sarsaFA(alpha,epsilon,gamma,repeats,...
%     episodes,steps);
% save('data/sarsaFA.mat','QsarsaFA','SsarsaFA','VsarsaFA');
load('data/sarsaFA.mat');
% toc;
% rmpath('./Sarsa');

%% Apply Q-learning to find the optimal policy:
% addpath('./Qlearning');
% tic;
% % Discrete, exact states:
% [Qql,~ ,Sql,Vql] = qlearning(statelist,actionlist,alpha,epsilon,gamma,...
%     repeats,episodes,steps);
% save('data/ql.mat','Qql','Sql','Vql');
load('data/ql.mat');
% toc;
% tic;
% % Discrete, exact states:
% [QqlFA,SqlFA,VqlFA] = qlearnFA(alpha,epsilon,gamma,repeats,...
%     episodes,steps);
% save('data/qlFA.mat','QqlFA','SqlFA','VqlFA');
load('data/qlFA.mat');
% toc;
% rmpath('./Qlearning');

%% Apply LSPI to find the optimal policy:
% addpath('./LSPI');
% tic;
% % Tabular representation:
% [Qlspi,Slspi,Vlspi] = lspi(epsilon,gamma,1,repeats,episodes,steps);
% save('data/lspi.mat','Qlspi','Slspi','Vlspi');
load('data/lspi.mat');
% toc;
% tic;
% % Radial basis functions representation:
% [Qlspi_rbf,Slspi_rbf,Vlspi_rbf] = lspi(epsilon,gamma,2,repeats,episodes,...
%     steps);
% save('data/lspi_rbf.mat','Qlspi_rbf','Slspi_rbf','Vlspi_rbf');
load('data/lspi_rbf.mat');
% toc;
% rmpath('./LSPI');

%% Apply NFQ to find the optimal policy:
% addpath('./NFQ');
% tic;
% % Neural fitted Q-iteration:
% [Qnfq,Snfq,Vnfq] = nfq(epsilon,gamma,repeats,episodes,steps);
% save('data/nfq.mat','Qnfq','Snfq','Vnfq');
% toc;
% rmpath('./NFQ');

%% Post-processing:
addpath('./postprocessing');

% Plot the convergence behaviour:
plotRL(Ssarsa,SsarsaFA,Sql,SqlFA,Slspi,Slspi_rbf);
% figure;
% plotLearning(Snfq);

rmpath('./postprocessing');
rmpath('./tools');