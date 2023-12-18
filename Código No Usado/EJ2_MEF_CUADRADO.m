% ------------- EJ2_MEF_CUADRADO --------------
%
%   Programa de resolución del ej2
%  con el método de elementos finitos
%
% ---------------- PARAMETROS -----------------
%
%  L: longitud
%  m: cantidad de nodos sobre x
%  n: cantidad de nodos sobre y
%  ci: i-ésima condición
%
% ---------------------------------------------

function v = EJ2_MEF_CUADRADO(L=1,m=10,n=10, c1=0,c2=1,c3=0,c4=0);

 mn = m*n; %Cantidad total de nodos

 A = zeros(mn,mn);
 b = zeros(mn,1);

 h = L/(m-1);
 k = L/(n-1);
 x = [0:h:L];
 y = [0:k:L];

 x_aux = x;
 y_aux = y;

 T = triangulacion(m-1,n-1);
 N = nodos(x,y,m,n);
% -----------------------------------

% Guarda los resultados en un archivo de texto
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
fprintf(fid, 'N1\tN2\tN3\n');
for i = 1:size(T, 1)
    fprintf(fid, '%d\t%d\t%d\n', T(i, 1), T(i, 2), T(i, 3));
end


fclose(fid); % Cierra el archivo

% -----------------------------------

% Grafica la malla
figure(5);
scatter(N(:, 1), N(:, 2), 'filled'); % Dibuja los nodos como puntos

hold on; % Mantén la figura actual para agregar la triangulación

% Dibuja las líneas de la triangulación
for i = 1:size(T, 1)
    x_coords = N(T(i, :), 1);
    y_coords = N(T(i, :), 2);
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

% Ajusta los límites de la gráfica si es necesario
% axis([xmin, xmax, ymin, ymax]);

% Ajusta la resolución
dpi = 500; % Puedes ajustar este valor según tus necesidades

% Crea una estructura de opciones para establecer la resolución
print_options = sprintf('-r%d', dpi);

outputFileName = 'malla_y_triangulacion.png'; % Nombre del archivo de salida
print(gcf, outputFileName, '-dpng', print_options);

% Guarda la figura si lo deseas
%saveas(gcf, 'malla_y_triangulacion.png');

% -----------------------------------

 for j=1:length(T)
 x = [N(T(j,1),1), N(T(j,2),1), N(T(j,3),1)];
 y = [N(T(j,1),2), N(T(j,2),2), N(T(j,3),2)];

 # aT = area triangulo elemental
 aT = (1/2)*((x(2)*y(3)-x(3)*y(2))+(x(3)*y(1)-x(1)*y(3))+(x(1)*y(2)- x(2)*y(1)));

 # Matriz elemental
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
 # fin Matriz elemental

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

 %Presentacion del resultado
 graficarMalla(x_aux,y_aux,v');

endfunction;

