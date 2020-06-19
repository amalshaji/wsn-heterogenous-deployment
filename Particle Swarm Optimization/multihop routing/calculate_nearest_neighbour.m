function [nn, nn_dist] = calculate_nearest_neighbour(x, y, SinkX, SinkY)
%CALCULATE_NEAREST_NEIGHBOUR Summary of this function goes here
%   Detailed explanation goes here
    n = size(x, 2);
    nn(1:n) = 0;
    nn_dist(1:n) = 0;
    
    for i = 1 : n
        candidates = [];
        candidate_distances = [];
        current_dist_to_sink = sqrt( (x(i)-SinkX)^2 + (y(i)-SinkY)^2 );
        
        for j = 1:n
            if j == i
                continue;
            end
            distance = sqrt( (x(j)-SinkX)^2 + (y(j)-SinkY)^2 );
            if distance < current_dist_to_sink
                candidates = [candidates j];
            end
        end
        if size(candidates, 2) == 0
            nn(i) = 0;
            nn_dist(i) = sqrt( (x(i)-SinkX)^2 + (y(i)-SinkY)^2 );
        else
            
            for k = 1:size(candidates, 2)
                dist = sqrt( (x(candidates(k))-x(i))^2 + (y(candidates(k))-y(i))^2 );
                candidate_distances = [candidate_distances dist];
            end
            
            [min_dist, min_index] = min(candidate_distances(~ismember(candidate_distances, 0)));
        
            if min_dist > current_dist_to_sink
                nn(i) = 0;
                nn_dist(i) = sqrt( (x(i)-SinkX)^2 + (y(i)-SinkY)^2 );
            else
                nn(i) = candidates(min_index);
                nn_dist(i) = min_dist;
            end
        end
    end
end

