function [a] = GetCubeSide(binboundary)
deltax = (binboundary(4)-binboundary(1))^2;
deltay = (binboundary(5)-binboundary(2))^2;
deltaz = (binboundary(6)-binboundary(3))^2;
d=sqrt(deltax+deltay+deltaz);
a=d/sqrt(3);
end

