function [ E ] = true2ecc( f,e )
E=atan2(sqrt(1-e^2)*sin(f),e+cos(f));
if E<0
    E=E+2*pi;
elseif E>2*pi;
    E=E-2*pi;
end
end

