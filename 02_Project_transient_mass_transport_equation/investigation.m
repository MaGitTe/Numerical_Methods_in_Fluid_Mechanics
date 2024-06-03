%% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 2:
% 1D transient mass transport equation - analytical and numerical
% solutions (by using FDM)
% 
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 05.06.2024

%% PART *: Analytical & Numerical solution of advection-dispersion equation          %
% -------------------------------------------------------------------------- %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.

%% 1. Defining the parameters for our calculations
% 1.1 Model/Flow parameters
Ne = 0.0; % Neumann-Number
CFL_list = [0.5, 1, 11]; % Courant-Numbers

% 1.2 Numerical-solution-related parameters
[n, x, c0] = init(2); % Provided (on Stud.IP)

Nt = 30; % Total number of time points

dx = 1/(n-1); % Space discretization
dt = 1; % Time discretization

theta = 0.0; % Related to the time-descritization scheme
% theta = 0 -> Explicit
% theta = 1 -> Implicit
% theta = 0.5 -> Crank-nicolson

alpha_list = [0, 0.5, 1]; % Spacial-Schemes
% alpha = 0 -> Forwards
% alpha = 1 -> Backwards
% alpha = 0.5 -> Central

%% 2. Solving our problem both numerically and analytically
fig = figure('Position', [200 100 1000 600]); % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling
Nplot = Nt;
k = 1;


% Looping over CFL
for j = 1:length(CFL_list)
     CFL = CFL_list(j);

    % Looping over alpha
    for i = 1:length(alpha_list)
        alpha = alpha_list(i);

         subplot(3, 3, k); % Creating a 3*3 subplot, and selecting the k-th one in each iteration
        
        % Numerical Solution c for Nt timesteps
        [c, tend] = transient_cyc(c0, x, dt, CFL, Ne, Nt, alpha, theta, Nplot);
        
        title(['CFL=' num2str(CFL) ' and alpha=' num2str(alpha)])
        k = k+1;

    end

end
