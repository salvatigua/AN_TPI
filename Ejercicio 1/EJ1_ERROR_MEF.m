% ------------- EJ1_ERROR_MEF -------------
%
%  Programa de análisis del error del ej1
%    con el método de elementos finitos
%
% -------------- PARAMETROS ---------------
%
%  Mismos parámetros que EJ1_MEF
%
% -----------------------------------------

function u = EJ1_ERROR_MEF (L_mm = 100, diam_mm = 8, ta = 20, t0 = 50, hp = 200, k = 164, n = 40);

   % Conversión de unidades
   L = L_mm / 1000;         % longitud en metros
   diam = diam_mm / 1000;   % diámetro en mmetros

   % Discretización de dominio
   h = L/n;     % longitud de cada intervalo
   x=0:h:L;     % dominio

   % Radio, área y perímetro
   radio = diam/2;
   area = 2*pi*radio*L + 2*pi*radio*radio;
   p= 2*pi*radio;

   % Constantes
   a= (hp*p)/(k*area); % Constante a
   u0=t0-ta;           % Condición de borde

   % Definición de la función analítica f(x)
   function y = f(x)
       y = u0 * cosh(sqrt(a) * (L - x)) / cosh(sqrt(a) * L);
   end

   % Cálculo de los valores de f y u en los puntos X
   f_values = arrayfun(@f, x)
   u_values = EJ1_MEF(L_mm = 100, diam_mm = 8, ta = 20, t0 = 50, hp = 200, k = 164, n = 40);

   % Cálculo del error
   error = u_values' - f_values

   % Gráfica del error
   plot(x, error);
   title('Error del Método de Elementos Finitos', 'fontsize', 32);
   xlabel('x', 'fontsize', 32);
   ylabel('Error', 'fontsize', 32);
         set(gca, 'fontsize', 24);
   grid on;

endfunction
