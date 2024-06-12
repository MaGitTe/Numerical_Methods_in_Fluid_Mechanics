function [inv_mue] = f_mue1(x)
%This function gives values of inverse of mue case 1
air = 1;
brick = 1/5;
insulation = 1/3;
b1 = 0.1;
b2 = 0.3;
b3 = 0.7;
inv_mue = zeros(length(x),1);
inv_mue(x<b1 | x>=b3) = air;
inv_mue(x>=b1 & x<b2) = insulation;
inv_mue(x>=b2 & x<b3) = brick;
end