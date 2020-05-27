clear;
clc;

SinkX = 50;
SinkY = 50;
f = figure;
for i = 1:10
    [x, y, en] = sensor_nodes(50, 100);
    [lifetime, en] = direct_transmission(x, y, en, SinkX, SinkY);
    plot_nodes(x, y, SinkX, SinkY);
    pause(0.5);
    clf(f);
end
close all;
lifetime