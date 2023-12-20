% ---------------- EJ2_MEF -----------------
%
%   Programa de resolución del ej2
%  con el método de elementos finitos
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
%  gr: booleano para graficar solución
%
% ---------------------------------------------

function v = EJ2_MEF(x=1,y=1,m=10,n=10, c1=0,c2=1,c3=0,c4=0, tr=0, dat=0, gr=0);

 mn = m*n; %Cantidad total de nodos

 A = zeros(mn,mn);
 b = zeros(mn,1);

 h = x/(m-1);
 k = y/(n-1);
 x = [0:h:x];
 y = [0:k:y];

 x_aux = x;
 y_aux = y;

 T = generarTriangulacion(m,n);
 %T = generarTriangulacionCompleta(m,n);
 N = generarNodos(n,m,1);


% --------- GUARDAR DATOS EN ARCHIVO DE TEXTO ------------

if dat==1
  outputFileName = 'resultados.txt'; % Nombre del archivo de salida
  fid = fopen(outputFileName, 'w'); % Abre el archivo para escritura

  % Escribe los datos de los nodos en el archivo
  fprintf(fid, 'Nodos:\n');
  fprintf(fid, 'x\ty\tfrontera\n');
  for i = 1:size(N, 1)
      fprintf(fid, '%f\t%f\t%d\n', N(i, 1), N(i, 2), N(i, 3));
  end

  % Escribe los datos de la triangulación en el archivo
  fprintf(fid, 'Triangulación:\n');
  fprintf(fid, 'N° Elem\tN1\tN2\tN3\n');
  %fprintf(fid, 'N° Elem\tN1\tN2\tN3\tJ\n');
  for i = 1:size(T, 1)
      %fprintf(fid, '%d\t%d\t%d\t%d\n', i, T(i, 1), T(i, 2), T(i, 3));
      fprintf(fid, '%d\t%d\t%d\t%d\n', i, T(i, 1), T(i, 2), T(i, 3), T(i,4));
  end

  fclose(fid); % Cierra el archivo
end

% --------------- GRAFICAR MALLA TRIANGULAR --------------

if tr==1
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
  outputFileName = 'malla_y_triangulacion.png'; % Nombre del archivo de salida
  print(gcf, outputFileName, '-dpng', print_options);
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
     j=1; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c1;
     j=n; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c2;
 endfor;

 for j=2:n-1 % puntos de frontera iquierda y derecha
     i=1; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c3;
     i=m; A(i+(j-1)*m,i+(j-1)*m)=1; b(i+(j-1)*m)=c4;
 endfor;

 v = A\b;

 if gr==1
  graficarMalla(x_aux,y_aux,v'); %Presentacion del resultado
 end
endfunction;

