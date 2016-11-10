clear all
clc
n=21;
m=21;
sr=1;
sc=1;
er=21;
ec=21;
adjm=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
heu=zeros(n,m);
cost=10000.*ones(n,m);
cost(sr,sc)=0;
f=10000.*ones(n,m);
f(sr,sc)=0;
map=zeros(n,m);
moves=zeros(n,m);
for i=1:n
    for j=1:m
        heu(i,j)=10*sqrt(abs(er-i)^2+abs(ec-j)^2);
    end
end
presr=sr;
presc=sc;
minr=presr;
minc=presc;
list=zeros(n*m,2);
countlist=0;
while(presr~=er || presc~=ec)
    min=10000;
    for i=-1:1
        for j=-1:1
            if(presr+i>0 && presc+j>0 && presr+i<=n && presc+j<=m && adjm(presr+i,presc+j)==1 && map(presr+i,presc+j)~=-1)
                if(map(presr+i,presc+j)==0)
                    countlist=countlist+1;
                    list(countlist,1)=presr+i;
                    list(countlist,2)=presc+j;
                end
                map(presr+i,presc+j)=1;
                if(f(presr+i,presc+j)>cost(presr,presc)+10*sqrt(abs(i)+abs(j))+heu(presr+i,presc+j))
                    cost(presr+i,presc+j)=cost(presr,presc)+10*sqrt(abs(i)+abs(j));
                    f(presr+i,presc+j)=cost(presr+i,presc+j)+heu(presr+i,presc+j);
                    moves(presr+i,presc+j)=100*presr+presc;
                end
            end
        end
    end
    for i=1:countlist;
        if(f(list(i,1),list(i,2))<min)
            min=f(list(i,1),list(i,2));
            minr=list(i,1);
            minc=list(i,2);
            posi=i;
        elseif(f(list(i,1),list(i,2))==min)
            if(heu(list(i,1),list(i,2))<heu(minr,minc))
                minr=list(i,1);
                minc=list(i,2);
                posi=i;
            end
        end
    end
    for i=posi:countlist-1
        list(i,1)=list(i+1,1);
        list(i,2)=list(i+1,2);
    end
    list(countlist,1)=0;
    list(countlist,2)=0;
    countlist=countlist-1;
    map(presr,presc)=-1;
    presr=minr;
    presc=minc;
end
move=[presr,presc];
disp('PATH:-')
fprintf('%d %d\n',move(1),move(2));
while(presr~=sr || presc~=sc)
    move=[floor(moves(presr,presc)/100) mod(moves(presr,presc),100)];
    fprintf('%d %d\n',move(1),move(2));
    presr=move(1);
    presc=move(2);
end
disp('COST:-');
disp(cost(er,ec))