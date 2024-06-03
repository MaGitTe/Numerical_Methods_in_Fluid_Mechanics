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
Ne = 0.1; % Neumann-Number
CFL_list = [0.5, 1, 10]; % Courant-Numbers

% 1.2 Numerical-solution-related parameters
[n, x, c0] = init(2); % Provided (on Stud.IP)

Nt = 200; % Total number of time points

dx = 1/(n-1); % Space discretization
dt = 1; % Time discretization

theta = 1; % Related to the time-descritization scheme
alpha_list = [0, 0.5, 1]; % Spacial-Schemes


%% 2. Solving our problem both numerically and analytically
fig = figure('Position', [200 100 1000 600]); % creating a figure to later on save it
Nplot = Nt;
k = 1;


% Looping over alpha
for j = 1:length(alpha_list)
    alpha = alpha_list(j);

    % Looping over CFL
    for i = 1:length(CFL_list)
        CFL = CFL_list(i);

         subplot(3, 3, k); % Creating a 3*3 subplot, and selecting the k-th one in each iteration
        
        % Numerical Solution c for Nt timesteps
        [c, tend] = transient_cyc(c0, x, dt, CFL, Ne, Nt, alpha, theta, Nplot);

        k = k+1;

    end

end

%% 3. Saving our figure as 'transient_river2.png': --------------------------- %

disp('Saving the figure as transient_river2.png...');
saveas(fig, 'transient_river2.png');

disp('Figured saved!');