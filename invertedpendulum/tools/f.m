function dxdt = f(x,u,g,alpha,m,l)
% f.m     E.Anderlini@ed.ac.uk     18/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function returns the derivative of the state for the update.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dxdt = zeros(1,2);

dxdt(1) = x(2); 
tmp = g*sin(x(1))-alpha*m*l*x(2)^2*sin(2*x(1))/2-alpha*cos(x(1))*u;
dxdt(2) = tmp/(4*l/3-alpha*m*l*(cos(x(1)))^2);

end