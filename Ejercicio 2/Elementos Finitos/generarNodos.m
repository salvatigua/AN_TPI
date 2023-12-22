% -------------- GENERAR NODOS --------------
%
%     Programa para guardar valores x
%  e y de una malla rectangular en nodos
%
% --------------- PARAMETROS ----------------
%
%  n: cantidad de nodos sobre x
%  m: cantidad de nodos sobre y
%
% --------------- DEVUELVE ------------------
%
%  (x, y, fontera (bool)) # coord nodo i
%
% -------------------------------------------
function N = generarNodos(n, m, w)

    % Inicializar matriz N
    N = zeros(n * m, 3);

    % Llenar matriz N con coordenadas y etiquetas de frontera
    for i = 1:n
        for j = 1:m
            index = (i - 1) * m + j;
            N(index, 1) = (i - 1) * w / (n - 1);     % Coordenada x
            N(index, 2) = (j - 1) * w / (m - 1);     % Coordenada y
            N(index, 3) = (i == 1 || i == n || j == 1 || j == m); % Booleano de frontera
        end
    end

end
