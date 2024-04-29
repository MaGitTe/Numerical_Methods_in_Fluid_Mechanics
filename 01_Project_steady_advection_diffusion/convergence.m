% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 1:
% 1D stationary mass transport equation - FDM
% 
% Groupe 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

%% PART 2: Analytical & Numerical solution of the 1D mass transport equation %
% -------------------------------------------------------------------------- %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.



% 1.1 Defining the vector `x` and the number of points `n`: ------------- %
dx_list = [0.25, 0.125, 0.0625, 0.03125];

x_points = [0.25,0.5,0.75];

PeG = 1; % Peclet Grid number



%Boundary conditions
cL = 0;
cR = 1;

% 1.2 Expressing the analytical solution as an anonymous function: ------ %
f_ana = @(x, Pe) (exp(Pe * x) - 1)/(exp(Pe) - 1);

e_1 = zeros(1,length(dx_list));

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling
for j = 1:length(dx_list)
    dx = dx_list(j);
    n = 1/dx+1;
    disp(n);
    Pe = PeG/dx; % Peclet number from Peclet grid number

    [c_num, x_grid, PeG]  = ADEstationary(n, Pe, cL, cR); % numerical solution with n nodes (n=1/dx)
    c_ana = f_ana(x_points, Pe); % calling our anonymous function to evaluate c(x) analytically
    
    e_1(j) = norm(c_ana - c_num(0.25/dx +1:0.25/dx:end-0.25/dx)); % error of c_ana and c_num(slicing to get c_num at x_points)
    
end

plot(dx_list,e_1, 'o', 'color', 'red', 'LineWidth', 1.5)

% Labeling our axis, adding legends, a title and a grid
% Using the $ signs for LaTex formatting

xlabel('gridsize $dx$ [-]');
ylabel('error $e_1)$ [-]');
title(['convergence analysis']);
grid;
    



saveas(fig, 'convergence.png')
