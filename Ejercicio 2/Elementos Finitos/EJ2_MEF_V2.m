% ---------------- EJ2_MEF_V2 -----------------
%
%        Programa de resolución del ej2
%      con el método de elementos finitos
%       usando triángulos de referencia
%
% ---------------- PARAMETROS -----------------
%
%  x: longitud
%  y: altura
%  m: cantidad de nodos sobre x
%  n: cantidad de nodos sobre y
%  ci: i-ésima condición
%  tr: booleano para graficar triangulación
%  dat: booleano para guardar datos
%  gr: booleano para graficar la solución
%
% ---------------------------------------------

function v = EJ2_MEF_V2(x=1,y=1,m=10,n=10, c1=0,c2=1,c3=0,c4=0, tr=0, dat=0, gr=0);

 mn = m*n; %Cantidad total de nodos

 A = zeros(mn,mn);   b = zeros(mn,1);

 h = x/(m-1);        k = y/(n-1);
 x = [0:h:x];        y = [0:k:y];

 x_aux = x;          y_aux = y;

 T = generarTriangulacion(m,n);
 N = generarNodos(n,m,1);

  % Guardar datos en archivo de texto
  if dat==1
    guardar_matrices(N,T,'matrices_EJ2_MEF.txt');
  end

  % Graficar triangulación y guardarla en un archivo
  if tr==1
    mostrar_triangulacion(N,T,'malla_y_triangulacion.png');
  end

% ------------- RESOLUCIÓN INTERIOR ----------------------

 for j=1:length(T)

     % Obtenemos las coordenadas de los nodos (Ej: x=[0,0.1,0] y=[0,0,0.1])
     x = [N(T(j,1),1), N(T(j,2),1), N(T(j,3),1)];
     y = [N(T(j,1),2), N(T(j,2),2), N(T(j,3),2)];

     % Obtenemos los puntos
     P1=[x(1),y(1)];
     P2=[x(2),y(2)];
     P3=[x(3),y(3)];

     % Obtenemos el jacobiano del triángulo
     jac = jacobianoTriangulo(P1,P2,P3);

     % Matriz elemental
         a11 = jac;
         a12 = -jac/2;
         a13 = -jac/2;
         a21 = a12;
         a22 = jac/2;
         a23 = 0;
         a31 = a13;
         a32 = a23;
         a33 = jac/2;

         A_elem = [a11 a12 a13; a21 a22 a23; a31 a32 a33];

     % Ensamblaje en matriz global
     A([T(j,1) T(j,2) T(j,3)],[T(j,1) T(j,2) T(j,3)]) = A([T(j,1), T(j,2) T(j,3)],[T(j,1) T(j,2) T(j,3)]) + A_elem;

endfor;

% ------------- CONDICIONES DE BORDE ---------------------

for i=1:m % puntos de frontera inferior y superior
     j=1; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c1;
     j=n; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c2; % 1
 endfor;

 for j=2:n-1 % puntos de frontera iquierda y derecha
     i=1; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c3;
     i=m; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c4;
 endfor;

% ------------- SOLUCIÓN Y GRÁFICO  ----------------------

 v = A\b;

 if gr==1
   graficarMalla_MEF(x_aux,y_aux,v'); %Presentacion del resultado
 endif

endfunction;

