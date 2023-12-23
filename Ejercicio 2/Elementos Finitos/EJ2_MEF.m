% ---------------- EJ2_MEF -----------------
%
%   Programa de resolución del ej2
%  con el método de elementos finitos
%
% ---------------- PARAMETROS -----------------
%
%  x: longitud = altura de la caja
%  m: cantidad de nodos sobre un eje
%  ci: i-ésima condición
%  tr: booleano para graficar triangulación
%  dat: booleano para guardar datos
%  gr: booleano para graficar solución
%
% ---------------------------------------------

function v = EJ2_MEF(x=1,m=20,c1=0,c2=1,c3=0,c4=0, tr=0, dat=0, gr=1);

 mn = m*m; %Cantidad total de nodos

 A = zeros(mn,mn);
 b = zeros(mn,1);

 h = x/(m-1);
 y = x;
 x = [0:h:x];
 y = [0:h:y];

 x_aux = x;
 y_aux = y;

 T = generarTriangulacion(m,m);
 N = generarNodos(m,m,1);

 % Guardar datos en archivo de texto
 if dat==1
   guardar_matrices(N,T,'matrices_EJ2_MEF.txt');
 end

 % Graficar triangulación y guardarla en un archivo
 if tr==1
   mostrar_triangulacion(N,T,'malla_y_triangulacion.png');
 end

% ------------------------------------------------

 for j=1:length(T)

     % Obtenemos las coordenadas de los nodos (Ej: x=[0,0.1,0] y=[0,0,0.1])
     x = [N(T(j,1),1), N(T(j,2),1), N(T(j,3),1)];
     y = [N(T(j,1),2), N(T(j,2),2), N(T(j,3),2)];

     % Área de cada triángulo
     aT = (1/2)*(x(1)*(y(2)-y(3))+x(2)*(y(3)-y(1))+x(3)*(y(1)-y(2)));

     % Matriz elemental
         a11 = ((y(2)-y(3))^2 + (x(3)-x(2))^2);
         a12 = ((y(2)-y(3))*(y(3)-y(1)) + (x(3)-x(2))*(x(1)-x(3)));
         a13 = ((y(2)-y(3))*(y(1)-y(2)) + (x(3)-x(2))*(x(2)-x(1)));
         a21 = a12;
         a22 = (y(3)-y(1))^2 + (x(1)-x(3))^2;
         a23 = ((y(3)-y(1))*(y(1)-y(2)) + (x(1)-x(3))*(x(2)-x(1)));
         a31 = a13;
         a32 = a23;
         a33 = (y(1)-y(2))^2 + (x(2)-x(1))^2;

         A_elem = [a11 a12 a13; a21 a22 a23; a31 a32 a33];

     % Ensamblaje en matriz global
     A([T(j,1) T(j,2) T(j,3)],[T(j,1) T(j,2) T(j,3)]) = A([T(j,1), T(j,2) T(j,3)],[T(j,1) T(j,2) T(j,3)]) + A_elem.*((1/4)*aT);

endfor;

for i=1:m % puntos de frontera inferior y superior
     j=1; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c1;
     j=m; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c2; % 1
 endfor;

 for j=2:m-1 % puntos de frontera iquierda y derecha
     i=1; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c3;
     i=m; A(i+(j-1)*m,:)=0; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c4;
 endfor;

 v = A\b;

 if gr==1
  graficarMalla_MEF(x_aux,y_aux,v'); %Presentacion del resultado
 end
endfunction;

