function [A] = tridiagcyc(n, u1, h, o1)
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

% This function creates a matrix A of size [n, n], this matrix will have a
% main diagonal, an upper first diagonal and a lower first one.
% Additionlly in the lower left corner is (o1), and in the upper right
% corner is (u1).

%   Input:
%   n:  (scaler) Dimension of the matrix
%   u1: (scaler) Lower first diagonal
%   h:  (scaler) Main diagonal
%   o1: (scaler) Upper first diagonal
%
%   Output:
%   A: (matrix) [n, n] Modified Tri-diagonal matrix, with values in the
%   edges

if n < 3
    % If n is lower than 3, we set A=0 and return an error.
    A = 0;
    error('InvalidDimensionError: Dimension (n) must be greater than 2. (n>=3)')

else
    % If n is greater or equal to 3, we define our [n*n] A matrix using the
    % diag() function.

    main_diag = h * ones(n, 1);     % Main diagonal of A
    upper_diag = o1 * ones(n-1, 1); % Upper first diagonal of A
    lower_diag = u1 * ones(n-1, 1); % Lower first diagonal of A

    A = diag(main_diag) + diag(lower_diag, -1) + diag(upper_diag, 1);
    
    % Adding the corresponding values to the corners
    A(1, n) = u1; % (1, n) -> index of upper right corner
    A(n, 1) = o1; % (n, 1) -> index of lower left corner
    
end

end