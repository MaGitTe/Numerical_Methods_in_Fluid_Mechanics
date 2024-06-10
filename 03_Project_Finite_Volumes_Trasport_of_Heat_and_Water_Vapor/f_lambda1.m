function [lambda] = f_lambda1(x)
%F_LAMBDA1 this function yields the lambda at every point x in case 1
%   
air = 0.026;
brick = 1;
insulation = 0.05;
b1 = 0.1;
b2 = 0.3;
b3 = 0.7;
lambda = zeros(length(x),1);
lambda(x<b1 | x>=b3) = air;
lambda(x>=b1 & x<b2) = insulation;
lambda(x>=b2 & x<b3) = brick;
end

