%% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 3:
% Finite Volumes - Transport of Heat and Water Vapor
% 
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 19.06.2024

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.

L = 0.8; % [m] Total length
N = 5; % Descritizing into 80 Elements

%% PART 1 stationary initial state                                %
% ------------------------------------------------------------------------ %

% Building the A_T for stationary
[A1_T, x] = matrix(@f_lambda1, L, N);
T_inside_initial = 20 + 273.15; % Temperature Inside [°K]
%stationary boundary conditions
T_outside_initial = 20 + 273.15; % Temperature Outside [°K]
T_rhs_initial = zeros(N+2, 1);
T_rhs_initial(1) = T_inside_initial;
T_rhs_initial(end) = T_outside_initial;

T_initial = inv(A1_T) * T_rhs_initial;

%% PART 2 time dependent system                               %
% ------------------------------------------------------------------------ %

%setting up system of equations

cp = 1000;
dt = 1;

A = matrix_time(@f_lambda1, @f_rho1, L,N, dt, cp);
A_inv = inv(A);

T_inside = 20 + 273.15;
T_outside = -5 + 273.15;

T = T_initial;
T(1) = T_inside;
T(end) = T_outside;



%% PART 3 Calculating T for each time step `n`

Nt = 100;
Nplot = 10;
n=1;

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

while n <= Nt % break condition
    % Plotting the T at n every other `Nplot-plot
    % If Nplot == 3, the plot of every 3 time step will be shown only.
    if mod(n, Nplot) == 0
        t = n*dt; % Used for the legend
        
        plot(x, T - 273.15, '--', 'color', 'red', 'DisplayName', ['Numerical @ t = ' num2str(t) ' [s]'], 'LineWidth', 1.0);
        
        hold on;
    end
    
    % Calculating T for each n-time-step
    T = A_inv * T;
   
    n = n + 1; % Incrementing our time step
    
end

tend = Nt*dt; %time after last timestep

%plot attributes
xlabel('$x$');
ylabel('$T$');
legend('Location', 'bestoutside');
grid;

