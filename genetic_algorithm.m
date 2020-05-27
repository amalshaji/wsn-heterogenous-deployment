POPULATION_SIZE = 100;
VARIABLES = 4;
ITERATIONS = 1200;
objective_history = [];
fitness_history = [];
chromosomes = randi([1, 30], POPULATION_SIZE, VARIABLES);
for i = 1:ITERATIONS
    [complete, fitness_values, objective_values] = fitness(chromosomes, POPULATION_SIZE);
    objective_history = [objective_history min(objective_values)];
    fitness_history = [fitness_history max(fitness_values)];
    if complete == 1
        %objective_values
        %chromosomes
        %i
        for ii = 1:POPULATION_SIZE
            if objective_values(ii) == 0
                index = ii;
                break
            end
        end
        objective_history = [objective_history 0];
        fprintf("************************************************\n")
        fprintf("Objective Value: %d\n", objective_values(index));
        fprintf("Solution       : %d %d %d %d\n", chromosomes(index, :));
        fprintf("generation     : %d\n", i);
        fprintf("************************************************\n")
        plot(1:size(objective_history, 2), objective_history);
        %figure;
        %plot(1:size(fitness_history, 2), fitness_history);
        return        
    end
    selection = Tournament(chromosomes, fitness_values, POPULATION_SIZE, VARIABLES);
    cross = crossover(selection, POPULATION_SIZE, VARIABLES);
    mutate = mutation(cross, VARIABLES, POPULATION_SIZE); 
    chromosomes = mutate;
end
%[complete, fitness_values] = fitness(chromosomes, POPULATION_SIZE);
%selection = Tournament(chromosomes, fitness_values, POPULATION_SIZE);
%cross = crossover(selection, POPULATION_SIZE);
%mutate = mutation(cross, VARIABLES, POPULATION_SIZE);