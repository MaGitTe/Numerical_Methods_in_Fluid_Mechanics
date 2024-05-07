## Assignment 01
authors:
Lokesh Duvvuru, 10063226
Marie Tersteegen, 10061302
Younes Abdeldjalil Toumi, 10064473

Date of submission: 08.05.2024

This README describes which .m-script/function belongs to which part of the Assignment on the assignment paper (Assignment_1_final.pdf).

This Project is about the numerical solution of a steady state advection 
diffusion problem with dirichlet boundary conditions with Finite Difference
Method

### 1. Analytical solution of the 1D mass transport equation
analytic.m plots the analytical solution of the problem for different Peclet numbers and saves it as anaSolution.png

### 2. Numerical solution of 1D stationary mass transport equation

#### 2.1 
1. tridiag.m is a function to create tridiagonal nxn matrix
2. tridiagcyc.m is a function to create a cyclic tridiagonal matrix

#### 2.2
On assignment paper: Derivation of matrix for finite difference method

#### 2.3 Numerical Implementation of the sheme with matlab
1. ADEstationary.m is a function to calculate numerical solution of the problem with central FDM
    Prequisite: tridiag.m
2. stationary.m script to compare analytical and numerical solution computed with ADEstationary.m in plot (numSolution.png)

#### 2.4 A more general finite difference scheme
1. On assignmentpaper: Define matrixes for more general diference scheme
2. ADEstationary2.m function numerically solves problem with forward, backward or central finite difference scheme 
    Prequisite: tridiag.m
3. stationary2.m script plots numerical solutions with forward, backward and central difference schemes and compares them to analytical solution for different Peclet numbers
    generalScheme.png contains the plot
    Prequisite: ADEstationary2.m

#### 2.5 Stability analysis
stability.m solves problem using ADEstationary2.m with n=11 nodes with forward, backward and central scheme and are plotted with analytical solution for different grid peclet nubers to compare performance in tables on assignment paper
plot saved as stabilityAnalysis.png

#### 2.6 Convergence analysis
1. convergence.m skript to perform convergence analysis by calculating deviation of numerical solutions with different gridsizes from analytical solution
    convergence.png: error plotted against gridsize with plot, semilogx, semilogy and loglog
3. convergence2.m skript to perform convergence analysis by comparing solutions of adjacent refinements. As adjacent refinement, the more coarse refinement is chosen. 
    The deviations are plotted against gridsize in convergence2.png

#### 2.7 Taylor expansion and finite differences
On assignment paper: Deductuion of central difference scheme for first derivative and finite difference scheme for second derivative from Taylorexpansion with marked truncation error


