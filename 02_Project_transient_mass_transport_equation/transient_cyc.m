function [c, tend] = transient_cyc(c0, x, dt, CFL, Ne, Nt, alpha, theta, Nplot)
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 05.06.2024

% This function calculates the numerical solution of the advection-dispersion 
% equation with periodical Boundary conditions.

%   Input:
%   c0:  (vector) [nx, 1] Vector containing initial condition    
%   x:   (vector)  [nx, 1] Vector containing the coordinates of c
%   dt:  (scalar) Time step size
%   CFL: (scalar) Courant number
%   Ne:  (scalar) Neumann number
%   Nt:  (scalar) Number of time steps
%
%   alpha: (scalar) Parameter defining the spatial discretization (forward,
%   backwards, central)
%
%   theta: (scalar) Parameter dening the time discretization (explicit,
%   implicit, crank-nicolson)
%   Nplot: (scalar) plotting interval

%   Output:
%   c:    (vector) [nx, 1] Approximate solution of c after Nt- time steps
%   tend: (scalar) Time of the last time step



nx = length(c0); %number of nodes
K = tridiagcyc(nx,1,-2,1);
Pb = tridiagcyc(nx,-1,1,0);
Pf = tridiagcyc(nx,0,-1,1);
I = eye(nx);
Al = I - theta*(Ne*K - CFL*(alpha*Pb + (1-alpha)*Pf));
Ar = (1-theta)*(Ne*K - CFL*(alpha*Pb + (1-alpha)*Pf)) + I;

if theta > 0 % only inverse Al if needed (implicit and Cranck-Nicolson scheme)
    Al_inv = inv(Al);
end

n = 0; %timestep
c = c0;

while n < Nt % break condition
    % calculate c for n'th timestep
    if theta > 0 %implicit and Cranck-Nicolson scheme
        c = Al_inv * Ar * c;
    else %explicit
        c = Ar * c;
    end
   
    
    %Show c_n at every Nplot'th timestep
    disp(mod(Nplot+n,Nplot));
    if mod(Nplot+n,Nplot) == 0
        t = n*dt;
        plot(x,c, 'x--', 'DisplayName', ['t = ' num2str(t)], 'LineWidth', 1.5);
        hold on
    end

    n = n + 1; %next timestep
    
end
tend = Nt*dt;

xlabel('$x$');
ylabel('$c$');
legend('Location', 'bestoutside');
grid;

end