function [x, y, en] = fixed_deployment(InitialEnergy)
%FIXED_DEPLOYMENT Summary of this function goes here
%   Detailed explanation goes here
    fileID = fopen("fixed_deployment.txt", "r");
    formatSpec = "%f";
    A = fscanf(fileID, formatSpec);
    A = reshape(A, [40, 2]);
    x = A(:, 1);
    x = reshape(x, [1, 40]);
    y = A(:, 2);
    y = reshape(y, [1, 40]);
    for i = 1 : size(A, 1)
        en(i) = InitialEnergy; % Energy array depicting each node's energy consumption
    end
end

