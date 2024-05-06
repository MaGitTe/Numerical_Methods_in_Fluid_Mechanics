function [c, x, PeG] = ADEstationary(n, Pe, cL, cR)
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

%% This function calculates the numerical solution for c [n, 1] using the
% finite difference method of our given problem.

%   Input:
%   n:  (scaler) number of nodes
%   Pe: (scaler) Péclet number Pe
%   cL: (scaler) Boundary condition on the left-side
%   cR: (scaler) Boundary condotion on the right-side
%
%   Output:
%   c:   (vector) [n, 1] Approximate solution of c using the FDM
%   x:   (vector) [n, 1] Vector containing the coordinates of c
%   PeG: (scaler) [-]   Scaler representing the grid Péclet number


%% 1. Generating the grid and calculating parameters:
x = linspace(0, 1, n); % Generating the x grid between 0 and 1 using linspace()

dx = 1/n;
PeG = Pe * dx;

%% 2. Setting up the system of equations [A]{c} = {rhs}

% 2.1 Defining the [Pc] matrix
% 2.1.1 Setting up the diagonals for [Pc] to then use the tridiag() function
u1_Pc = -1/2;
h_Pc = 0;
o1_Pc = 1/2;

Pc = tridiag(n, u1_Pc, h_Pc, o1_Pc);


% 2.1.2 Adjusting the elements of [Pc] to match the numerical scheme
Pc(1, 1) = 0;
Pc(n, n) = 0;
Pc(1, 2) = 0;
Pc(n, n-1) = 0;

% 2.2 Defining the [K] matrix
% 2.2.1 Setting up the diagonals for [K] to then use the tridiag() function
u1_K = 1; 
h_K = -2;
o1_K = 1;

K = tridiag(n, u1_K, h_K, o1_K);


% 2.2.2 Adjusting the elements of [K] to match the numerical scheme
K(1, 1) = -1;
K(n, n) = -1;
K(1, 2) = 0;
K(n, n-1) = 0;


% 2.3 Defining our matrix [A] = PeG*[Pc] - [K]
A = PeG * Pc - K;


% 2.4 Defining our right-hand-side {rhs} for the given BC
rhs = zeros(n, 1);
rhs(1) = cL;
rhs(n) = cR;


%% 3. Solving the system of equations {c} = [A]^(-1) * {rhs}
c = A\rhs;


end