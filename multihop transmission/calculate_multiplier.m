function [mv] = calculate_multiplier(sensor_nodes, nn)
%CALCULATE_MULTIPLIER Summary of this function goes here
%   Detailed explanation goes here
    %total_packets = 0;
    mv(1:sensor_nodes) = 0;
    
    %while total_packets ~= sensor_nodes
    %    for i = 1:sensor_nodes
    %        current_nn = nn(i);
    %        if current_nn == 0
    %            mv(i) = mv(i) + 1;
    %            total_packets = total_packets + 1;
    %        else
    %            curr_node = i;
    %            while curr_node ~= 0
    %                mv(curr_node) = mv(curr_node) + 1;
    %                curr_node = nn(curr_node);
    %                if curr_node == 0
    %                    total_packets = total_packets + 1;
    %                end
    %            end
    %        end
    %    end
    %end
    for i = 1:sensor_nodes
        mv(i) = sum(nn(:) == i) + 1;
    end
end

