function [lambda] = f_lambda1(x)
% Group 1
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 19.06.2024

%F_LAMBDA1 this function yields the lambda at every point x in case 1


% This function aims to generate the lambda [N, 1] vector containing the 
% heat conductivity λ at different values of x. For the first case.

%   Input:
%   x:   (vector) [N, 1] Vector of values ranging from 0 to L
%
%   Output:
%   rho:   (vector) [N, 1] Vector containing the heat conductivity λ at x.

lambda_air = 0.026;
lambda_brick = 1;
lambda_insulation = 0.05;

b1 = 0.1;
b2 = 0.3;
b3 = 0.7;

lambda = zeros(length(x),1);

lambda(x < b1 | x >= b3) = lambda_air;
lambda(x >= b1 & x < b2) = lambda_insulation;
lambda(x >= b2 & x < b3) = lambda_brick;
end