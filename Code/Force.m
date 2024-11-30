    
function [Fx,Fy,Fz]=Force(N,Bins,COM,OT,theta)

    Fx=zeros(N,1);
    Fy=zeros(N,1);
    Fz=zeros(N,1);
for i=1:N %for each body (point)
    for j=1:length(Bins) %for each Bin (cube)
        if isempty(Bins{j}) == 0
                    if size(Bins{j},1) == 1 %if cube contains one body
                        if OT.Points(i,1:4) ~= Bins{j}(1, 1:4)
                            r = sqrt((Bins{j}(1,1)-OT.Points(i,1))^2+ (Bins{j}(1,2)-OT.Points(i,2))^2+ (Bins{j}(1,3)-OT.Points(i,3))^2); %distance from point to body
                            Fx(i,1) = Fx(i,1) + Bins{j}(1,4)*(Bins{j}(1,1)-OT.Points(i,1))/r^3; %Force from body on point
                            Fy(i,1) = Fy(i,1) + Bins{j}(1,4)*(Bins{j}(1,2)-OT.Points(i,2))/r^3;
                            Fz(i,1) = Fz(i,1) + Bins{j}(1,4)*(Bins{j}(1,3)-OT.Points(i,3))/r^3;
                            
                        end
                    else
                        r2 = sqrt((COM(j,1)-OT.Points(i,1))^2+(COM(j,2)-OT.Points(i,2))^2+(COM(j,3)-OT.Points(i,3))^2);
                        theta=Bins{j}(1,5)/r2; %distance from point to center of mass of cube
                        if theta<theta %we approximate force on point
                            Fx(i,1) = Fx(i,1) + sum(Bins{j}(:,4))*(COM(j,1)-OT.Points(i,1))/r2^3;
                            Fy(i,1) = Fy(i,1) + sum(Bins{j}(:,4))*(COM(j,2)-OT.Points(i,2))/r2^3;
                            Fz(i,1) = Fz(i,1) + sum(Bins{j}(:,4))*(COM(j,3)-OT.Points(i,3))/r2^3;
                        else
                            for k=1:size(Bins{j},1)
                                if OT.Points(i,1:4) ~= Bins{j}(k, 1:4)
                                    r3 = sqrt((Bins{j}(k,1)-OT.Points(i,1))^2+ (Bins{j}(k,2)-OT.Points(i,2))^2+ (Bins{j}(k,3)-OT.Points(i,3))^2); %distance from point to body
                                    Fx(i,1) = Fx(i,1) + Bins{j}(k,4)*(Bins{j}(k,1)-OT.Points(i,1))/r3^3; %Force from body on point
                                    Fy(i,1) = Fy(i,1) + Bins{j}(k,4)*(Bins{j}(k,2)-OT.Points(i,2))/r3^3;
                                    Fz(i,1) = Fz(i,1) + Bins{j}(k,4)*(Bins{j}(k,3)-OT.Points(i,3))/r3^3;
                                end
                            end
                        end
                    end
        end
    end
end
end
                                
                            
                            
                        



