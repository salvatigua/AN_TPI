% ------------- EJ2_ERROR_MDF -------------
%
%   Programa de análisis del error del ej2
%      del método de diferencias finitas
%
% --------------- PARAMETROS --------------
%
% w : longitud en metros de un lado de caja
% n : cantidad de nodos sobre un eje
% guardar : guardar archivo .png con gráfico
%
% -----------------------------------------

function u = EJ2_ERROR_MDF (w=1, n=25, guardar=0)

   % Cálculo de los valores de f y u en los puntos X
   f_values = EJ2_SA(w,w,n,n,k_inf=100,V0=1,gr=0);
   v_values = EJ2_MDF(w,n,gr=0);

   % Cálculo del error
   error = v_values - f_values;

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

   if guardar==1
     saveas(gcf, 'ej2_error_mdf.png');
   endif

   u = error

endfunction
