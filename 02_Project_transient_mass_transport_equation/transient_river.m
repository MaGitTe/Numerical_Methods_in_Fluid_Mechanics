%% Numerical Methods in Fluid Mechanics | SoSe 2024
% Assignment 2:
% 1D transient mass transport equation - analytical and numerical
% solutions (by using FDM)
% 
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 05.06.2024

%% Analytical & Numerical solution of advection-dispersion equation          %
% -------------------------------------------------------------------------- %

close all; % Closing all our current figures
clear; clc; % Clearing our Workspace and Command Window resp.

% parameter for analytical solution
c_ini = 1;
w = 0.5;
L_c = 0.5;


% generate initial condition and grid
[n x c0] = init(2);

dx = 1/(n-1);

%time discretization
Nt = 3;
dt = 1;

% model Parameters
CFL = 0.5;
Ne = 0.1;


v = CFL*dx/dt;
D = Ne*dx^2/dt;


% choice of scheme
alpha = 1;
theta = 1;



fig = figure;
% compute c numerically for Nt timesteps
Nplot = Nt;
[c, tend] = transient_cyc(c0,x,dt,CFL,Ne,Nt,alpha,theta,Nplot);
hold on;

% calculate analytical solution for c
c_ana = transient_ana(x, tend, c_ini, w, L_c, v, D);
plot(x, c_ana)