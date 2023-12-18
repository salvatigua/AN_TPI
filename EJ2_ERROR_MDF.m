% ------------- EJ2_ERROR_MDF -------------
%
%   Programa de análisis del error del ej2
%      del método de diferencias finitas
%
% --------------- PARAMETROS --------------
%
%  w: longitud de lado de caja cuadrada
%  n: cantidad de nodos
%
% -----------------------------------------

function u = EJ2_ERROR_MDF (w=1, n=25)

   % Cambiar el motor de gráficos a 'fltk' para evitar la visualización de gráficos
   original_toolkit = graphics_toolkit;
   graphics_toolkit('fltk');

   % Cálculo de los valores de f y u en los puntos X
   f_values = EJ2_SA(w,w,n,n,k_inf=100,V0=1);
   v_values = EJ2_MDF_V1(w,n,c1=0,c2=1,c3=0,c4=0);
   %v_values = EJ2_MDF_V2(w,n);

   % Restaurar el motor de gráficos original
   graphics_toolkit(original_toolkit);

   % Cálculo del error
   error = v_values - f_values

   % Creamos X
   error_long=length(error)-1;
   h = w /(error_long);
   x = [0:h:w];

   % Gráfica del error
   figure(4);
   plot(x, error);
   title('Error del Método de Diferencias Finitas');
   xlabel('x');
   ylabel('Error');
         set(gca);
   grid on;

   saveas(gcf, 'ej2_error_mdf.png');

endfunction
