function [Q,S,V] = nfq(eps0,gamma,repeats,episodes,steps)
% nfq.m     E.Anderlini@ed.ac.uk     02/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to find the optimal policy for the inverted
% pendulum problem using NFQ.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization:
global ns na statelist actionlist;
% Set the limits of the neural network inputs:
in_lim = [-pi/2,pi/2;-2,2;-60,60];
% Initialize the output variables:
V = false(repeats,episodes);
S = zeros(repeats,episodes);

%% Running the main loop:
for i=1:repeats
    % Initialize the neural network:
    net = initializeNN(in_lim,[5,5]);
    % Initialize the exploration rate:    
    epsilon = eps0;
    % Initialize list of samples:
    samples = [];
    for j=1:episodes
        [net,samples,tmp,ef] = episode(net,samples,epsilon,steps);
        S(i,j) = tmp;
        V(i,j) = ef;
        % Update the weights with LSTDQ at predefined intervals:
        if mod(j,50)==0
            % Reset the weights of the neural network:
            w = getwb(net);
            nw = length(w); 
            net = setwb(net,0.01*rand(nw,1));
            m = size(samples,2);
            Qp = zeros(na,m);
            for l=1:30
                for k=1:na
                    Qp(k,:) = net([samples(5:6,:);...
                        actionlist(k)*ones(1,m)]);
                end

                % Setting the target:
                Qtarget = zeros(1,m);
                for k=1:m
                    Qtarget(k)=samples(4,k)+gamma*max(Qp(:,k));
                end

                % Train the neural network using LVM:
                net=train(net,samples(1:3,:),Qtarget);
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
        Q(s,a) = net([statelist(s,:)';actionlist(a)]);
    end
end

end