rng default;

for i=1:100
    x(i)=rand()*100;
    y(i)=rand()*100;
    en(i)=0.5;
end
SinkX=50;
SinkY=50;
[nn, nn_dist] = calculate_nearest_neighbour(x, y, SinkX, SinkY);
mv = calculate_multiplier(size(x, 2), nn);
nod=[];
for j=1:5
    for i=1:length(nod)
        en(nod(i))=2;
    end
    
    en(1)=2;
    mi=multihop_transmission(x, y, en, SinkX, SinkY, nn_dist, mv);
    k=1;
    en(1)=0.5;
    
    for i=1:length(nod)
        en(nod(i))=2;
    end
    
    for i=1:100
    en(i)=2;
    if multihop_transmission(x, y, en, SinkX, SinkY, nn_dist, mv)>mi
        mi=multihop_transmission(x, y, en, SinkX, SinkY, nn_dist, mv)
        k=i
        nod=[nod k]
    end
    if ~ismember(i,nod)
    en(i)=0.5;
    end
    
end
en(k)=2;
end