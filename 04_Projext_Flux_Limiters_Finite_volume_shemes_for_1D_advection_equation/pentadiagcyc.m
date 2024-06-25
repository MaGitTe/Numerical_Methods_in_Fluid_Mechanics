function [A] = pentadiagcyc(n, u2, u1, h, o1, o2)
% Group 1
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

% Date of submission: 03.07.2024
% This function creates a matrix A of size [n, n], this matrix will have a
% main diagonal, an upper first diagonal and a lower first one.
% Additionlly in the lower left corner is (o1), and in the upper right
% corner is (u1).

%   Input:
%   n:  (scalar) Dimension of the matrix
%   u2: (scalar) Lower second diagonal
%   u1: (scalar) Lower first diagonal
%   h:  (scalar) Main diagonal
%   o1: (scalar) Upper first diagonal
%   o2: (scalar) Upper second diagonal
%
%   Output:
%   A: (matrix) [n, n] Modified Penta-diagonal matrix, with values in the
%   edges

if n < 5
    % If n is lower than 5, we set A=0 and return an error.
    A = 0;
    error('InvalidDimensionError: Dimension (n) must be greater than 4. (n>=5)')

else
    % If n is greater or equal to 3, we define our [n*n] A matrix using the
    % diag() function.

    main_diag = h * ones(n, 1);     % Main diagonal of A
    
    upper_diag = o1 * ones(n-1, 1); % Upper first diagonal of A
    upper_diag_2 = o2 * ones(n-2, 1); % Upper second diagonal of A
    
    lower_diag = u1 * ones(n-1, 1); % Lower first diagonal of A
    lower_diag_2 = u2 * ones(n-2, 1); % Lower second diagonal of A

    A = diag(main_diag) + diag(lower_diag, -1) + diag(upper_diag, 1) + diag(upper_diag_2, 2) + diag(lower_diag_2, -2);
    
    % Adding the corresponding values to the corners
    A(1, n) = u1; % (1, n) -> index of upper right corner
    A(n, 1) = o1; % (n, 1) -> index of lower left corner
    
   
    A(1, end-1) = u2; % (1, n-1) -> index of 1st element of second upper right corner
    A(2, end) = u2;   % (2, n)   -> index of 2nd element of second upper right corner
    
    A(end-1, 1) = o2; % (n-1, 1) -> index of 1st element of second lower left corner
    A(end, 2) = o2; % (n, 2)     -> index of 2nd element of second lower left corner
 
end

end
