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

Pe_list = [-10, -2, 0, 2, 10]; % Predefined list of Péclet numbers

%Boundary conditions
cL = 0;
cR = 1;

% 1.1 Defining the vector `x` and the number of points `n`: ------------- %
n = 20;

% 1.2 Expressing the analytical solution as an anonymous function: ------ %
f_ana = @(x, Pe) (exp(Pe * x) - 1)/(exp(Pe) - 1);

% 2.3 Plotting the analytical solution and  numerical solution for each Péclet number: --------------------- %

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

for i = 1:length(Pe_list)

    
    [c_num, x, PeG]  = ADEstationary(n, Pe_list(i), cL, cR);
    c_ana = f_ana(x, Pe_list(i)); % calling our anonymous function to evaluate c(x) at each Pe_i
    
    subplot(length(Pe_list), 1, i)
    % Plotting c(x), and setting a legend correspoding to the appropriate Péclet number
    plot(x, c_ana, '--', 'color', 'black', 'DisplayName', 'analytical', 'LineWidth', 1.5);
    hold on;
    plot(x,c_num, 'o', 'color', 'red', 'DisplayName', 'numerical', 'LineWidth', 1.5);

    % Labeling our axis, adding legends, a title and a grid
    % Using the $ signs for LaTex formatting

    xlabel('$\hat{x}$ [-]');
    ylabel('$\hat{c}(\hat{x})$ [-]');
    legend('Location', 'best');
    title(['Pe = ' num2str(Pe_list(i))]);
    grid;
    

end


saveas(fig, 'numSolution.png')
