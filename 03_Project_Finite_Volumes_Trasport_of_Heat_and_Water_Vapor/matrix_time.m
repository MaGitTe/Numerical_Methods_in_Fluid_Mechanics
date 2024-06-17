function [A, x] = matrix_time(f1,frho, L, N, dt, cp)
% Group 1
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 19.06.2024

% This function aims to generate the A [N+2, N+2] matrix used to solve either
% the heat transport or the water vapor transport depending on the choosen
% `f` input.


%   Input:
%   f1:  (@function) Function used to call previously defined functions
%   frho:  (@function) Function used to call previously defined rho array
%   L: (scalar) Length of the domain
%   N: (scalar) Number of elements (CV)
%
%   Output:
%   A:   (matrix) [N, N] System matrix
%   x:   (vector) [N, 1] Vector containing the locations of the elements
%   center points and of the boundary nodes.


%% --- Defining the vector of elements center point of `x` --- %%

dx = L/N; % Correspoonds to the length of one CV
x = [0; linspace(dx/2, L-dx/2, N)';  L]; % Here 0 and L represent the boundary nodes,
                                         % And ` linspace(dx/2, L-dx/2, N)' ` correspondes to the mid point of each control volume.



%% --- Defining the vector of parameters (lambda, mu) --- %%                                    

p_arr1 = f1(x); % here p_array stands for `parameter array`, being either an array of lambda, or mu.


p_arr_inter1 = 1/2 *(p_arr1(1: end-1) + p_arr1(2: end)); % Stands for `parameters at interface` here using the arithmetical interpolation
                                                      % p_interface_harmonic = 2 *(1./p_arr(1: end-1) + 1./p_arr(2: end)).^(-1);


% Extracting the 1st and 2nd interface (for better clarity when adapting the main diagonal)                                                      
p_2_minus_half = p_arr_inter1(1);
p_2_plus_half = p_arr_inter1(2);

% Extracting the last and before last interface (for better clarity when adapting the main diagonal)      
p_end_minus_half = p_arr_inter1(end);
p_end_plus_half = p_arr_inter1(end);

%% --- Defining the vector of parameters (rho) --- %%                                    

rho = frho(x); % array rho_i.
rho_inv = 1 ./rho; %array 1/rho_i

%% --- Defining the main, upper and lower diagonal of `A` without the boundaries--- %%

main_diag = [0;-(p_arr_inter1(1:end-1) + p_arr_inter1(2:end));0]; % Represents the interface with indices ` -(i-1/2 + i+1/2) `
lower_diag = [p_arr_inter1(1:end-1);0]; % Represents the interface with indices `i-1/2`
upper_diag = [0;p_arr_inter1(2:end)]; % Represents the interface with indices `i+1/2`


%% --- Adapting the diagonals for our specific problem --- %%

% Adjusting the second and before last element of the diagonal, due to the boundaries.
main_diag(2) = -(p_2_plus_half + 2*p_2_minus_half);
main_diag(end-1) = -(p_end_minus_half + 2*p_end_plus_half);


% Adapting the lower diagonal
lower_diag(1) = 2*lower_diag(1);


% Adapting the upper diagonal
upper_diag(end) = 2*upper_diag(end);



%% --- Building the system matrix `A` --- %%

A = (diag(main_diag) + diag(lower_diag, -1) + diag(upper_diag, 1));


%inserting rho and prefactor and adding 1 to diagonal

A = A.*rho_inv;

prefactor = -dt/(cp* dx^2);
A = A.*prefactor;
A = A + eye(N+2);
disp(A)






end

