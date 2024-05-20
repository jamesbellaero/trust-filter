function ydot = twoBodyJ2( t,y,control,mu)

J2 = .00108248;
R = 6378.1363;
r = norm(y(1:3));

A=zeros(6);
A(1:3,4:6)=eye(3);

J2_xx = 3/2*J2*R^2*(5*y(3)^2/r^4-1/r^2);
J2_yy = 3/2*J2*R^2*(5*y(3)^2/r^4-1/r^2);
J2_zz = 3/2*J2*R^2*(5*y(3)^2/r^4-3/r^2);

A(4:6,1:3)=(-eye(3)+diag([J2_xx,J2_yy,J2_zz]))*mu/r^3;

ydot=A*y;
end

