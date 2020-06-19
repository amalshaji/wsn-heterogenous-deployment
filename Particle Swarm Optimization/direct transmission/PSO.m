% Particle swarm optimization 
% References :
%    Copyright (c) 2015, Yarpiz
%    All rights reserved.




function out = PSO(problem, params,x,y,SinkX,SinkY,n,nod)

    %% Problem Definiton
     % Cost Function

    nVar = problem.nVar;        % Number of Unknown (Decision) Variables

    VarSize = [1 nVar];         % Matrix Size of Decision Variables
   for i=1:length(x)
        dist_direct(i)=sqrt((x(i)-SinkX)^2+(y(i)-SinkY)^2);
    end
    
    for i=1:n
        en(i)=5.0;
    end
    for i=1:length(nod)
        en(nod(i))=6.5;
    end
    
    VarMin = problem.VarMin;	% Lower Bound of Decision Variables
    VarMax = problem.VarMax;    % Upper Bound of Decision Variables


    %% Parameters of PSO

    MaxIt = params.MaxIt;   % Maximum Number of Iterations

    nPop = params.nPop;     % Population Size (Swarm Size)

    w = params.w;           % Intertia Coefficient
    wdamp = params.wdamp;   % Damping Ratio of Inertia Coefficient
    c1 = params.c1;         % Personal Acceleration Coefficient
    c2 = params.c2;         % Social Acceleration Coefficient

    % The Flag for Showing Iteration Information
    ShowIterInfo = params.ShowIterInfo;    

    MaxVelocity = 0.2*(VarMax-VarMin);
    MinVelocity = -MaxVelocity;
    
    %% Initialization

    % The Particle Template
    empty_particle.Position = [];
    empty_particle.Velocity = [];
    empty_particle.Cost = [];
    empty_particle.Best.Position = [];
    empty_particle.Best.Cost = [];

    % Create Population Array
    particle = repmat(empty_particle, nPop, 1);

    % Initialize Global Best
    GlobalBest.Cost = inf;

    % Initialize Population Members
    for i=1:nPop

        % Generate Random Solution
        particle(i).Position = (VarMax - VarMin) * rand(VarSize);
        d=distc(x,y,particle(i).Position(1),particle(i).Position(2));
        particle(i).Position=[x(d),y(d)];
        
        % Initialize Velocity
        particle(i).Velocity = zeros(VarSize);
        % Evaluation
        for lmn=1:n
            en(lmn)=5.0;
        end
        for lmn=1:length(nod)
            en(nod(lmn))=6.5;
        end
        
        en(distc(x,y,particle(i).Position(1),particle(i).Position(2)))=6.5;
           
        [nn, nn_dist] = calculate_nearest_neighbour(x, y, SinkX, SinkY);
        mv = calculate_multiplier(size(x, 2), nn);
        ddd=distc(x,y,particle(i).Position(1),particle(i).Position(2));
         particle(i).Cost = 1/(direct(x,y,SinkX,SinkY,n,en,dist_direct));
         
        en(distc(x,y,particle(i).Position(1),particle(i).Position(2)))=5.0;
        
        for lmn=1:length(nod)
            en(nod(lmn))=6.5;
        end
        
        
        c=distc(x,y,particle(i).Position(1),particle(i).Position(2));

        if ismember(c,nod)
            Particle(i).Cost=1;
        end
        % Update the Personal Best
        
        particle(i).Best.Position = [x(c),y(c)];
        particle(i).Best.Cost = particle(i).Cost;
        
        
        
        % Update Global Best
        if particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest = particle(i).Best;
            nodes=c;
        end
        
        

    end

    % Array to Hold Best Cost Value on Each Iteration
    BestCosts = zeros(MaxIt, 1);


    %% Main Loop of PSO

    for it=1:MaxIt

        for i=1:nPop
            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position) ...
                + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);

            % Apply Velocity Limits
            particle(i).Velocity = max(particle(i).Velocity, MinVelocity);
            particle(i).Velocity = min(particle(i).Velocity, MaxVelocity);
            
            % Update Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;
            d=distc(x,y,particle(i).Position(1),particle(i).Position(2));
            particle(i).Position=[x(d),y(d)];
            % Apply Lower and Upper Bound Limits
            particle(i).Position = max(particle(i).Position, VarMin);
            particle(i).Position = min(particle(i).Position, VarMax);

            % Evaluation
            
        en(distc(x,y,particle(i).Position(1),particle(i).Position(2)))=6.5;
        particle(i).Cost = 1/(direct(x,y,SinkX,SinkY,n,en,dist_direct));
         
        en(distc(x,y,particle(i).Position(1),particle(i).Position(2)))=5.0;
        
        for lmn=1:length(nod)
            en(nod(lmn))=6.5;
        end
             
           
         c=distc(x,y,particle(i).Position(1),particle(i).Position(2));
           
           if ismember(c,nod)
            Particle(i).Cost=1;
            end  
            % Update Personal Best
          
            
            if particle(i).Cost < particle(i).Best.Cost

            particle(i).Best.Position = [x(c),y(c)];
            particle(i).Best.Cost = particle(i).Cost;
        
                % Update Global Best
                if particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest = particle(i).Best;
                    nodes=c;
                end            

            end

        end

        % Store the Best Cost Value
        BestCosts(it) = GlobalBest.Cost;

        % Display Iteration Information
        if ShowIterInfo
            disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it)) ': Lifetime = ' num2str(1/BestCosts(it))]);
        end

        % Damping Inertia Coefficient
        w = w * wdamp;

    end
    
    out.pop = particle;
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
    out.nod=nodes;
    
end