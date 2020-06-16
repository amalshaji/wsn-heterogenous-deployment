% size of terrain        :100
% number of sensor nodes : 40

xy = rand(40, 2);
xy = xy.*100;

fileID = fopen("fixed_deployment.txt", "w");
fprintf(fileID, "%f %f\n", xy);
fclose(fileID);

fprintf("New deployment saved to `fixed_deployment.txt`\n")
plot_nodes(xy(:, 1), xy(:, 2), 50, 50, [50 50], 0);