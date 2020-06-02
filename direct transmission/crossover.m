function [chromosomes] = crossover(chromosomes, POPULATION_SIZE, VARIABLES)
%CROSSOVER Summary of this function goes here
%   Detailed explanation goes here
    cr = 0.25;
    index = [];
    R = rand(1, POPULATION_SIZE);
    for i = 1:POPULATION_SIZE
        if R(i) < cr
            index = [index i];
        end
    end
    for i = 1:size(index, 2)
        to = i;
        from = rem(i+1, size(index, 2));
        if from == 0
            from = size(index, 2);
        end
        random = randi([1, VARIABLES], 1);
        if random ~= VARIABLES
            chromosomes(to, :) = [chromosomes(to, 1:random) chromosomes(from, random+1:end)];
        end
    end
end

