clear all; clc;
N= input('Please enter number of celestial bodies: ');
theta = input('Please enter theta: ');
pts = randn(N,3)*30;
softening = 0.1;
plotRealTime = 1;

       OT = OcTree(pts,'binCapacity',10,'style','weighted');
       %OT.shrink
       figure
       boxH = OT.plot;
       cols = lines(OT.BinCount);
       doplot3 = @(p,varargin)plot3(p(:,1),p(:,2),p(:,3),varargin{:});
       for i = 1:OT.BinCount
           set(boxH(i),'Color',cols(i,:),'LineWidth', 1+OT.BinDepths(i))
            doplot3(pts(OT.PointBins==i,:),'.','Color',cols(i,:),'markersize',22)
       end
       axis image, view(3)
       
       Bins=cell(OT.BinCount,1);
       mass = (randperm(5000,N).')*10^8;
       OT.Points(:,4) = mass; % determining mass
       points_properties = GET_properties(OT,N);  %determining color and size
       OT.Points(:,5:8) = points_properties;
       
  for i=1:OT.BinCount
      k=1;
      for j=1:size(OT.Points,1)
          if OT.PointBins(j) == i
              Bins{i}(k,:) = OT.Points(j,:);
              k=k+1;
          end
      end
  end
  
  for k=1:length(Bins)      %to remove 0 rows
      if isempty(Bins{k})==0
       A = Bins{k};    
       A(A(:,1)==0,:) = [];
       Bins{k}=A;
      end
  end
  
  COM = GetCOM(Bins);
  for i=1:length(Bins)
      if isempty(Bins{i})==0
       a = GetCubeSide(OT.BinBoundaries(i,:));
       Bins{i}(:,5) = a;
      end
      
  end
  
[Fx, Fy, Fz] = Force(N, Bins, COM, OT,theta);
G = 6.673*10^(-11);
%G=1;
acc = G*[Fx, Fy, Fz];
  
t         = 0;     % current time of the simulation
tEnd      = 100;    % time at which simulation ends
dt        = 0.1;  % timestep

Nt = ceil(tEnd/dt);
vel = randn(N,3);
% vel = zeros(N,3);
t_all = (0:Nt)*dt;
pos_save = zeros(N,3,Nt+1);
pos_save(:,:,1) = OT.Points(:,1:3);
fh = figure;

for i=1:Nt
    
    vel = vel + acc*dt/2;
    OT.Points(:,1:3) = OT.Points(:,1:3) + vel*dt;
    OT = OcTree(OT.Points(:,1:3),'binCapacity',10,'style','weighted');
           Bins=cell(OT.BinCount,1);
           OT.Points(:,4) = mass;
           OT.Points(:,5:8) = points_properties;
           
  for x=1:OT.BinCount
      k=1;
      for j=1:size(OT.Points,1)
          if OT.PointBins(j) == x
              Bins{x}(k,:) = OT.Points(j,:);
              k=k+1;
          end
      end
  end
  
  for k=1:length(Bins)      %to remove 0 rows
      if isempty(Bins{k})==0
       A = Bins{k};    
       A(A(:,1)==0,:) = [];
       Bins{k}=A;
      end
  end
    COM = GetCOM(Bins);
     for n=1:length(Bins)
      if isempty(Bins{n})==0
       a = GetCubeSide(OT.BinBoundaries(n,:));
       Bins{n}(:,5) = a;
      end  
     end
     
     
    [Fx, Fy, Fz] = Force(N, Bins, COM, OT,theta);
    acc = G*[Fx, Fy, Fz];
    vel = vel + acc*dt/2;
    t = t + dt;
    
    pos_save(:,:,i+1) = OT.Points(:,1:3);
    if (plotRealTime) || (i==Nt)
        subplot(3,1,1:2)
        xx = pos_save(:,1,max(i-150,1):i);
        yy = pos_save(:,2,max(i-150,1):i);
        zz = pos_save(:,3,max(i-150,1):i);
        plot3(xx(:),yy(:),zz(:),'.','color',[.83 .66 .88]);
        hold on
        for m=1:N
            plot3(OT.Points(m,1),OT.Points(m,2),OT.Points(m,3),'.','color',[OT.Points(m,5) OT.Points(m,6) OT.Points(m,7)],'markersize',OT.Points(m,8));
        end
        
        hold off
        axis square
         axis([-100 100 -100 100 -100 100])
    end
    
        drawnow
end