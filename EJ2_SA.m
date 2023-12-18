% ------------------- EJ2_SA --------------------
%
%         Programa que calcula la solución
%                analítica del ej2
%
% ------------------ PARAMETROS -----------------
%
%  w = ancho de la caja (en metros)
%  h = alto de la caja en metros)
%  m = numero de nodos sobre el x
%  n = numero de nodos sobre el y
%  k_inf = numero de iteraciones k (default:100)
%
% -----------------------------------------------

function v = EJ2_SA(w=1,h=1,m=20,n=20, k_inf=100, V0=1);

 p = w/(m-1);
 k = h/(n-1);

 f = @(x,y,k) ((sin(((((2*k)-1)*pi).*x)./w)).*(sinh(((((2*k)-1)*pi).*y)./w)))./(((2*k)-1)*(sinh((((2*k)-1)*pi*h)/w)))

 x = [0:p:w];
 y = [0:k:h];

 k = 0;
 V = zeros(m*n,1);
 N = nodos(x,y,m,n);

 for k=1:k_inf
     V_ant = V;
     V = V_ant + f(N(:,1),N(:,2),k);
 endfor;

 v = (4*V0/pi).*V;
 graficarMalla(x,y,v);

 endfunction
