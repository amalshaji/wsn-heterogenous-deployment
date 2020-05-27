function [chromosomes] = mutation(chromosomes, VARIABLES, POPULATION_SIZE, test_function)
%MUTATION Summary of this function goes here
%   Detailed explanation goes here
    mr = 0.1;
    number_of_mutations = int8(mr*VARIABLES*POPULATION_SIZE);
    mutation_points = randi([1, POPULATION_SIZE], number_of_mutations);
    if test_function == 'linear'
        mutation_values = randi([1, 30], number_of_mutations);
    elseif test_function == 'booth' || test_function == 'matyas'
        mutation_values = -10 + (10 + 10)*rand(1, number_of_mutations);
    elseif test_function == 'beale'
        mutation_values = -4.5 + (4.5 + 4.5)*rand(1, number_of_mutations);
    end
    for i = 1:number_of_mutations
        row = int8(mutation_points(i)/VARIABLES);
        col = rem(mutation_points(i), VARIABLES);
        if row == 0
            row = 1;
        end
        if col == 0
            col = VARIABLES;
        end
        chromosomes(row, col) = mutation_values(i);
    end
end

