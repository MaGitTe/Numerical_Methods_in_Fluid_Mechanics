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
alpha_list = [0,0.5,1];


% List for plots
legend_list = ["forward", "central", "backward"];
color_list = ["red", "blue", "green"];
linestyle_list = ['x', 'o', '+'];

%Boundary conditions
cL = 0;
cR = 1;

% 1.1 Defining the vector `x` and the number of points `n`: ------------- %
n = 11;
dx = 1/n;

% 1.2 Expressing the analytical solution as an anonymous function: ------ %
f_ana = @(x, Pe) (exp(Pe * x) - 1)/(exp(Pe) - 1);

% 2.3 Plotting the analytical solution and  numerical solution for each Péclet number: --------------------- %

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

for i = 1:length(Pe_list)

    
    x = linspace(0,1,n);
    c_ana = f_ana(x, Pe_list(i)); % calling our anonymous function to evaluate c(x) at each Pe_i
    
    subplot(length(Pe_list), 1, i)
    % Plotting c(x), and setting a legend correspoding to the appropriate Péclet number
    plot(x, c_ana, '--', 'color', 'black', 'DisplayName', 'analytical', 'LineWidth', 1.5);
    hold on;
    for j = 1:length(alpha_list)
        
        [c_num, x, PeG]  = ADEstationary2(n, Pe_list(i), cL, cR, alpha_list(j));
        plot(x,c_num, [linestyle_list(j)], 'color', [color_list(j)], 'DisplayName', [legend_list(j)], 'LineWidth', 0.7);
    end

    % Labeling our axis, adding legends, a title and a grid
    % Using the $ signs for LaTex formatting

    xlabel('$\hat{x}$ [-]');
    ylabel('$\hat{c}(\hat{x})$ [-]');
    legend('Location', 'bestoutside');
    title(['Pe = ' num2str(Pe_list(i))]);
    grid;
    

end


saveas(fig, 'generalscheme.png')

hold off

% 2.5 Stability analysis
PeG_list = [1,1.5,2,3];
alpha_list = [0, 0.5, 1];

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling
for i = 1:length(PeG_list)

    
    x = linspace(0,1,n);
    c_ana = f_ana(x, PeG_list(i)/dx); % calling our anonymous function to evaluate c(x) at each Pe_i
    
    subplot(length(PeG_list), 1, i)
    % Plotting c(x), and setting a legend correspoding to the appropriate Péclet number
    plot(x, c_ana, '--', 'color', 'black', 'DisplayName', 'analytical', 'LineWidth', 1.5);
    hold on;
    for j = 1:length(alpha_list)
        
        [c_num, x, PeG]  = ADEstationary2(n, PeG_list(i)/dx, cL, cR, alpha_list(j));
        plot(x,c_num, [linestyle_list(j)], 'color', [color_list(j)], 'DisplayName', [legend_list(j)], 'LineWidth', 0.7);
    end

    % Labeling our axis, adding legends, a title and a grid
    % Using the $ signs for LaTex formatting

    xlabel('$\hat{x}$ [-]');
    ylabel('$\hat{c}(\hat{x})$ [-]');
    legend('Location', 'bestoutside');
    title(['PeG = ' num2str(PeG_list(i))]);
    grid;
    

end


saveas(fig, 'stability_analysis.png')
