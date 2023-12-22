% ------------------- EJ2_SA --------------------
%
%         Programa que calcula la solución
%                analítica del ej2
%
% ------------------ PARAMETROS -----------------
%
%  w = ancho de la caja (en metros)
%  h = alto de la caja (en metros)
%  m = numero de nodos sobre el eje x
%  n = numero de nodos sobre el eje y
%  k_inf = numero de iteraciones k
%  V0 = potencial eléctrico V0
%  gr: booleano para graficar la solución
%
% -----------------------------------------------

function v = EJ2_SA(w=1,h=1,m=20,n=20, k_inf=100, V0=1,gr=1);

 % Discretización
 p = w/(m-1);     % distancia de intervalos en x
 k = h/(n-1);     % distancia de intervalos en y
 x = [0:p:w];     % puntos en el eje x
 y = [0:k:h];     % puntos en el eje y

 % Definición función analítica
 f = @(x,y,k) ((sin(((((2*k)-1)*pi).*x)./w)).*(sinh(((((2*k)-1)*pi).*y)./w)))./(((2*k)-1)*(sinh((((2*k)-1)*pi*h)/w)))

 % Matrices de solución y nodos
 V = zeros(m*n,1);
 N = nodos_SA(x,y,m,n);

 % Solución
 k = 0;
 for k=1:k_inf
     V_ant = V;
     V = V_ant + f(N(:,1),N(:,2),k);
 endfor;
 v = (4*V0/pi).*V;

 % Gráfico de función
 if gr==1
   graficarMalla_MDF(x,y,v);
 endif

endfunction
