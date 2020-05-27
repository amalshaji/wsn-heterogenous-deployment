function [global_minima] = booth(inputs)
%BOOTH Summary of this function goes here
%   Detailed explanation goes here
    x = inputs(1);
    y = inputs(2);
    global_minima = (x + 2*y -7)^2 + (2*x + y - 5)^2;
end

