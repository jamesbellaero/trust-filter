function [ M ] = true2mean( f,e )
E=true2ecc(f,e);
M=ecc2mean(E,e);

end

