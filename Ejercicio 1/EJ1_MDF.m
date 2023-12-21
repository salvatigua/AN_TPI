% ---------------- EJ1_MDF ----------------
%
%    Programa de resolución del Ej. 1
%  con el método de diferencias finitas
%
% -------------- PARÁMETROS ---------------
%
%  L = longitud en milímetros
%  diam = diámetro de varilla en milímetros
%  n = cantidad de nodos sobre un eje
%  ta = temperatura ambiente en °C
%  t0 = temperatura extremo en °C
%  c1 = condición frontera inferior
%  k y hp (condiciones físicas)
%  n = cantidad de nodos
%
% -----------------------------------------

function u = EJ1_MDF (L_mm = 100, diam_mm = 8, ta = 20, t0 = 50, hp = 200, k = 164, n = 40)

   % Conversión de unidades
   L = L_mm / 1000;         % longitud en metros
   diam = diam_mm / 1000;   % diámetro en mmetros

   % Discretización de dominio
   h = L/n;     % longitud de cada intervalo
   x=0:h:L;     % dominio
   n=length(x); % cantidad de puntos

   % Radio, área y perímetro
   radio = diam/2;
   area = 2*pi*radio*L + 2*pi*radio*radio;
   p= 2*pi*radio;

   % Constantes
   a= (hp*p)/(k*area); % Constante a
   erre = -(2+a*(h^2)); % Constante R

   % Resolución interior
   A=diag(erre*ones(n,1))+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);

   % Condiciones de borde
   A(1,:) = 0;
   A(1,1) = 1;

   A(n,:) = 0;
   A(n,n-1)=2;
   A(n,n)=erre;

   b = zeros(n,1);
   b(1) = t0 - ta;

   % Solulción numérica
   u = A\b;

   % Gráfico de solución
   plot(x,u,'*',x,u,'b');
   title('Aproximación por Método de Diferencias Finitas', 'fontsize', 32);
   xlabel('x', 'fontsize', 32);
   ylabel('u', 'fontsize', 32);
      set(gca, 'fontsize', 24);
   grid on;

endfunction
