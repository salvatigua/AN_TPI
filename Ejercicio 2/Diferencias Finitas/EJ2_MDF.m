% ---------------- EJ2_MDF_V2 ---------------
%
%   Programa de resolución del ej2
%  con el método de diferencias finitas
%
% --------------- PARAMETROS ---------------
%
% L : longitud de un lado de la caja en metros
% n : cantidad de nodos sobre un eje
% gr : booleano para graficar la solución
%
% ------------------------------------------

function V = EJ2_MDF(L=1,n=25,gr=1);

 % Discretización del dominio
 w = L;               % ancho caja
 h = L;               % alto caja
 dx = w / (n - 1);    % distancia de intervalos en x
 dy = h / (n - 1);    % distancia de intervalos en y

 % Inicialización de la matriz A y el vector b
 A = zeros(n*n, n*n);
 b = zeros(n*n, 1);

 % Construcción matriz y vector
 for i = 1:n
    for j = 1:n

        k = i + (j - 1) * n ; % Índice global del nodo (i, j)

        % Condiciones de borde
        if i == 1 || i == n || j == 1 % pared izq, der o inf, V = 0
            A(k, k) = 1;
            b(k) = 0;
        elseif j == n                 % pared superior, V = 1
            A(k, k) = 1;
            b(k) = 1;
        else
            % Diferencias finitas para la ecuación de Laplace
            A(k, k) = -4;       % nodo actual
            A(k, k - 1) = 1;    % nodo izq
            A(k, k + 1) = 1;    % nodo der
            A(k, k - n) = 1;    % nodo arriba
            A(k, k + n) = 1;    % nodo abajo
            b(k) = 0;
        end
    end
 end

 % Resolución del sistema de ecuaciones lineales
 V = A \ b;

 % Gráfico de solución numérica
 if gr==1
  V_matrix = reshape(V, n, n)';  % Reshape del vector solución en una matriz para la visualización
  graficarMalla_MDF(linspace(0, w, n), linspace(0, h, n), V_matrix'); % Llamada a la función para graficar la malla con rotación de 90 grados a la izquierda
 endif

end

