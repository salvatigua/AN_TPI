% ------------- EJ2_ERROR_MEF -------------
%
%   Programa de análisis del error del ej2
%      del método de elementos finitos
%
% --------------- PARAMETROS --------------
%
%  w: longitud de lado de caja cuadrada
%  n: cantidad de nodos
%
% -----------------------------------------

function u = EJ2_ERROR_MEF (w=1, n=10)

   % Cambiar el motor de gráficos a 'fltk' para evitar la visualización de gráficos
   original_toolkit = graphics_toolkit;
   graphics_toolkit('fltk');

   % Cálculo de los valores de f y u en los puntos X
   f_values = EJ2_SA(w,w,n,n,k_inf=100,V0=1);
   v_values = EJ2_MEF(w,w,n,n, c1=0,c2=1,c3=0,c4=0);
   v_values2 = EJ2_MEF_V2(w,w,n,n, c1=0,c2=1,c3=0,c4=0);

   % Restaurar el motor de gráficos original
   graphics_toolkit(original_toolkit);

   % Cálculo del error
   error = v_values2 - f_values

   % Creamos X
   error_long=length(error)-1;
   h = w /(error_long);
   x = [0:h:w];

   % Gráfica del error
   figure(5);
   plot(x, error);
   title('Error del Método de Elementos Finitos');
   xlabel('x');
   ylabel('Error');
   set(gca);
   grid on;

   saveas(gcf, 'ej2_error_mef.png');

% Gráfica del error entre versiones
   error = v_values - v_values2
   figure(8);
   plot(x, error);
   title('Error del Método de Elementos Finitos entre Versiones');
   xlabel('x');
   ylabel('Error');
   set(gca);
   grid on;


endfunction
