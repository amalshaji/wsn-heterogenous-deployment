function [chromosomes] = mutation_direct(chromosomes, VARIABLES, POPULATION_SIZE)
%MUTATION Summary of this function goes here
%   Detailed explanation goes here
    mr = 0.1;
    number_of_mutations = int8(mr*VARIABLES*POPULATION_SIZE);
    mutation_points = randperm(POPULATION_SIZE, number_of_mutations);
    for i = 1 : number_of_mutations
        indices = randi([1, VARIABLES], 2);
        temp = chromosomes(mutation_points(i), indices(1));
        chromosomes(mutation_points(i), indices(1)) = chromosomes(mutation_points(i), indices(2));
        chromosomes(mutation_points(i), indices(2)) = temp;
    end
end

