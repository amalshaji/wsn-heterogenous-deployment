function lifetime = multihop_transmission(x, y, en, SinkX, SinkY, nn_dist, mv)
%DIRECT_TRANSMISSION Summary of this function goes here
%   Detailed explanation goes here
    lifetime = 0;
    n = size(x, 2);
    energy = 0;
    dist_direct(1 : n) = 0;
    dead = 0;
    Rounds = 0;

    
    Elec = 50*0.000000001; % Eelec = 50nJ/bit energy tranfer and receive
    Efs = 10*0.000000000001 ;% energy free space
    Emp = 0.0013*0.000000000001; %energy multi path
    Kbit = 2000; % size  
    Eda=5*0.000000001; %Data Aggregation Energy
    
    d0 = sqrt(Efs / Emp);
    
    for i = 1 : n
            dist_direct(i)= sqrt( (x(i)-SinkX)^2 + (y(i)-SinkY)^2 );
    end
    
    while dead == 0
        Rounds = Rounds + 1;
        for i = 1 : n
            if (nn_dist(i) <= d0)
                energy = mv(i) * Eda * Kbit + Efs * (nn_dist(i)^2) * Kbit + (mv(i)-1) * Kbit * Elec + Kbit * Elec;
            else
                energy = mv(i) * Eda * Kbit + Emp * (nn_dist(i)^4) * Kbit + (mv(i)-1) * Kbit * Elec + Kbit * Elec;                
            end
            en(i) = en(i) - energy;
            if en(i) <= 0
                en(i) = 0;
                lifetime = Rounds;
                k=i;
                dead = 1;
                return
            end
        end
    end
end

