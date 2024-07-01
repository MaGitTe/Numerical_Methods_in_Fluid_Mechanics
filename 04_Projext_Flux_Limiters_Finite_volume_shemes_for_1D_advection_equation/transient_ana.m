function [c] = transient_ana(x, t, c_ini, w, L_c, v, D)
% Group 1:
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473
%
% Date of submission: 05.06.2024

% This function calculates the vector c with a given time t in seconds.

%   Input:
%   x:      (vector) [1, nx] Vector containing the coordinates of c
%   t:      (scalar) Time at which the analytical solution is evaluated 
%   c_ini:  (scalar) Initial maximum concentration
%
%   w:   (scalar) width of the solute
%   L_c: (scalar) Coordinate of the center of the solute
%   v:   (scalar) Mean flow velocity
%   D:   (scalar) Dispersion coefficient

%   Output:
%   c: (vector) [1, nx] Vector of the analytical solution c


% Expressing the analytical solution using the `erf()` function

% Specifiyiong each term to make it more visually clear
term_1 = (x + w/2 - L_c - v*t)/(sqrt(4*D*t));
term_2 = (x - w/2 - L_c - v*t)/(sqrt(4*D*t));

c = c_ini/2 * ( erf(term_1) - erf(term_2) );


end