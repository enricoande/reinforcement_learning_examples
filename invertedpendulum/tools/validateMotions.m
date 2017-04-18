% validateMotions.m     E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is used to validate the model for the cart-pole.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
close all;

%% Input data:
dt = 0.1;
N = 20;

%% Initialization:
x = [0,0];
X = zeros(N,2);
t = zeros(N,1);

%% Run the simulation:
for i=2:20
    t(i) = (i-1)*dt;
    u = 0;
    x = updateMotions(x,u);
    X(i,:) = x;
end

%% Plot the results:
figure;
subplot(2,1,1);
plot(t,X(:,1));
ylabel('$\theta$ (rad)','Interpreter','Latex');
subplot(2,1,2);
plot(t,X(:,2),'Color',[0.8500,0.3250,0.0980]);
xlabel('$t$ (s)','Interpreter','Latex');
ylabel('$\dot{\theta}$ (rad/s)','Interpreter','Latex');
set(gcf,'color','w');