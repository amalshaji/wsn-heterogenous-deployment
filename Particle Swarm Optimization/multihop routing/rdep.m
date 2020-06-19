function op = rdep() %n : no of nodes,breadth =terrain dimension

fprintf('***********************************************\n\n');
fprintf('           Prticle Swarm Optimization           \n\n');
fprintf('***********************************************\n\n');
format long
tic
%% Random number generation


%% variable initializations
%{
%MaxInterval=100;
n=input('Number of Nodes: ');
SinkX = input('SinkX: ');
SinkY = input('SinkY: ');
SinkID = 1212;
breadth=input('Terrain Size: ');
%}
%Rounds=0;
%actual_rounds=0;
prompt = {'Number of Sensor Nodes', 'Size of Terrain(x)', 'X coordinate of Sink', 'Y coordinate of Sink','No. of Heteroneous Nodes','No. of Iterations'};
title = 'Direct Transmission PSO Algorithm';
dims = [1 70];
definput = {'50','100','50','50','5','30'};
answer = inputdlg(prompt,title,dims,definput);

n=str2double(answer{1});
breadth=str2double(answer{2});
SinkX=str2double(answer{3});
SinkY=str2double(answer{4});
Hetero=str2double(answer{5});
Ite=str2double(answer{6});
Tr=sqrt(breadth^2 +breadth^2); % maximum transmission range for a node to cover the whole node

%% Random deployment
for i = 1 : n
     x(i) = rand();
     y(i) = rand();
end
x = x.*breadth;
y = y.*breadth;

fileID=fopen('Written.txt','w');
for ijk=1:n
    fprintf(fileID,'%12.8f %12.8f \n',x(ijk),y(ijk));
end
fclose(fileID);


 p={x,y,SinkX,SinkY,n,breadth,Hetero,Ite};
 op=p;

end

