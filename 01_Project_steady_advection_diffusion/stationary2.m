% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 1:
% 1D stationary mass transport equation - FDM
% 
% Groupe 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

%% PART 3: Numerical Implementation of the General Scheme                    %
% -------------------------------------------------------------------------- %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.

% Defining lists that will be later on used for plotting
legend_list = ["Forward", "Central", "Backward"];
color_list = ["red", "blue", "green"];
linestyle_list = ['x', 'o', '+'];

%% 1. Setting up our first variables, Boundary conditions & Grid points
Pe_list = [-10, -2, 0, 2, 10]; % Predefined list of Péclet numbers
alpha_list = [0, 0.5, 1]; % [0: forward, 0.5: central, 1: backward]

cL = 0; % Left BC
cR = 1; % Right BC

n = 11; % number of nodes


%% 2. Expressing the analytical solution as an anonymous function: ------ %
f_ana = @(x, Pe) (exp(Pe * x) - 1)/(exp(Pe) - 1);

%% 3. Plotting the analytical solution and  numerical solution for each Péclet number and each alpha: --------------------- %

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

for i = 1:length(Pe_list)

    subplot(length(Pe_list), 1, i); % Creating a 5*1 subplot, and selecting the i-th one in each iteration

    % Numerical Solution & Plot (with additional plotting features)
    for j = 1:length(alpha_list)

        [c_num, x, PeG]  = ADEstationary2(n, Pe_list(i), cL, cR, alpha_list(j));
        plot(x, c_num, [linestyle_list(j)], 'color', [color_list(j)], 'DisplayName', [legend_list(j)], 'LineWidth', 1.5);
        hold on;
    end

    % Analytical Solution & Plot (with additional plotting features)
    c_ana = f_ana(x, Pe_list(i)); % calling our anonymous function to evaluate c(x) at each Pe_i
    plot(x, c_ana, '--', 'color', 'black', 'DisplayName', 'analytical', 'LineWidth', 1.5);


    % Labeling our axis, adding legends, a title and a grid
    % Using the $ signs for LaTex formatting

    xlabel('$\hat{x}$ [-]');
    ylabel('$\hat{c}(\hat{x})$ [-]');
    legend('Location', 'bestoutside');
    title(['Pe = ' num2str(Pe_list(i))]);
    grid;
    

end

%% 4. Saving our figure as 'generalScheme.png': --------------------------- %

disp('Saving the figure as generalScheme.png...');
saveas(fig, 'generalScheme.png');

disp('Figured saved!');