% ---------- JACOBIANO TRIANGULO ----------
%
%     Programa para calcular el jacobiano
%     de un triángulo para el MEF del Ej2
%
% --------------- PARAMETROS --------------
%
%   P1: primer nodo, coordenadas xi,yi
%   P2: segundo nodo, coordenadas xj,yj
%   P3: tercer nodo, coordenadas xk,yk
%
% -----------------------------------------

function j=jacobianoTriangulo(p1,p2,p3)
  % coordenadas de puntos
  xi=p1(1);  yi=p1(2);
  xj=p2(1);  yj=p2(2);
  xk=p3(1);  yk=p3(2);

  u = [xk-xi,yk-yi];  v = [xj-xi,yj-yi];

  % áreas los triángulos
  areaTR = 1/2; % t referencia
  determinante= u(1)*v(2)-u(2)*v(1);
  areaT = (1/2)*determinante;

  j = abs(areaT / areaTR);

  endfunction
