function [] = pretty_print(nn, mv)
%PRETTY_PRINT Summary of this function goes here
%   Detailed explanation goes here
    n = size(nn, 2);
    for i = 1:n
        fprintf("index: %d, nn: %d, mv: %d\n", i, nn(i), mv(i));
    end
end

