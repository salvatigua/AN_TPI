% ---------- GENERAR TRIANGULACIÓN ----------
%
%     Programa para dividir una malla
%        rectangular en triángulos
%
% --------------- PARAMETROS ----------------
%
%  m: cantidad de cuadrados sobre x
%  n: cantidad de cuadrados sobre y
%
% --------------- DEVUELVE ------------------
%
%  (N1, N2, N3), Ni: i-ésimo nodo
%
% -------------------------------------------

function T = generarTriangulacion(n, m)

    % Generar nodos
    N = generarNodos(n, m, 1);

    % Inicializar matriz T para almacenar la triangulación
    T = zeros((n - 1) * (m - 1) * 2, 3);

    % Función para obtener el índice del nodo en la matriz N
    get_index = @(i, j) (i - 1) * m + j;

    % Llenar matriz T con triángulos
    t_index = 1;
    for i = 1:n - 1
        for j = 1:m - 1
            % Nodos del cuadrado actual
            N1 = get_index(i, j);
            N2 = get_index(i + 1, j);
            N3 = get_index(i, j + 1);
            N4 = get_index(i + 1, j + 1);

            % Triángulo 1
            T(t_index, :) = [N1, N2, N3];
            t_index = t_index + 1;

            % Triángulo 2
            T(t_index, :) = [N2, N4, N3];
            t_index = t_index + 1;
        end
    end
end
