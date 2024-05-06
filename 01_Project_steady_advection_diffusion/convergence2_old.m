% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 1:
% 1D stationary mass transport equation - FDM
% 
% Groupe 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473


%% PART 5: Convergence Analysis                                              %
% -------------------------------------------------------------------------- %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.


%% 1. Setting up our first variables, Boundary conditions & Grid points

PeG = 1; % Peclet Grid number

cL = 0; % Left BC
cR = 1; % Right BC


%% 2. Defining the vector `x` and the number of points `n`: ------------- %

dx_list = [0.25, 0.125, 0.0625, 0.03125]; % Our test grid grid sizes

x = [0.25, 0.5, 0.75]; % Our points of interest

e_1 = zeros(1, length(dx_list)); % Initializing an Array of errors

%% 3. ...
dx = 0.25/32
n = 1/dx + 1;
Pe_fine = PeG/dx;
[c_num_fine, x_grid, PeG]  = ADEstationary(n, Pe_fine, cL, cR);
slicing_index = [0.25/dx + 1  :0.25/dx: n - 0.25/dx];
c_num_sliced = c_num_fine(slicing_index);


%% 4. Computing the deviation e1 for each grid size dx: --------------------- %

for j = 1:length(dx_list)

    dx = dx_list(j);
    Pe = PeG/dx; % Computing Péclet number from Péclet grid number
    

    % Implementing a slicing logic to only get the indices of interest
    n = 1/dx + 1;
    slicing_index = [0.25/dx + 1  :0.25/dx: n - 0.25/dx];

    % For example if dx = 0.125, n = 1/0.125 + 1 = 9, which means that our
    % nodes would be:
    % [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]

    % Since we are interessted in the nodes at the location x = [0.25, 0.5, 0.75], we are looking for
    % the indices that contains these values.

    % By slicing with [0.25/dx + 1  :0.25/dx: n - 0.25/dx] we get : [3 :2: 7]
    % Which represents the array of indices at the values x = [0.25, 0.5, 0.75]

    % Similarly, we do it for dx = 0.0625 -> slicing_index = [5 :4: 13]
    % And so on...

    %Numerical solution with n = 1/dx + 1 nodes
    [c_num, x_grid, PeG]  = ADEstationary(n, Pe, cL, cR);

    % Computing the deviationg e1 using the norm() function between the Analytical solution
    % and the sliced Numerical solution:
    e_1(j) = norm(c_num_sliced - c_num(slicing_index));    

end

%% 5. Plotting the deviationg e1 for each grid size dx:  --------------------- %

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

% Labeling our axis, adding legends, a title and a grid for each plot and
% Using the $ signs for LaTex formatting

% 5.1. Using plot():
subplot(2, 2, 1); % Creating a 2*2 subplot, selecting 1st
plot(dx_list, e_1, 'x--', 'color', 'black', 'LineWidth', 1.5);

xlabel('$\Delta x$ [-]');
ylabel('$e_1$ [-]');
title('Convergence analysis - using plot');
grid;

% 5.2. Using semilogx():
subplot(2, 2, 2);
semilogx(dx_list,e_1, 'x--', 'color', 'black', 'LineWidth', 1.5)
xlabel('$\Delta x$ [-]');
ylabel('$e_1$ [-]');
title('Convergence analysis - using semilogx');
grid;

% 5.3. Using semilogy():
subplot(2, 2, 3);
semilogy(dx_list,e_1, 'x--', 'color', 'black', 'LineWidth', 1.5)
xlabel('$\Delta x$ [-]');
ylabel('$e_1$ [-]');
title('Convergence analysis - using semilogy');
grid;

% 5.4. Using loglog():
subplot(2, 2, 4);
loglog(dx_list,e_1, 'x--', 'color', 'black', 'LineWidth', 1.5)
xlabel('$\Delta x$ [-]');
ylabel('$e_1$ [-]');
title('Convergence analysis - using loglog');
grid;


%% 6. Saving our figure as 'convergence2.png': --------------------------- %

disp('Saving the figure as convergence2.png...');
saveas(fig, 'convergence2_false.png');

disp('Figured saved!');
