clear;
clc;
%POPULATION_SIZE = 100;
%VARIABLES = 4;

%ITERATIONS = 1200;
objective_history = [];
%fitness_history = [];
min_objective = 50000;
min_index = -1;

list = {'linear', 'booth', 'beale', 'matyas'};
[indx,tf] = listdlg('ListString', list, 'SelectionMode','single', 'ListSize',[150, 100], 'PromptString','Select a Test Function:');
test_function = string(list(indx));

prompt = {'Total Population size:','Maximum Iterations:', 'Random Number generator Seed:'};
title = 'Genetic Algorithm';
dims = [1 70];
definput = {'20', '1200', '1'};
answer = inputdlg(prompt,title,dims,definput);
POPULATION_SIZE = str2double(answer{1});
ITERATIONS = str2double(answer{2});
RNG_SEED = str2double(answer{3});

rng(RNG_SEED);

if test_function == 'booth'
   VARIABLES = 2;
   % Search space of booth -10 <= x, y <= 10
   chromosomes = -10 + (10+10)*rand(POPULATION_SIZE, VARIABLES);
elseif test_function == 'beale'
   VARIABLES = 2;
   % Search space of beale -4.5 <= x, y <= 4.5
   chromosomes = -4.5 + (4.5+4.5)*rand(POPULATION_SIZE, VARIABLES);
elseif test_function == 'matyas'
   VARIABLES = 2;
   % Search space of matyas -10. <= x, y <= 10.
   chromosomes = -10 + (10+10)*rand(POPULATION_SIZE, VARIABLES);
elseif test_function == 'linear'
   VARIABLES = 4;
   % Search space of matyas -10. <= x, y <= 10.
   chromosomes = randi([1, 30], POPULATION_SIZE, VARIABLES);
end

%chromosomes = randi([1, 30], POPULATION_SIZE, VARIABLES);
for i = 1:ITERATIONS
    [complete, fitness_values, objective_values] = fitness_test(chromosomes, POPULATION_SIZE, test_function);
    objective_history = [objective_history min(objective_values)];
    if min(objective_values) < min_objective
        [min_objective, min_index] = min(objective_values(~ismember(objective_values,0)));
        solution = chromosomes(min_index, :);
        min_generation = i;
    end
    %fitness_history = [fitness_history max(fitness_values)];
    if complete == 1 || ITERATIONS == i
        for ii = 1:POPULATION_SIZE
            if objective_values(ii) == 0
                index = ii;
                break
            end
        end
        if i == ITERATIONS
            fprintf("************************************************\n")
            fprintf("Test Function  : %s\n", test_function);
            fprintf("Objective Value: %d\n", min_objective);
            fprintf("Solution       : %d %d %d %d\n", solution);
            fprintf("generation     : %d\n", min_generation);
            fprintf("************************************************\n")
            plot(1:min_generation, objective_history(1:min_generation));
        else
            fprintf("************************************************\n")
            fprintf("Test Function  : %s\n", test_function);
            fprintf("Objective Value: %d\n", objective_values(index));
            fprintf("Solution       : %d %d %d %d\n", chromosomes(index, :));
            fprintf("generation     : %d\n", i);
            fprintf("************************************************\n")
            plot(1:size(objective_history, 2), objective_history);
            return
        end
    end
    selection = Tournament(chromosomes, fitness_values, POPULATION_SIZE, VARIABLES);
    cross = crossover(selection, POPULATION_SIZE, VARIABLES);
    mutate = mutation(cross, VARIABLES, POPULATION_SIZE, test_function); 
    chromosomes = mutate;
end