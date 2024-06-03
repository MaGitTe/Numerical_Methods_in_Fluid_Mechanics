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
%   c0:  (vector) [1, nx] Vector containing initial condition    
%   x:   (vector)  [1, nx] Vector containing the coordinates of c
%   dt:  (scalar) Time step size
%   CFL: (scalar) Courant number
%   Ne:  (scalar) Neumann number
%   Nt:  (scalar) Number of time steps
%
%   alpha: (scalar) Parameter defining the spatial discretization (forward,
%   backwards, central)
%
%   theta: (scalar) Parameter dening the time discretization (explicit = 0,
%   implicit = 1, crank-nicolson = 0.5)
%   Nplot: (scalar) plotting interval

%   Output:
%   c:    (vector) [nx, 1] Approximate solution of c after Nt- time steps
%   tend: (scalar) Time of the last time step


%% 1. Setting up the system of equations
nx = length(c0); % Extracting the size of the initial condition c0

K = tridiagcyc(nx, 1, -2, 1);
Pb = tridiagcyc(nx, -1, 1, 0);
Pf = tridiagcyc(nx, 0, -1, 1);
I = eye(nx);

Al = I - theta*(Ne*K - CFL*(alpha*Pb + (1-alpha)*Pf));
Ar = (1-theta)*(Ne*K - CFL*(alpha*Pb + (1-alpha)*Pf)) + I;


%% 2. Calculating c for each time step `n`
c = c0; % Initial concentration (@ n = 0)
n = 1;  % Initial time-step NOTE: To save last plot only: n = 1



while n <= Nt % break condition
    % Plotting the c at n every other `Nplot-plot
    % If Nplot == 3, the plot of every 3 time step will be shown only.
    if mod(n, Nplot) == 0
        t = n*dt; % Used for the legend
        
        plot(x, c, '--', 'color', 'red', 'DisplayName', ['Numerical @ t = ' num2str(t) ' [s]'], 'LineWidth', 1.0);
        
       
        
        hold on;
    end
    
    % Calculating c for each n-time-step
    if theta > 0
        % Inversing Al only when having theta == 0.5 or 1.0
        % i.e. for Implicit & Crank-nicolson scheme only.
        Al_inv = inv(Al);
        c = Al_inv * Ar * c;

    else
        % Explicit time scheme (theta = 0)
        c = Ar * c;
    end
   
    n = n + 1; % Incrementing our time step
    
end

tend = Nt*dt; %time after last timestep

%plot attributes
xlabel('$x$');
ylabel('$c$');
% legend('Location', 'bestoutside');
grid;

end