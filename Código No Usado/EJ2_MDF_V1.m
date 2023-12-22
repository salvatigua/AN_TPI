% ---------------- EJ2_MDF_V1 -----------------
%
%   Programa de resolución del ej2
%  con el método de diferencias finitas
%
% --------------- PARAMETROS ---------------
%
%  L = longitud
%  n: cantidad de nodos sobre un eje
%  c1 = condición frontera inferior
%  c2 = condición frontera superior
%  c3 = condición frontera izquierda
%  c4 = condición frontera derecha
%  gr: booleano para graficar la solución
%
% ------------------------------------------

function V = EJ2_MDF(L=1,n=25,c1=0,c2=1,c3=0,c4=0, gr=1);

   tn = n*n;    %Cantidad total de nodos

   % Matriz A y vector b
   A = zeros(tn,tn);
   b = zeros(tn,1);

   % Distancia e intervalos
   h = L /(n-1);
   x = [0:h:L];
   y = [0:h:L];

   % Matriz y vector sin condiciones

   for i=2:n-1        % puntos interiores
        for j=2:n-1

              f=i+(j-1)*n;          % fila

              A(f,f-1)=-1;  %i-1,j
              A(f,f+1)=-1;  %i+1,j

              A(f,f)=4;     %i,j

              A(f,i+(j-2)*n)=-1;    %i,j-1
              A(f,i+j*n)=-1;        %i,j+1

              b(f)=0;

        endfor;
   endfor;

   % Condiciones de borde

   for j=2:n-1 % puntos de frontera izquierda y derecha

         % izquierda
         i=1;
         f = i+(j-1)*n;
         A(f,f)=1;        % elemento de diagonal, pues i=j
         b(f)= c3;

         % derecha
         i=n;
         f = i+(j-1)*n;
         A(f,f)=1;        % elemento de diagonal, pues i=j
         b(f)= c4;

   endfor;

   for i=1:n % puntos de frontera inferior y superior

         % inf
         j=1;
         f=i+(j-1)*n;
         A(f,f)=1;        % elemento de diagonal, pues i=j
         b(f)= c1;

         %sup
         j=n;
         f=i+(j-1)*n;
         A(f,f)=1;        % elemento de diagonal, pues i=j
         b(f)= c2;

   endfor;

   V=A\b;

   if gr==1
     graficarMalla(x,y,V');
   endif

endfunction;
