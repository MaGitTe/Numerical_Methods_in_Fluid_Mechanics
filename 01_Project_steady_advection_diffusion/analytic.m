%% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 1:
% 1D stationary mass transport equation - FDM
% 
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473


%% PART 1: Analytical solution of the 1D mass transport equation           %
% ------------------------------------------------------------------------ %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.

Pe_list = [-10, -2, 0, 2, 10]; % Predefined list of Péclet numbers

%% 1. Defining the vector `x` and the number of points `n`: ------------- %
n = 100;
x = linspace(0, 1, n);

%% 2. Expressing the analytical solution as an anonymous function: ------ %
f_ana = @(x, Pe) (exp(Pe * x) - 1)/(exp(Pe) - 1);

%% 3. Plotting the solution for each Péclet number: --------------------- %

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

for i = 1:length(Pe_list)

    c = f_ana(x, Pe_list(i)); % calling our anonymous function to evaluate c(x) at each Pe_i

    % Plotting c(x), and setting a legend correspoding to the appropriate
    % Péclet number and LineWidth
    plot(x, c, 'DisplayName', ['Pe = ' num2str(Pe_list(i))], 'LineWidth', 1.2);

    % Labeling our axis, adding legends, a title and a grid
    % Using the $ signs for LaTex formatting

    xlabel('$\hat{x}$ [-]');
    ylabel('$\hat{c}(\hat{x})$ [-]');
    
    legend('Location', 'bestoutside');
    title("Variation of $\hat{c}(\hat{x})$ with respect to $\hat{x}$");
    grid;
    
    hold on; % Using hold to keep all the resutls within our figure

end


%% 4. Saving our figure as 'anaSolution.png': --------------------------- %

disp('Saving the figure as anaSolution.png...');
saveas(fig, 'anaSolution.png');

disp('Figured saved!');

