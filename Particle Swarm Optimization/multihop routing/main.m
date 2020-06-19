
clc;
clear ;
close all;
nod=[];

%% Problem Definiton
    c=rdep();
    x=c{1};
    y=c{2};
    SinkX=c{3};
    SinkY=c{4};
    n=c{5};
    breadth=c{6};
    params.MaxIt=c{8};
    hetero=c{7};
    
    
    [nn, nn_dist] = calculate_nearest_neighbour(x, y, SinkX, SinkY);
    mv = calculate_multiplier(size(x, 2), nn);
    for i=1:n
        en(i)=0.5;
    end
    for i=1:length(nod)
        en(nod(i))=1.5;
    end
    multihop_transmission(x,y,en,SinkX,SinkY,nn_dist,mv)

    for i=1:hetero
    problem.nVar = 2;       % Number of Unknown (Decision) Variables
    problem.VarMin =  0;  % Lower Bound of Decision Variables
    problem.VarMax = breadth;   % Upper Bound of Decision Variables

%% Parameters of PSO
factor=breadth/100;
params.nPop = 150;           % Population Size (Swarm Size)
params.w = 15*factor;               % Intertia Coefficient
params.wdamp = 9.9*factor;        % Damping Ratio of Inertia Coefficient
params.c1 = 30*factor;              % Personal Acceleration Coefficient
params.c2 = 30*factor;              % Social Acceleration Coefficient
params.ShowIterInfo = true; % Flag for Showing Iteration Informatin

%% Calling PSO

out = PSO(problem, params,x,y,SinkX,SinkY,n,nod);

BestSol(i) = out.BestSol;
BestCosts = out.BestCosts;
nod=[nod out.nod]


end

[nn, nn_dist] = calculate_nearest_neighbour(x, y, SinkX, SinkY);
mv = calculate_multiplier(size(x, 2), nn);
for i=1:n
    en(i)=0.5;
end
for i=1:length(nod)
    en(nod(i))=1.5;
end
multihop_transmission(x,y,en,SinkX,SinkY,nn_dist,mv)


f1=figure('Name','Random Deployment using PSO',...
            'NumberTitle','off');
for k=1:n
    figure (f1)
    scatter(SinkX,SinkY,190,'diamond','filled');
    reg_node=scatter(x(k),y(k),40,'MarkerEdgeColor',[0 0.5 0.5],...
                     'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
    alpha(reg_node,0.45);
    xlim([0 breadth]);
    ylim([0 breadth]);
    hold on;
end
for k=1:hetero
    
    figure (f1)
    scatter(x(nod(k)),y(nod(k)),135,'hexagram','filled','MarkerEdgeColor',...
             [0 0 0],'LineWidth',.75);
    xlim([0 breadth]);
    ylim([0 breadth]);
    hold on; 
end