% ---------------- EJ2_MDF_V2 -----------------
%
%   Programa de resolución del ej2
%  con el método de diferencias finitas
%
% ------------------------------------------

function V = EJ2_MDF_V2(L=1,n=25);

% Parámetros del problema
w = L;    % Longitud de la caja en la dirección x
h = L;    % Altura de la caja en la dirección y
nx = n; % Número de nodos en la dirección x
ny = n; % Número de nodos en la dirección y

% Discretización del dominio
dx = w / (nx - 1);
dy = h / (ny - 1);

% Inicialización de la matriz A y el vector b
A = zeros(nx * ny, nx * ny);
b = zeros(nx * ny, 1);

% Construcción de la matriz A y el vector b (código anterior)
for i = 1:nx
    for j = 1:ny
        k = (j - 1) * nx + i; % Índice global del nodo (i, j)

        % Condiciones de contorno
        if i == 1 || i == nx || j == 1
            A(k, k) = 1;
            b(k) = 0;
        elseif j == ny
            A(k, k) = 1;
            b(k) = 1;
        else
            % Diferencias finitas para la ecuación de Laplace
            A(k, k) = -4;
            A(k, k - 1) = 1;
            A(k, k + 1) = 1;
            A(k, k - nx) = 1;
            A(k, k + nx) = 1;

            % Vector b
            b(k) = 0;
        end
    end
end

A

% Resolución del sistema de ecuaciones lineales
V = A \ b;

% Reshape del vector solución en una matriz para la visualización
V_matrix = reshape(V, nx, ny)';

% Llamada a la función para graficar la malla con rotación de 90 grados a la izquierda
graficarMalla(linspace(0, w, nx), linspace(0, h, ny), V_matrix');

end

