function [c] = maxmod(a, b)
% Group 1
%   - Lokesh Duvvuru, 10063226
%   - Marie Tersteegen, 10061302
%   - Younes Abdeldjalil TOUMI, 10064473

% Date of submission: 03.07.2024

% This function aims to implement the maxmod function of Eq. 21 inputs can
% either be scalars or vectors.

%   Input:
%   a:   (scalar / vector) Input array a. Can be a scalar or an [N, 1] vector.
%   b:   (scalar / vector) Input array b. Can be a scalar or an [N, 1] vector.
%
%   Output:
%   c:   (scalar / vector) Result of applying the maxmod function


% Initialize c with the values of b
c = b;

mask = abs(a) >= abs(b); % Creates a logical mask where `abs(a) >= abs(b)`

% Use the mask to assign values from `a` to `c` where the condition is true
c(mask) = a(mask);

end

