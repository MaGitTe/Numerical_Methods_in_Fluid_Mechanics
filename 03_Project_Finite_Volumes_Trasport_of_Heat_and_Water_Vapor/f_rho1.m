function [rho] = f_rho1(x)
% Group 1
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 19.06.2024

% This function aims to generate the `rho` [N, 1] vector containing the 
% density ρ at different values of x. For the first case.

%   Input:
%   x:   (vector) [N, 1] Vector of values ranging from 0 to L
%
%   Output:
%   rho:   (vector) [N, 1] Vector containing the density ρ at x.

rho_air = 1.3;
rho_brick = 1600;
rho_insulation = 100; 

n = length(x);
rho = zeros(n, 1);

b1 = 0.1;
b2 = 0.3;
b3 = 0.7;

rho(x < b1 | x >= b3) = rho_air;
rho(x >= b1 & x < b2) = rho_insulation;
rho(x >= b2 & x < b3) = rho_brick;

end

