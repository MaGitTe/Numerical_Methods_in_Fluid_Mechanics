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

Nt = 20; % Total number of time points

dx = 1/(n-1); % Space discretization
dt = 1; % Time discretization

alpha = 1; % Related to the space-descritization scheme
theta = 1; % Related to the time-descritization scheme

% 1.3 Analytical solution parameters
v = CFL*dx/dt; % [m/s] Mean flow velocity
D = Ne*dx^2/dt; % [m^2/s] Dispersion


%% 2. Solving our problem both numerically and analytically
fig1 = figure; % creating a figure to later on save it
set(fig1, 'defaulttextinterpreter', 'latex') % enabling LaTex styling
Nplot = Nt;

% Numerical Solution c for Nt timesteps

%first order
[c_flux_first, tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, 0);

%second order
[c_flux_second tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, 1);

%superbee
[c_flux_sup, tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, 2);

%Minmod
[c_flux_sup, tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, 3);


%MC
[c_flux_MC, tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, 4);



% Analytical Solution c at t = tend
c_ana = transient_ana(x, tend, c_ini, w, L_c, v, D);


plot(x, c_ana, '-', 'Color', 'black', 'DisplayName', ['Analytical @ t = ' num2str(tend) ' [s]'], 'LineWidth', .5);
title(['Analytical solution vs Numerical solutions, Nt = ' num2str(Nt)] )
legend('Location', 'bestoutside');

%% 3. Saving our figure--------------------------- %

disp('Saving the figure as transient_compare.png...');
saveas(fig1, 'transient_compare.png');

disp('Figured saved!');
hold off;

%% 4. Analysing change of gauss curve with superbee --------------------------- %
fig2 = figure; % creating a figure to later on save it
set(fig2, 'defaulttextinterpreter', 'latex') % enabling LaTex styling
Nt = 100;
Nplot = Nt/4;

[n, x, c0] = init(1); % Provided (on Stud.IP), gaussian curve
plot(x,c0, 'DisplayName', 'initial')
hold on;
%superbee
[c_flux_sup, tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, 2);
[c_flux_MC, tend] = transient_pentacyc(c0, x, dt, CFL, Ne, Nt, Nplot, 4);
legend('Location', 'bestoutside');
disp('Saving the figure as gauss_superbee.png...');
saveas(fig1, 'gauss_superbee.png');

disp('Figured saved!');
hold off;



