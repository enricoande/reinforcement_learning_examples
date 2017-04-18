function [Q,S,V] = nfq(reward,markers,eps0,gamma,repeats,...
    episodes,steps)
% nfq.m     E.Anderlini@ed.ac.uk     02/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to find the optimal policy for the geidworld
% problem using NFQ.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Global variables: - very dangerous
global ns na statelist actionlist;

%% Initialization:
% Set the limits of the neural network inputs:
in_lim = [min(statelist(:,1)),max(statelist(:,1));...
    min(statelist(:,2)),max(statelist(:,2));-1,1;-1,1];
% Initialize the output variables:
V = false(repeats,episodes);
S = zeros(repeats,episodes);

%% Running the main loop:
for i=1:repeats
    % Initialize the neural network:
    net = initializeNN(in_lim,2);
    % Initialize the exploration rate:    
    epsilon = eps0;
    % Initialize list of samples:
    samples = [];
    for j=1:episodes
        [samples,tmp,ef] = episode(net,samples,markers,reward,epsilon,...
            steps);
        S(i,j) = tmp;
        V(i,j) = ef;
        % Update the weights with LSTDQ at predefined intervals:
        if mod(j,50)==0
            m = size(samples,2);
            Qp = zeros(na,m);
            for l=1:30
                for k=1:na
                    Qp(k,:) = net([samples(6:7,:);...
                        actionlist(k,1)*ones(1,m);...
                        actionlist(k,2)*ones(1,m)]);
                end

                % Setting the target:
                Qtarget = zeros(1,m);
                for k=1:m
                    Qtarget(k)=samples(5,k)+gamma*max(Qp(:,k));
                end

                % Train the neural network using LVM:
                net=train(net,samples(1:4,:),Qtarget);
            end
            clear Qp;
        end        
        % Update the exploration rate:
        epsilon = epsilon*0.99;
    end
end

%% Post-processing:
% Initialize the state-action value:
Q = zeros(ns,na);
% Calculate the state-action value for the discrete states:
for s=1:ns
    for a=1:na
        Q(s,a) = net([statelist(s,:)';actionlist(a,:)']);
    end
end

end