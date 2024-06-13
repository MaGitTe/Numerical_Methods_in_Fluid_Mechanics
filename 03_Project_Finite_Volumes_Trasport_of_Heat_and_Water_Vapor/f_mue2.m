function [inv_mue] = f_mue2(x)

% Group 1
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 19.06.2024

% This function aims to generate the inv_mue [N, 1] vector containing the 
% the inverse of diffusion resistivity 1/µ at different values of x.
% For the second case.

%   Input:
%   x:   (vector) [N, 1] Vector of values ranging from 0 to L
%
%   Output:
%   inv_mue:   (vector) [N, 1] Vector containing the inverse of diffusion 
%   resistivity 1/µ at x.


inv_mue_air = 1;
inv_mue_brick = 1/5;
inv_mue_insulation = 1/3;

b1 = 0.1;
b2 = 0.5;
b3 = 0.7;

inv_mue = zeros(length(x),1);

inv_mue(x < b1 | x >= b3) = inv_mue_air;
inv_mue(x >= b1 & x < b2) = inv_mue_brick;
inv_mue(x >= b2 & x < b3) = inv_mue_insulation;

end