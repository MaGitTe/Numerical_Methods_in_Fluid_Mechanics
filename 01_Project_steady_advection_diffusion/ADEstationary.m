function [c, x, PeG] = ADEstationary(n, Pe, cL, cR)
% This function calculates the numerical solution for c [n*1] using the
% finite difference method of our given problem.

%   Input:
%   n:  (scaler) number of nodes
%   Pe: (scaler) Péclet number Pe
%   cL: (scaler) Boundary condition on the left-side
%   cR: (scaler) Boundary condotion on the right-side
%
%   Output:
%   c:   (vector) [n*1] Approximate solution of c using the FDM
%   x:   (vector) [n*1] Vector containing the coordinates of c
%   PeG: (scaler) [-]   Scaler representing the grid Péclet number


% 1. Generating the grid and calculating parameters:
x = linspace(0, 1, n); % Generating the x grid between 0 and 1 using linspace()

dx = 1/n;
PeG = Pe * dx;

% 2. Setting up the system of equations
u1_Pc = -1/2;
h_Pc = 0;
o1_Pc = 1/2;


Pc = tridiag(n, u1_Pc, h_Pc, o1_Pc);
Pc(1, 1) = 0;
Pc(n, n) = 0;
Pc(1, 2) = 0;
Pc(n, n-1) = 0;

u1_K = 1; 
h_K = -2;
o1_K = u1_K;


K = tridiag(n, u1_K, h_K, o1_K);
K(1, 1) = -1;
K(n, n) = -1;
K(1, 2) = 0;
K(n, n-1) = 0;

A = PeG * Pc - K;

% DEFINING A EXPLICITLY %%%%%%%%%
% u1_A = -Pe/(2 * dx) - 1/dx^2;
% h_A = 2/dx^2;
% o1_A = Pe/(2 * dx) - 1/dx^2;
% 
% A = tridiag(n, u1_A, h_A, o1_A);
% 
% A(1, 1) = 1;
% A(n, n) = 1;
% A(1, 2) = 0;
% A(n, n-1) = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defining rhs
rhs = zeros(n, 1);
rhs(1) = cL;
rhs(n) = cR;

% 3. Solving the system of equations
c = A\rhs;

end