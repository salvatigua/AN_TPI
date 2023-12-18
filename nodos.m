% ------------------ NODOS ------------------
%
%     Programa para guardar valores x
%  e y de una malla rectangular en nodos
%
% --------------- PARAMETROS ----------------
%
%  n: cantidad de nodos sobre x
%  m: cantidad de nodos sobre y
%
% --------------- DEVUELVE ------------------
%
%  (x, y, fontera (bool)) # coord nodo i
%
% -------------------------------------------

function N = nodos(x,y,n,m);

   M = n*m;           # Cant total de nodos
   N = zeros(M,3);    # Matriz

   N(1:m:M,3) = 1;    # Frontera izquierda
   N(1:m,3) = 1;      # Frontera inferior
   N(M-m+1:M,3) = 1;  # Frontera superior
   N(m:m:M,3) = 1;    # Frontera derecha

   k = 1;             # Contador

   for j=1:n:M
       N(j:j+n-1,1) = x;
       N(j:j+n-1,2) = y(k);
       ++k;
   endfor;


endfunction;
