function graficarSolucionPRUEBA(N, T, v)
    % N: nodos
    % T: triangulación
    % v: solución

    % Graficar la solución usando trisurf
    figure(8);
    trisurf(T, N(:, 1), N(:, 2), v, 'EdgeColor', 'k', 'FaceColor', 'interp');
    colorbar; % Agregar una barra de colores para representar los valores de v
    title('Solución V en el dominio');
    xlabel('Coordenada x');
    ylabel('Coordenada y');
    zlabel('Solución V');
    axis equal; % Asegura que las escalas de los ejes sean iguales

    % Opcional: Dibujar el contorno del dominio (cuadrado y círculo)
    hold on;
    rectangle('Position', [0, 0, 1, 1], 'EdgeColor', 'k', 'LineWidth', 2);
    theta = linspace(0, 2 * pi, 100);
    x_circle = 1/2 + (1/6) * cos(theta);
    y_circle = 1/2 + (1/6) * sin(theta);
    plot(x_circle, y_circle, 'k', 'LineWidth', 2);
    hold off;
end

