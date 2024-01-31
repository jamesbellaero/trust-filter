function [ R ] = getFullRotationMatrix( angles,order )%A 321 rotation is ordered as 3,2,1, with 1 being the first rotation performed.
%Rotations will be multiplied in the order received in the vectors
%getFullRotationMatrix([pi/6,-pi/2,-pi/2],[2,3,1]) = getRotationMatrix(-pi/2,1)*getRotationMatrix(-pi/2,3)*getRotationMatrix(pi/6,2);
R=eye(3);
for(i=1:length(angles))
    R=R*getRotationMatrix(angles(i),order(i));
end
end
