function [ R ] = getRotationMatrix( theta,n )%takes radians
    if(n==1)
        R=[1,0,0;0,cos(theta),sin(theta);0,-sin(theta),cos(theta)];
    elseif(n==2)
        R=[cos(theta),0,-sin(theta);0,1,0;sin(theta),0,cos(theta)];
    elseif(n==3)
        R=[cos(theta),sin(theta),0;-sin(theta),cos(theta),0;0,0,1];
    end
end

