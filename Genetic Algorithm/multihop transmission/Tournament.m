function [new_population] = Tournament(population, s, fitness, POPULATION_SIZE, VARIABLES)
%TOURNAMENT Summary of this function goes here
%   Detailed explanation goes here
    number_of_tournaments = POPULATION_SIZE;
    new_population = zeros(1, VARIABLES);
    %for i = 1 : number_of_tournaments/2
    %    new_population(i, :) = population(randi([1, POPULATION_SIZE]), :);
    %end
    for i = 1 : number_of_tournaments
        a = randi([1, POPULATION_SIZE], 1, 2);
        pop1 = a(1);
        pop2 = a(2);
        if fitness(pop1) < fitness(pop2)
            new_population(i, :) = population(pop1, :);
        else
            new_population(i, :) = population(pop2, :);
        end
    end
end

