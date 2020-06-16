function [x, y, en] = sensor_nodes(NODES, TERRAIN_SIZE, InitialEnergy)
%SINK_NODES Summary of this function goes here
%   Detailed explanation goes here  
    n = NODES; % number of nodes
    breadth = TERRAIN_SIZE;
    for i = 1 : n
        x(i) = rand();
        y(i) = rand();
        en(i) = InitialEnergy; % Energy array depicting each node's energy consumption
    end
    x = x.*breadth;
    y = y.*breadth;
end

