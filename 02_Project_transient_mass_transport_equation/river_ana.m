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

%% PART 1: Analytical Solution of advection-dispersion equation              %
% -------------------------------------------------------------------------- %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.


%% 1. Defining the parameters & variables: -------------------------------

% 1.1 Geometrical Parameters
w = 100; % [m] width of the solute
L_c = 100; % [m] center of the solute
L_r = 2000; % [m] total lenght of river

% 1.2 Flow Parameters
v = 0.1; % [m/s] mean flow velocity
D = 0.01; % [m^2/s] dispersion coefficient
c_ini = 1; % [kg/m^3] initial concentration of the solute

% 1.3 Scheme Parameters & variables
dx = 10; % [m] Grid size

x = 0:dx:L_r ; % Generating the x grid between 0 and L_r
t = [0, 6000, 12000]; % time t in [s] of interest

%% 2. Plotting the analytical solution: -------------------------------

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

for time = t
    
    [c_ana] = transient_ana(x, time, c_ini, w, L_c, v, D);
    
    plot(x, c_ana, 'x--', 'DisplayName', ['t = ' num2str(time) ' [s]'], 'LineWidth', 1.5)
    hold on;
    % Labeling our axis, adding legends, a title and a grid
    % Using the $ signs for LaTex formatting

    xlabel('$x [m]$');
    ylabel('$c(x, t) [mg/m^3] $');
    legend('Location', 'bestoutside');
    title('Analytical solution for different times t');
    grid;

end

%% 3. Saving our figure as 'river_ana.png': --------------------------- %

disp('Saving the figure as river_ana.png...');
saveas(fig, 'river_ana.png');

disp('Figured saved!');

