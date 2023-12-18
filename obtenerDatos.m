function [N, T] = obtenerDatos(nombreArchivo)
    % Abre el archivo para lectura
    fid = fopen(nombreArchivo, 'r');

    % Inicializa matrices vacías para nodos y triangulación
    N = [];
    T = [];

    % Lee línea por línea del archivo
    while ~feof(fid)
        % Lee la línea actual
        linea = fgetl(fid);

        % Verifica si la línea contiene información numérica
        if ~isempty(str2num(linea))
            % Convierte la línea en un vector de números
            datos = str2num(linea);

            % Determina si la línea pertenece a nodos o triangulación
            if length(datos) == 2
                % Es una línea de nodos
                N = [N; datos];
            elseif length(datos) == 4
                % Es una línea de triangulación
                T = [T; datos(2:4)];
            end
        end
    end

    % Cierra el archivo
    fclose(fid);
end

