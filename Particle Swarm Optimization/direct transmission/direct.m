function count = direct(x,y,Sx,Sy,n,en,dist_direct)

    lifetime = 0;
    energy = 0;
    dead = 0;
    Rounds = 1;
    
 
    count=0;
    Elec = 50*0.000000001; % Eelec = 50nJ/bit energy tranfer and receive
    Efs = 10*0.000000000001 ;% energy free space
    Emp = 0.0013*0.000000000001; %energy multi path
    Kbit = 2000; % size  
    
    d0 = sqrt(Efs / Emp);
        
   while dead == 0
        for i = 1 : length(x)
            if (dist_direct(i) <= d0)
                energy = Kbit * Elec + Efs * (dist_direct(i)^2) * Kbit;
            else
                energy = Kbit * Elec + Emp * (dist_direct(i)^4) * Kbit;                
            end
            en(i) = en(i) - energy;
            if en(i) <= 0
                en(i) = 0;
                count = Rounds;
                dead = 1;
               return
            end
        end
        Rounds = Rounds + 1;
   end
  end


