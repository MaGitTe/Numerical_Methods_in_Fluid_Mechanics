function [c, tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, del)
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
%   del: (func) 0, firstorder; 1, Lax Wendroff; 2 Superbee; 
%    
%   Nplot: (scalar) plotting interval

%   Output:
%   c:    (vector) [nx, 1] Approximate solution of c after Nt- time steps
%   tend: (scalar) Time of the last time step


%% 1. Setting up the system of equations
nx = length(c0); % Extracting the size of the initial condition c0

Pb = tridiagcyc(nx, -1, 1, 0);
Pf = tridiagcyc(nx, 0, -1, 1);
I = eye(nx);

Ob = pentadiagcyc(nx, -1, 1, 0, 0, 0);
Of = pentadiagcyc(nx, 0, -1, 1, 0, 0);



%% 2. Calculating c for each time step `n`
c = c0; % Initial concentration (@ n = 0)
n = 1;  % Initial time-step NOTE: To save last plot only: n = 1



while n <= Nt % break condition
    % Plotting the c at n every other `Nplot-plot
    % If Nplot == 3, the plot of every 3 time step will be shown only.
    if mod(n, Nplot) == 0
        t = n*dt; % Used for the legend
        
        plot(x, c, '--', 'DisplayName', ['Numerical @ t = ' num2str(t) ' [s]'], 'LineWidth', 1.0);
        
       
        
        hold on;
    end
    
    % Calculating c for each n-time-step
    if del == 0
        flux_delimiter = 0;
    end

    if del == 1
        flux_delimiter_p = Pf*c;
        flux_delimiter_m = Pb*c;
    end
    if del == 2
    
        Ap = minmod(2.* Pb*c, Pf*c);
        Bp = minmod(Pb*c, 2*Pf*c);
    
        Am = minmod(2.*Ob*c, Of*c);
        Bm = minmod(Ob*c, 2.*Of*c);
    
        deltaC_superbee_p = maxmod(Ap, Bp);
        deltaC_superbee_m = maxmod(Am, Bm);
    
        flux_delimiter = -(0.5*CFL*(1-CFL)*(deltaC_superbee_p - deltaC_superbee_m));
    end

    c = (I-CFL.*Pb)*c + flux_delimiter;

   
    n = n + 1; % Incrementing our time step
    
end

tend = Nt*dt; %time after last timestep

%plot attributes
xlabel('$x$');
ylabel('$c$');
% legend('Location', 'bestoutside');
grid;

end