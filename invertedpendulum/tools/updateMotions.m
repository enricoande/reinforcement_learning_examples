function xn = updateMotions(x0,u)
% updateMotions.m     E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the angular displacement and velocity at the
% next step using a fourth-oder Runge-Kutta discretization scheme.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Persistent memory is used for the parameters to speed up code:
persistent g alpha m l dt;
if isempty(g)
    g = 9.8;     % gravitational constant (m/s2)
    m = 2;       % mass of the pendulum (kg)
    M = 8;       % mass of the cart (kg)
    alpha = 1/(m+M);
    l = 0.5;     % pendulum length (m)
    dt = 0.1;    % time step (s)
end

%% Estimates of the ODE at different time steps (t,t+dt/2,t+dt):
dxdt1 = f(x0,u,g,alpha,m,l);
x1 = x0+dxdt1*dt/2;
dxdt2 = f(x1,u,g,alpha,m,l);
x2 = x0+dxdt2*dt/2;
dxdt3 = f(x2,u,g,alpha,m,l);
x3 = x0+dxdt3*dt;
dxdt4 = f(x3,u,g,alpha,m,l);

%% Estimate of the system at the next time step:
xn = x0 + (dxdt1+2*(dxdt2+dxdt3)+dxdt4)*dt/6; 

end