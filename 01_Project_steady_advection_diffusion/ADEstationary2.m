function [c, x, PeG] = ADEstationary2(n, Pe, cL, cR,alpha)
% This function calculates the numerical solution for c [n*1] using the
% finite difference method of our given problem.

%   Input:
%   n:  (scaler) number of nodes
%   Pe: (scaler) Péclet number Pe
%   cL: (scaler) Boundary condition on the left-side
%   cR: (scaler) Boundary condotion on the right-side
%   alpha: (scalar) determines difference scheme (=1 bavkward, =0 forward, =0.5
%   central)
%
%   Output:
%   c:   (vector) [n*1] Approximate solution of c using the FDM
%   x:   (vector) [n*1] Vector containing the coordinates of c
%   PeG: (scalar) [-]   Scaler representing the grid Péclet number


% 1. Generating the grid and calculating parameters:
x = linspace(0, 1, n); % Generating the x grid between 0 and 1 using linspace()

dx = 1/n;
PeG = Pe * dx;

% 2. Setting up the system of equations
h_Pb = -1/(dx);
o1_Pb = 0;
u1_Pb = -1/(dx);


Pb = tridiag(n, u1_Pb, h_Pb, o1_Pb);
Pb(1, 1) = 0;
Pb(n, n) = 0;
Pb(n, n-1) = 0;

%matrix P_f with forward difference
h_Pf = -1;
o1_Pf = 1;
u1_Pf = 0;

Pf = tridiag(n, u1_Pf, h_Pf, o1_Pf);
Pf(1, 3) = 0;
Pf(n, n) = 0;
Pf(1, 2) = 0;
Pf(n, n-1) = 0;

%matrix P_b with backward difference
h_Pb = 1;
o1_Pb = 0;
u1_Pb = -1;

Pb = tridiag(n, u1_Pb, h_Pb, o1_Pb);
Pb(1, 3) = 0;
Pb(n, n) = 0;
Pb(1, 2) = 0;
Pb(n, n-1) = 0;

%K matrix
u1_K = 1; 
h_K = -2;
o1_K = 1;


K = tridiag(n, u1_K, h_K, o1_K);
K(1, 1) = -1;
K(n, n) = -1;
K(1, 2) = 0;
K(n, n-1) = 0;


A = PeG * (alpha*Pb + (1-alpha)*Pf) - K;


% Defining rhs
rhs = zeros(n, 1);
rhs(1) = cL;
rhs(n) = cR;

% 3. Solving the system of equations
c = A\rhs;

end