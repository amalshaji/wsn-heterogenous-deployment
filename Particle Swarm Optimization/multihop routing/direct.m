function count = direct(x,y,Hx,Hy,Sx,Sy,nod,n)

    lifetime = 0;
    l=length(x)-100;
    energy = 0;
    dist_direct(1 : n) = 0;
    dead = 0;
    Rounds = 1;
    for i=1:length(x)
    en(i)=0.5;
    end
    for i=1:length(nod)
        en(nod(i))=1.5;
    end
    en(distc(x,y,Hx,Hy))=1.5;
    for i=1:length(x)
        dist_direct(i)=sqrt((x(i)-Sx)^2-(y(i)-Sy)^2);
    end
    count=0;
    Elec = 50*0.000000001; % Eelec = 50nJ/bit energy tranfer and receive
    Efs = 10*0.0000000001 ;% energy free space
    Emp = 0.0013*0.0000000001; %energy multi path
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
               break;
            end
        end
        Rounds = Rounds + 1;
   end
    if count==0
        count=0;
    else
        count=1/count;
    end
  end


