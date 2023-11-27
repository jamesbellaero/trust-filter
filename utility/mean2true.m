function [ f ] = mean2true( M,e )
E=mean2ecc(M,e);
f=ecc2true(E,e);

end

