% ---------------- PRUEBA MEF -----------------
%
%  VAMOS A USARLO PARA EL ÚLTIMO PUNTO
% VA A HABER QUE ADAPTARLO
%
% ---------------- PARÁMETRO ------------------
%
%  1 = GRAFICAR LA TRIANGULACION
%  0 = NO GRAFICAR LA TRIANGULACIÓN
%
% ---------------------------------------------

function v = pruebaMEF(graficar=0);

 [N, T] = obtenerDatos('datos.txt'); % Obtenemos triangulación y nodos

 mn = size(N,1);
 A = zeros(mn,mn);   b = zeros(mn,1);
 long = 1;

 %m=10;
 %n=m;

 % VEREMOS DESPUÉS CÓMO DEFINIR DOMINIO
 %h = largo/(m-1);        k = largo/(n-1);
 %x = [0:h:largo];        y = [0:k:largo];
 %x_aux = x;          y_aux = y;

%------------- GRAFICAR TRIANGULACIÓN -------------
if graficar==1
  % Grafica la malla
  figure(5);
  scatter(N(:, 1), N(:, 2), 'filled'); % Dibuja los nodos como puntos

  hold on; % Mantén la figura actual para agregar la triangulación

  % Dibuja las líneas de la triangulación
  for i = 1:size(T, 1)
      x_coords = N(T(i, 1:3), 1);
      %x_coords = N(T(i, :), 1);
      y_coords = N(T(i, 1:3), 2);
      %y_coords = N(T(i, :), 2);
      x_coords = [x_coords; x_coords(1)]; % Agrega el primer nodo al final para cerrar el triángulo
      y_coords = [y_coords; y_coords(1)];
      plot(x_coords, y_coords, 'b'); % Dibuja la línea que conecta los nodos del triángulo
  end

  hold off; % Termina de agregar elementos a la figura

  % Configura el aspecto de la gráfica
  xlabel('Eje X');
  ylabel('Eje Y');
  title('Malla y Triangulación');

  % Coloca la leyenda debajo del gráfico
  legend('Nodos', 'Triangulación', 'Location', 'southoutside');

  % Ajusta los límites de la gráfica (si es necesario)
  % axis([xmin, xmax, ymin, ymax]);

  % Ajusta la resolución
  dpi = 500;

  % Crea una estructura de opciones para establecer la resolución
  print_options = sprintf('-r%d', dpi);

  % Guarda figura
  outputFileName = 'C:\Users\salva\PRUEBAS MEF\malla_y_triangulacion.png'; % Nombre del archivo de salida
  print(gcf, outputFileName, '-dpng', print_options);
end

% -------------------------------------------------

% RESOLUCIÓN INTERIOR
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
nodoParedSuperior = find(N(:,2) == long);
A(nodoParedSuperior, :) = 0;
A(nodoParedSuperior, nodoParedSuperior) = 1;
b(nodoParedSuperior) = 1;

% -------------------------------------------------------------------

% SOLUCIÓN
 v = A\b

 graficarSolucionPRUEBA(N, T, v);

 %Presentacion del resultado VA A HABER QUE HACERLO DE OTRA FORMA
 % graficarMalla(x_aux,y_aux,v');

endfunction;
