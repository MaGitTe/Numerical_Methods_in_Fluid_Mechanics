function [lambda] = f_lambda2(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
air = 0.026;
brick = 1;
insulation = 0.05;
b1 = 0.1;
b2 = 0.5;
b3 = 0.7;
lambda = zeros(length(x),1);
lambda(x<b1 | x>=b3) = air;
lambda(x>=b1 & x<b2) = brick;
lambda(x>=b2 & x<b3) = insulation;
end
end