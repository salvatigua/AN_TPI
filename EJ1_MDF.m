% ---------------- EJ1_MDF ----------------
%
%   Programa de resolución del ej1
% con el método de diferencias finitas
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

function u = EJ1_MDF (L, diam, ta, t0, hp, k, n)

  #L, diam, Ta, T0, hp, k, n
   h=L/n;
   radio = diam/2;
   area = 2*pi*radio*L + 2*pi*radio*radio;
   p= 2*pi*radio;

   x=0:h:L;
   a= (hp*p)/(k*area);
   n=length(x);


   alfa= -(2+a*(h^2));
   A=diag(alfa*ones(n,1))+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);

   A(1,:)=0;
   A(1,1)=1;

   A(n,:)=0;
   A(n,n-1)=2;
   A(n,n)=alfa;

   b=zeros(n,1);
   b(1)=t0-ta;

   u = A\b;

   plot(x,u,'*',x,u,'b');
   title('Aproximación por Método de Diferencias Finitas', 'fontsize', 32);
   xlabel('x', 'fontsize', 32);
   ylabel('u', 'fontsize', 32);
      set(gca, 'fontsize', 24);
   grid on;

endfunction
