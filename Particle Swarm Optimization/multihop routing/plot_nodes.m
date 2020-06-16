function [] = plot_nodes(x, y, SinkX, SinkY, hnodes, z)
%PLOT_NODES Summary of this function goes here
%   Detailed explanation goes here
    p = [x(:), y(:)];
    %h = [hnodes(:, 1), hnodes(:, 2)];
    scatter(p(:,1), p(:,2), 'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',1.5)
    labels = num2str((1:size(p,1))','%d');    %'
    text(p(:,1), p(:,2), labels, 'horizontal','left', 'vertical','bottom')
    hold on
    plot(SinkX,SinkY,'d','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',20);
    scatter(hnodes(:,1), hnodes(:,2), 'MarkerEdgeColor','r','MarkerFaceColor','r','LineWidth',1.5)
    title(['Generation: ',sprintf('%d',z)]);
end

