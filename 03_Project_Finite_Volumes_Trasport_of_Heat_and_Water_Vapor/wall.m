%% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 3:
% Finite Volumes - Transport of Heat and Water Vapor
% 
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 19.06.2024

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.

%% PART 1: Building the A_T and A_P matrix                                 %
% ------------------------------------------------------------------------ %

L = 0.8; % [m] Total length
N = 80; % Descritizing into 80 Elements

% Building the A_T and A_P matrices for the first case:
[A1_T, x] = matrix(@f_lambda1, L, N);
[A1_P, x] = matrix(@f_mue1, L, N);

[A2_T, x] = matrix(@f_lambda2, L, N);
[A2_P, x] = matrix(@f_mue2, L, N);


%% PART 2: Boundary conditions                                         %
% ------------------------------------------------------------------------ %

T_inside = 25 + 273.15; % Temperature Inside [°K]
T_outside = 5 + 273.15; % Temperature Outside [°K]

phi_inside = 0.6;
phi_outside = 0.4;

p_sat_inside = 288.68 * (1.098 + (T_inside - 273.15)/100)^8.02;
p_sat_outside = 288.68 * (1.098 + (T_outside - 273.15)/100)^8.02;

P_inside = phi_inside * p_sat_inside;
P_outside = phi_outside * p_sat_outside;

T_rhs = zeros(N+2, 1);
P_rhs = zeros(N+2, 1);

T_rhs(1) = T_inside;
T_rhs(end) = T_outside;

P_rhs(1) = P_inside;
P_rhs(end) = P_outside;

%% PART 3: Calculating temperature and pressure distribution               %
% ------------------------------------------------------------------------ %

T1 = inv(A1_T) * T_rhs;
P1 = inv(A1_P) * P_rhs;

T2 = inv(A2_T) * T_rhs;
P2 = inv(A2_P) * P_rhs;

%% PART 4: Calculating partial pressure p_sat and relative air humidity phi along domain          %
% ------------------------------------------------------------------------ %

p_sat_func = @(T) 288.68 * (1.098 + (T-273.15)./100).^8.02; %function to calculate p_sat
phi_func = @(T, P) P ./ p_sat_func(T); %function to calculate phi

%case 1
p_sat1 = p_sat_func(T1);
phi1 = phi_func(T1, P1);

%case 2
p_sat2 = p_sat_func(T2);
phi2 = phi_func(T2, P2);

%% PART 5: Plotting distributions of T, p_sat and phi over domain for case 1 and case 2          %
% ------------------------------------------------------------------------ %

%case 1
fig1 = figure
set(fig1, 'defaulttextinterpreter', 'latex') % enabling LaTex styling
%Temperature
subplot(3,1,1);
plot(x,T1);
xlabel('$x$ [m]');
ylabel('$T$ [K]');

%p_sat
subplot(3,1,2);
plot(x, p_sat1)
xlabel('$x$ [m]');
ylabel('$p_{sat}$ [Pa]');

%phi
subplot(3,1,3);
plot(x,phi1)
yr = yregion(1,1.2, FaceColor="red", DisplayName='precipation'); %highlight area of percipation (phi>=1)
xlabel('$x$ [m]');
ylabel('$\phi$ [-]');
legend(yr);

sgtitle('Case 1')

disp('Saving the figure as case1.png...');
saveas(fig1, 'case1.png');

disp('Figure saved!');

%case 2
fig2 = figure
set(fig2, 'defaulttextinterpreter', 'latex') % enabling LaTex styling

%Temperature
subplot(3,1,1);
plot(x,T2);
xlabel('$x$ [m]');
ylabel('$T$ [K]');

%p_sat
subplot(3,1,2);
plot(x, p_sat2)
xlabel('$\Delta x$ [m]');
ylabel('$p_{sat}$ [Pa]');

%phi
subplot(3,1,3);
plot(x,phi2)
yr = yregion(1,1.2, FaceColor="red", DisplayName='precipation');  %highlight area of percipation (phi>=1)
xlabel('$x$ [m]');
ylabel('$\phi$ [-]');
legend(yr);

sgtitle('Case 2')

disp('Saving the figure as case2.png...');
saveas(fig2, 'case2.png');

disp('Figure saved!');



%% PART 4: Calculating p_sat and phi along the domain                      %
% ------------------------------------------------------------------------ %




%% PART 5: Displaying the results                                          %
% ------------------------------------------------------------------------ %