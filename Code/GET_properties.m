
function [rgbs, n] = GET_properties(OT,N)
max_mass = max(OT.Points(:,4));
min_mass = min(OT.Points(:,4));
format short
n = (max_mass-min_mass)/10;
rgbs = ones(N,4);
for i=1:N
    
    if OT.Points(i,4) <= n
        rgbs(i,:) = [.89 .58 .94 14];
    end
    
    if (n<OT.Points(i,4))&&(OT.Points(i,4)<=2*n)
         rgbs(i,:) = [.88 .5 .95 16];
    end
    
    if (2*n<OT.Points(i,4))&&(OT.Points(i,4)<=3*n)
        rgbs(i,:) = [.84 .33 .92 18];
    end
    
    if (3*n<OT.Points(i,4))&&(OT.Points(i,4)<=4*n)
         rgbs(i,:) = [.8 .16 .9 20];
    end
    
    if (4*n<OT.Points(i,4))&&(OT.Points(i,4)<=5*n)
         rgbs(i,:) = [.69 .02 .8 22];
    end
    
    if (5*n<OT.Points(i,4))&&(OT.Points(i,4)<=6*n)
         rgbs(i,:) = [.55 .03 .64 24];
    end
    
    if (6*n<OT.Points(i,4))&&(OT.Points(i,4)<=7*n)
         rgbs(i,:) = [.42 .02 .5 26];
    end
    
    if (7*n<OT.Points(i,4))&&(OT.Points(i,4)<=8*n)
         rgbs(i,:) = [.32 .03 .36 28];
    end
    
    if (8*n<OT.Points(i,4))&&(OT.Points(i,4)<=9*n)
         rgbs(i,:) = [.3 .05 .34 28];
    end
    
    if (9*n<OT.Points(i,4))&&(OT.Points(i,4)<=10*n)
         rgbs(i,:) = [.21 .01 .27 30];
    end
    
    if (OT.Points(i,4)>10*n)
         rgbs(i,:) = [.2 .2 .05 32];
    end
   
end
end
