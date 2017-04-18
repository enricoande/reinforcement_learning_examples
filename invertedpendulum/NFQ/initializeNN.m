function net = initializeNN(ilim,nh)
% initializeNN.m     E.Anderlini@ed.ac.uk     02/04/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function uses the Matlab Neural Networks Toolbox to generate a
% neural network for the 2D maze problem. The new Matlab functions are
% used instead of the obsolete 'newff'.
% Input:
% ilim:  limits on the states and action - for normalization;
% nh:    number of nodes in the hidden layer(s).;
% For further information:
% http://uk.mathworks.com/help/nnet/ug/create-configure-and-initialize-multilayer-neural-networks.html
% http://uk.mathworks.com/help/nnet/ug/neural-network-subobject-properties.html
% http://uk.mathworks.com/help/nnet/ref/network.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Choose LVM as a training algorithm:
net = feedforwardnet(nh,'trainlm'); %'trainrp' %'trainlm'
net.trainParam.epochs = 100;        % max. no. steps per update

%% Deactivate the help window to speed up code:
net.trainParam.showWindow = false;  % turning off the training window

%% Configure the neural network to 3 inputs (state & action) and 1 output:
net = configure(net,[0,1; 0,1; 0,1],[0,1]);
% Define the range of the input values:
net.inputs{1}.range = ilim;
% Get the neural network weights:
w = getwb(net);
nw = length(w);  % tot. no. weights in the NN - 
% (3+1)*nh(1)+(nh(1)+1)*nh(2)+...+(nh(2)+1)*no
% Set the neural network weights to random values:
net = setwb(net,0.01*rand(nw,1));

end