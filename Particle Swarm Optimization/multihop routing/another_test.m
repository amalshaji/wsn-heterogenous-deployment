clear;
clc;

SinkX = 50;
SinkY = 50;
f = figure;
[x, y, en] = sensor_nodes(30, 100, 0.5);
[nn, nn_dist] = calculate_nearest_neighbour(x, y, SinkX, SinkY);
mv = calculate_multiplier(30, nn);
plot_nodes(x, y, SinkX, SinkY, [SinkX, SinkY], 0);