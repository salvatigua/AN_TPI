% ---------------- EJ1_MEF ----------------
%
%   Programa de resolución del ej1
%  con el método de elementos finitos
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

function u = EJ1_MEF (L, diam, ta, t0, hp, k, n)
   h=L/n;
   radio = diam/2;
   area = 2*pi*radio*L + 2*pi*radio*radio
   p= 2*pi*radio

   x=0:h:L;
   a= (hp*p)/(k*area);
   n=length(x)

   S= 2/h + 2*a*h/3;
   E= -1/h + a*h/6;

   A=diag(S*ones(n,1))+diag(E*ones(n-1,1),1)+diag(E*ones(n-1,1),-1);

   A(1,:)=0;
   A(1,1)=1;

   A(n,:)=0;
   A(n,n-1)=E;
   A(n,n)=S/2;

   b=zeros(n,1);
   b(1)=t0-ta;

   u = A\b;

   plot(x,u,'*',x,u,'b');
   title('Aproximación por Método de Elementos Finitos', 'fontsize', 32);
   xlabel('x', 'fontsize', 32);
   ylabel('u', 'fontsize', 32);
      set(gca, 'fontsize', 24);
   grid on;

endfunction
