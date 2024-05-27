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

%% PART 3: Analytical & Numerical solution of advection-dispersion equation          %
% -------------------------------------------------------------------------- %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.

%% 1. Defining the parameters for our calculations
% 1.1 Model/Flow parameters
CFL = 0.5; % Courant-Number
Ne = 0.1; % Neumann-Number

w = 0.5; % [m] width of the solute
c_ini = 1; % [kg/m^3] initial concentration of the solute
L_c = 0.5; % [m] center of the solute

% 1.2 Numerical-solution-related parameters
[n, x, c0] = init(2); % Provided (on Stud.IP)

Nt = 3; % Total number of time points

dx = 1/(n-1); % Space discretization
dt = 1; % Time discretization

alpha = 1; % Related to the space-descritization scheme
theta = 1; % Related to the time-descritization scheme

% 1.3 Analytical solution parameters
v = CFL*dx/dt; % [m/s] Mean flow velocity
D = Ne*dx^2/dt; % [m^2/s] Dispersion


%% 2. Solving our problem both numerically and analytically
fig = figure; % creating a figure to later on save it
Nplot = Nt;

% Numerical Solution c for Nt timesteps
[c, tend] = transient_cyc(c0, x, dt, CFL, Ne, Nt, alpha, theta, Nplot);

% Analytical Solution c at t = tend
c_ana = transient_ana(x, tend, c_ini, w, L_c, v, D);


plot(x, c_ana, '-', 'Color', 'black', 'DisplayName', ['Analytical @ t = ' num2str(tend) ' [s]'], 'LineWidth', 1.5);
title(['Analytical solution vs Numerical solution - Having Nt = ' num2str(Nt)] )

%% 3. Saving our figure as 'transientNt3.png' when needed: --------------------------- %

% disp('Saving the figure as transientNt3.png...');
% saveas(fig, 'transientNt3.png');

% disp('Figured saved!');