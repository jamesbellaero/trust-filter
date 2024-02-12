function ydot = twoBody(t,y,control,mu)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

A=zeros(6);
A(1:3,4:6)=eye(3);
A(4:6,1:3)=-eye(3)*mu/norm(y(1:3))^3;

B = zeros(6);
B(4:6,4:6) = eye(3);

ydot=A*y + B*[zeros(3,1);control];


end

