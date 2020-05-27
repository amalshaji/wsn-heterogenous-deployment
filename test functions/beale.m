function [global_minima] = beale(inputs)
%BEALE Summary of this function goes here
%   Detailed explanation goes here
    x = inputs(1);
    y = inputs(2);
    global_minima = (1.5 - x + x*y)^2 + (2.25 - x + x*y*y)^2 + (2.625 - x + x*y*y*y)^2;
end

