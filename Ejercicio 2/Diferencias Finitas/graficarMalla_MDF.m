% ----------- GRÁFICAR MALLA -----------
%
%    Programa para graficar mallas
%  para diferencias finitas del Ej 2
%
% ------------- PARAMETROS -------------
%
%  x: conjunto de puntos x
%  y: conjunto de puntos y
%  z: variable que depende de x e y
%
% --------------------------------------

function graficarMalla_MDF(x,y,z);

     n = length(x);
     m = length(y);
     u = (reshape(z,n,m))';

     figure(1)
     meshc(x,y,u)

     figure(2)
     contourf(x,y,u)

     figure(3)
     [XX, YY] = meshgrid(x, y);
     surf(XX, YY, u)
     xlabel('x')
     ylabel('y')
     shading('flat')

endfunction
