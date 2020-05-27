function [global_minima] = matyas(inputs)
%MATYAS Summary of this function goes here
%   Detailed explanation goes here
    x = inputs(1);
    y = inputs(2);
    global_minima = 0.26*(x^2 + y^2) - 0.48*x*y;
end

