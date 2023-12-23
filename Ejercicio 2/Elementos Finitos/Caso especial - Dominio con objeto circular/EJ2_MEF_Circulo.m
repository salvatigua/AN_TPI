% ------------- EJ2_MEF_Circulo ---------------
%
%  Resuelve punto final del Ej 2 con MEF
%
% ---------------- PARÁMETRO ------------------
%
%  1 = GRAFICAR LA TRIANGULACION
%  0 = NO GRAFICAR LA TRIANGULACIÓN
%
% ---------------------------------------------

function v = EJ2_MEF_Circulo(tr=0);

 [N, T] = obtenerDatos('datos.txt'); % Obtenemos triangulación y nodos

 mn = size(N,1);
 A = zeros(mn,mn);   b = zeros(mn,1);
 long = 1;

if tr==1
  mostrar_triangulacion(N, T, 'malla_y_triangulacion.png')
end

% ------------------ RESOLUCIÓN INTERIOR --------------------------
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


% ------------------- CONDICIONES DE BORDE ----------------------------------

% Identificar nodos en las paredes laterales y la inferior
nodosParedInferior = find(N(:,2) == 0);
nodosParedLateralIzq = find(N(:,1) == 0);
nodosParedLateralDer = find(N(:,1) == long);

% Modificar la matriz A y el vector b para aplicar condiciones de borde
for i = nodosParedInferior
    A(i, :) = 0;
    A(i, i) = 1;
    b(i) = 0;
end

for i = nodosParedLateralIzq
    A(i, :) = 0;
    A(i, i) = 1;
    b(i) = 0;
end

for i = nodosParedLateralDer
    A(i, :) = 0;
    A(i, i) = 1;
    b(i) = 0;
end

% Aplicar condición de borde en la pared superior (V0 = 1)
nodosParedSuperior = find(N(:,2) == long);
for i = nodosParedSuperior
    A(i, :) = 0;
    A(i, i) = 1;
    b(i) = 1;
end

% -------------------------------------------------------------------

% SOLUCIÓN
 v = A\b;
 graficarSolucionCirculo(N, T, v);

endfunction;
