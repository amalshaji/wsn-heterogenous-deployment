function p=distc(x,y,Sx,Sy)
dista=[];
low=999999;
n=1;
for i=1:length(x)
    dista(i)=sqrt((x(i)-Sx)^2+(y(i)-Sy)^2);
    if dista(i)<low
        low=dista(i);
        n=i;
    end
end
p=n;
end
