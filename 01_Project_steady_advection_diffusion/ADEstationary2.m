function [c, x, PeG] = ADEstationary2(n, Pe, cL, cR, alpha)
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

%% This function calculates the numerical solution for c [n*1] using the
% finite difference method of our given problem.

%   Input:
%   n:  (scalar) number of nodes
%   Pe: (scalar) Péclet number Pe
%   cL: (scalar) Boundary condition on the left-side
%   cR: (scalar) Boundary condotion on the right-side
%   alpha: (scalar) determines difference scheme (=1 backward, =0 forward, =0.5
%   central)
%
%   Output:
%   c:   (vector) [n*1] Approximate solution of c using the FDM
%   x:   (vector) [n*1] Vector containing the coordinates of c
%   PeG: (scalar) [-]   Scalar representing the grid Péclet number


%% 1. Generating the grid and calculating parameters:
x = linspace(0, 1, n); % Generating the x grid between 0 and 1 using linspace()

dx = 1/(n-1);
PeG = Pe * dx;

%% 2. Setting up the system of equations [A]{c} = {rhs}

% 2.1 Defining the [Pb] matrix
% 2.1.1 Setting up the diagonals for [Pb] to then use the tridiag() function
h_Pb = 1;
o1_Pb = 0;
u1_Pb = -1;

Pb = tridiag(n, u1_Pb, h_Pb, o1_Pb);

% 2.1.2 Adjusting the elements of [Pb] to match the numerical scheme
Pb(1, 1) = 0;
Pb(n, n) = 0;
Pb(n, n-1) = 0;


% 2.2 Defining the [Pf] matrix
% 2.2.1 Setting up the diagonals for [Pf] to then use the tridiag() function
h_Pf = -1;
o1_Pf = 1;
u1_Pf = 0;

Pf = tridiag(n, u1_Pf, h_Pf, o1_Pf);

% 2.2.2 Adjusting the elements of [Pf] to match the numerical scheme
Pf(1, 1) = 0;
Pf(n, n) = 0;
Pf(1, 2) = 0;
Pf(n, n-1) = 0;


% 2.3 Defining the [K] matrix
% 2.3.1 Setting up the diagonals for [K] to then use the tridiag() function
u1_K = 1; 
h_K = -2;
o1_K = 1;

K = tridiag(n, u1_K, h_K, o1_K);

% 2.3.2 Adjusting the elements of [K] to match the numerical scheme
K(1, 1) = -1;
K(n, n) = -1;
K(1, 2) = 0;
K(n, n-1) = 0;


% 2.4 Defining our matrix [A] = PeG*[a*[Pb] + (1-a)*[Pf]] - [K]
A = PeG * (alpha*Pb + (1-alpha)*Pf) - K;


% 2.5 Defining our right-hand-side {rhs} for the given BC
rhs = zeros(n, 1);
rhs(1) = cL;
rhs(n) = cR;

%% 3. Solving the system of equations {c} = [A]^(-1) * {rhs}
c = A\rhs;

end