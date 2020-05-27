function [complete, fitness_values, objective_values] = fitness_test(chromosomes, POPULATION_SIZE, test_function)
%FITNESS Summary of this function goes here
%   Detailed explanation goes here
    complete = 0;
    fitness_values = -1*ones(1, POPULATION_SIZE);
    objective_values = -1*ones(1, POPULATION_SIZE);
    for i = 1:POPULATION_SIZE
        
        if test_function == 'booth'
            obj = booth(chromosomes(i, :));    
        elseif test_function == 'beale'
            obj = beale(chromosomes(i, :));
        elseif test_function == 'matyas'
            obj = matyas(chromosomes(i, :));
        elseif test_function == 'linear'
            n2c_chroms = num2cell(chromosomes(i, :));
            obj = objective(n2c_chroms{:});
        end
        objective_values(i) = obj;
        if obj == 0
            fitness_values(i) = 1;
            complete = 1;
            return
        else
            fitness_values(i) = 1/obj;
        end
    end
end