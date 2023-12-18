% ------------- EJ1_ERROR_MDF -------------
%
%   Programa de análisis del error del ej1
%    con el método de diferencias finitas
%
% -------------- PARAMETROS ---------------
%
%  L = longitud
%  diam = diámetro de varilla
%  n = cantidad de nodos sobre un eje
%  ta = temperatura ambiente
%  t0 = temperatura extremo
%  c1 = condición frontera inferior
%  k y hp (condiciones físicas)
%  n = cantidad de nodos
%
% -----------------------------------------

function u = EJ1_ERROR_MDF (L, diam, ta, t0, hp, k, n)

   h=L/n;
   radio = diam/2;
   p= 2*pi*radio;
   area = 2*pi*radio*L + 2*pi*radio*radio;
   x=0:h:L;
   a= (hp*p)/(k*area);
   u0=t0-ta;

   % Definición de la función analítica f(x)
   function y = f(x)
       y = u0 * cosh(sqrt(a) * (L - x)) / cosh(sqrt(a) * L);
   end

   % Cálculo de los valores de f y u en los puntos X
   f_values = arrayfun(@f, x)
   u_values = EJ1_MDF(L, diam, ta, t0, hp, k, n)

   % Cálculo del error
   error = u_values' - f_values

   % Gráfica del error
   plot(x, error);
   title('Error del Método de Diferencias Finitas', 'fontsize', 32);
   xlabel('x', 'fontsize', 32);
   ylabel('Error', 'fontsize', 32);
         set(gca, 'fontsize', 24);
   grid on;

endfunction
