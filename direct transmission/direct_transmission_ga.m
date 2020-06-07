clear;
clc;
close all;

filename = "amal.gif";
%axis tight manual;
%ITERATIONS = 1200;
objective_history = [];
%fitness_history = [];
min_lifetime = -1;
min_index_lifetime = -1;
final_energy = 15;
prev_mean = -inf;

prompt = {'Number of Sensor Nodes', 'Number of Heterogenous Nodes', 'Initial energy of each sensor Node', 'Initial energy of each heterogenous Node', 'Size of Terrain(x)', 'X coordinate of Sink', 'Y coordinate of Sink', 'Total Population size:','Maximum Iterations:', 'Random Number generator Seed:', '0 for fixed deployment, 1 for random'};
title = 'Direct Transmission Genetic Algorithm';
dims = [1 70];
definput = {'30', '6', '0.5', '1.5', '100', '50', '50', '1000', '5', '1', '1'};
answer = inputdlg(prompt,title,dims,definput);
NODES = str2double(answer{1});
HET_NODES = str2double(answer{2});
SENSOR_ENERGY = str2double(answer{3});
HETER_ENERGY = str2double(answer{4});
TERRAIN_SIZE = str2double(answer{5});
SinkX = str2double(answer{6});
SinkY = str2double(answer{7});
POPULATION_SIZE = str2double(answer{8});
ITERATIONS = str2double(answer{9});
RNG_SEED = str2double(answer{10});
DEP_TYPE = str2double(answer{11});
tic
relay_energy = SENSOR_ENERGY + HETER_ENERGY;

min_positions = zeros(1, HET_NODES);
% generate terrain and initialize sensor nodes
if DEP_TYPE == 1
    [x, y, en] = sensor_nodes(NODES, TERRAIN_SIZE, SENSOR_ENERGY);
else
    [x, y, en] = fixed_deployment(SENSOR_ENERGY);
    NODES = 40;
    TERRAIN_SIZE = 100;
end


initial_energy = en;
[lifetime1, en2] = direct_transmission(x, y, en, SinkX, SinkY);
initial_lifetime = lifetime1;

total_energy_hist = -1 * ones(1, ITERATIONS);
lifetime_hist = -1 * ones(1, ITERATIONS);


rng(RNG_SEED);

p = [x(:) y(:)];
% initial population
% heter_nodes_index = randi([1, size(x, 2)], POPULATION_SIZE, HET_NODES);
for i = 1 : POPULATION_SIZE
    heter_nodes_index(i, :) = randperm(size(x, 2), HET_NODES);
end
int_hni = heter_nodes_index;
%for i = 1:HET_NODES
%    hetero_nodes_position(i, 1) = x(heter_nodes_index(i));
%    hetero_nodes_position(i, 2) = y(heter_nodes_index(i));
%    en(heter_nodes_index(i)) = en(heter_nodes_index(i)) + HETER_ENERGY;
%end
%plot_nodes(x, y, SinkX, SinkY, hetero_nodes_position);
f = figure('Position', [750, 50, 600, 400]);

saturation_count = 0;

for z = 1 : ITERATIONS
    lifetimes = -1 * ones(1, POPULATION_SIZE);
    fitness = -1 * ones(1, POPULATION_SIZE);
    objective = -1 * ones(1, POPULATION_SIZE);

    for i = 1 : POPULATION_SIZE
        energy = initial_energy;    
        for j = 1 : HET_NODES
            energy(heter_nodes_index(i, j)) = energy(heter_nodes_index(i, j)) + HETER_ENERGY;            
        end
        [lifetime2, en3] = direct_transmission(x, y, energy, SinkX, SinkY);
        lifetimes(i) = lifetime2;
        objective(i) = lifetime2;
        fitness(i) = 1 / (1 + objective(i));
        
    end
    %lifetime_hist(z) = min(lifetimes);
    [lifetime_hist(z), min_index] = max(lifetimes(~ismember(lifetimes, 0)));
    if lifetime_hist(z) > min_lifetime
        min_lifetime = lifetime_hist(z);
        all_min_indices = find(lifetimes == max(lifetimes));
        random_index = randi([1, size(all_min_indices, 2)]);
        min_index_lifetime = all_min_indices(random_index);
        min_positions = heter_nodes_index(min_index_lifetime, :);
        for i = 1:HET_NODES
            hetero_nodes_position(i, 1) = x(min_positions(i));
            hetero_nodes_position(i, 2) = y(min_positions(i));
        end
    end
    selection = Tournament(heter_nodes_index, size(x, 2), fitness, POPULATION_SIZE, HET_NODES);
    cross = crossover(selection, POPULATION_SIZE, HET_NODES);
    mutate = mutation_direct(cross, HET_NODES, POPULATION_SIZE);
    heter_nodes_index = mutate;
    %for i = 1:HET_NODES
    %    hetero_nodes_position(i, 1) = x(heter_nodes_index(min_index, i));
    %    hetero_nodes_position(i, 2) = y(heter_nodes_index(min_index, i));
    %end
    plot_nodes(x, y, SinkX, SinkY, hetero_nodes_position, z);
    %title(num2str(z));
    pause(0.01);
    clf(f);
    if mean(lifetimes) < prev_mean
        saturation_count = saturation_count + 1;
    end
    if saturation_count >= 5
        fprintf("Mean Saturation...\n");
        break
    end
    fprintf("Generation: %d, Current mean Lifetime: %.2f, Overall Best Lifetime: %d\n", z, mean(lifetimes), max(lifetime_hist));
    prev_mean = mean(lifetimes);
end
close all;
fprintf("******************************************************************\n");
fprintf("Initial Energy       : %.2f\n", initial_energy(1));
fprintf("Initial Lifetime     : %d\n", initial_lifetime);
%fprintf("Initial Total Energy : %d\n", sum(initial_energy));
fprintf("Final   Lifetime     : %d\n", max(lifetime_hist));
fprintf('Time Taken           : %.2f seconds. \n',toc')
fprintf("******************************************************************\n");

plot_nodes(x, y, SinkX, SinkY, hetero_nodes_position, z);
%figure;
%plot(1:size(lifetime_hist, 2), log(lifetime_hist));
