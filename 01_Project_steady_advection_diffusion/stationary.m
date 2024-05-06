%% Numerical Methods in Fluid Mechanics | SoSe 2024
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

%% 1. Setting up Boundary conditions & Grid points

Pe_list = [-10, -2, 0, 2, 10]; % Predefined list of Péclet numbers

cL = 0; % Left BC
cR = 1; % Right BC

n = 20;

%% 2. Expressing the analytical solution as an anonymous function: ------ %
f_ana = @(x, Pe) (exp(Pe * x) - 1)/(exp(Pe) - 1);

%% 3. Plotting the analytical solution and  numerical solution for each Péclet number: --------------------- %

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

for i = 1:length(Pe_list)

    subplot(length(Pe_list), 1, i); % Creating a 5*1 subplot, and selecting the i-th one in each iteration
    
    % Numerical Solution & Plot (with additional plotting features)
    [c_num, x, PeG]  = ADEstationary(n, Pe_list(i), cL, cR); % Numerical Solution at each Pe_i
    plot(x,c_num, 'x', 'color', 'red', 'DisplayName', 'numerical', 'LineWidth', 1.5);
    
    hold on; 

    % Analytical Solution & Plot (with additional plotting features)
    c_ana = f_ana(x, Pe_list(i)); % Analytical  Solution at each Pe_i
    plot(x, c_ana, '--', 'color', 'black', 'DisplayName', 'analytical', 'LineWidth', 1.5); 
    

    % Labeling our axis, adding legends, a title and a grid
    % Using the $ signs for LaTex formatting

    xlabel('$\hat{x}$ [-]');
    ylabel('$\hat{c}(\hat{x})$ [-]');
    legend('Location', 'best');
    title(['Pe = ' num2str(Pe_list(i))]);
    grid;
    

end


%% 4. Saving our figure as 'numSolution.png': --------------------------- %

disp('Saving the figure as numSolution.png...');

saveas(fig, 'numSolution.png');

disp('Figured saved!');

