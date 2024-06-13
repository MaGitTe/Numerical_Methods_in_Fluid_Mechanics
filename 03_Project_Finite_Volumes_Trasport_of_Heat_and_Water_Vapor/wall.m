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

T_inside = 25; % Temperature Inside [°C]
T_outisde = 5; % Temperature Outside [°C]

% Building the A_T and A_P matrices for the first case:
A1_T = matrix(f_rho1, L, N);
A1_P = matrix(f_mue1, L, N);




%% PART 2: Calculating temperature and pressure distribution               %
% ------------------------------------------------------------------------ %
T_rhs = 
P_rhs = 



%% PART 3: Calculating p_sat and phi along the domain                      %
% ------------------------------------------------------------------------ %




%% PART 4: Displaying the results                                          %
% ------------------------------------------------------------------------ %