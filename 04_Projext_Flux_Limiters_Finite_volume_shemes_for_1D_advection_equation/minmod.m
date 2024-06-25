function [c] = minmod(a, b)
% Group 1
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

% Date of submission: 03.07.2024

% This function aims to implement the minmod function of Eq. 14 inputs can
% either be scalars or vectors.

%   Input:
%   a:   (scalar / vector) Input array a. Can be a scalar or an [N, 1] vector.
%   b:   (scalar / vector) Input array b. Can be a scalar or an [N, 1] vector.
%
%   Output:
%   c:   (scalar / vector) Result of applying the minmod function.


% Initialize the output array c with zeros
c = zeros(size(a));


mask_a = abs(a) <= abs(b) & a .* b > 0; % Create a logical mask where abs(a) <= abs(b) and `a` and `b` have the same sign
mask_b = abs(a) > abs(b) & a .* b > 0; % Create a logical mask where `abs(a) > abs(b)` and a and `b` have the same sign

c(mask_a) = a(mask_a); % Use the mask_a to assign values from `a` to `c` where the condition is true

% Use the mask_b to assign values from `b` to `c` where the condition is true
c(mask_b) = b(mask_b);

end

