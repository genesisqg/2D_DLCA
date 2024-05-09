function [conflicts,newV] = checkConflict(V,num,dx,dy,c,map)
%Checks to see is a desired move will result in an overlap of particles

sz = size(map);
N = sz(1)-1;

%construct new theoretical V
newV=V;
for b=1:num
    if V(b,3)==c %c is the cluster currently moving
        i = V(b,1);
        j = V(b,2);
        if i+dy==0
            newV(b,1)=i+N;
        elseif i+dy>sz(1)
            newV(b,1)=i-N;
        elseif j+dx==0 
            newV(b,2)=j+N;
        elseif j+dx>sz(1) 
            newV(b,2)=j-N;
        else
            newV(b,1) = V(b,1)+dy; 
            newV(b,2) = V(b,2)+dx;
        end
    end
end

conflicts=0;

for a = 1:num %Outer loop goes through new V
    if newV(a,3)==c %we only care about positions that conflict with the cluster we move
        i = newV(a,1);
        j = newV(a,2);
        
        for b = 1:num%INNER LOOP GOES THROUGH V
            k = V(b,1);
            l = V(b,2);
            index = V(b,3);
            if i==k && j==l && index~= c
                conflicts =1;
            end
        end
    end
end
