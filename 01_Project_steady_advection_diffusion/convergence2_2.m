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

e_1 = zeros(1, length(dx_list)-1);

%% 3. Calculate num soltion for dx=0.25
dx = dx_list(1);
n = 1/dx +1;
Pe = PeG/dx;

[c_num, x_grid, PeG] = ADEstationary(n, Pe,cL,cR);
slicing_index = [0.25/dx + 1  :0.25/dx: n - 0.25/dx];
c_num_x_i = c_num(slicing_index);
c_coarse = c_num_x_i;

%% 4. Loop: Calculate error e_1=norm(c_coarse(x_i) - c_num(x_i)) between solutions of adjacent gridscized (compare with more coarse gridsize)
for i= 2:(length(dx_list))
    dx = dx_list(i);
    n = 1/dx +1;
    Pe = PeG/dx;

    [c_num, x_grid, PeG] = ADEstationary(n, Pe,cL,cR);
    slicing_index = [0.25/dx + 1  :0.25/dx: n - 0.25/dx];
    c_num_x_i = c_num(slicing_index);
    e_1(i-1) = norm(c_coarse - c_num_x_i);

    c_coarse = c_num_x_i;
end

%% 5. Plot deviation of adjacent gridsizes against gridsize

fig = figure; % creating a figure to later on save it
set(fig, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

% Labeling our axis, adding legends, a title and a grid for each plot and
% Using the $ signs for LaTex formatting

% 5.1. Using plot():
subplot(2, 2, 1); % Creating a 2*2 subplot, selecting 1st
plot(dx_list(2:end),e_1, 'x--', 'color', 'black', 'LineWidth', 1.5);

xlabel('$\Delta x$ [-]');
ylabel('$e_1$ [-]');
title('Convergence analysis - using plot');
grid;

% 5.2. Using semilogx():
subplot(2, 2, 2);
semilogx(dx_list(2:end),e_1, 'x--', 'color', 'black', 'LineWidth', 1.5)
xlabel('$\log(\Delta x)$ [-]');
ylabel('$e_1$ [-]');
title('Convergence analysis - using semilogx');
grid;

% 5.3. Using semilogy():
subplot(2, 2, 3);
semilogy(dx_list(2:end),e_1, 'x--', 'color', 'black', 'LineWidth', 1.5)
xlabel('$\Delta x$ [-]');
ylabel('$\log(e_1)$ [-]');
title('Convergence analysis - using semilogy');
grid;

% 5.4. Using loglog():
subplot(2, 2, 4);
loglog(dx_list(2:end),e_1, 'x--', 'color', 'black', 'LineWidth', 1.5)
xlabel('$\log(\Delta x)$ [-]');
ylabel('$log(e_1)$ [-]');
title('Convergence analysis - using loglog');
grid;


%% 6. Saving our figure as 'convergence2.png': --------------------------- %

disp('Saving the figure as convergence2.png...');
saveas(fig, 'convergence2.png');

disp('Figured saved!');