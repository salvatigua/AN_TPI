% P1 es el primer nodo, coordenadas xi,yi
% P2 es el segundo nodo, coordenadas xj,yj
% P3 es el tercer nodo, coordenadas xk,yk
% u es el vector (xk-xi,yk-yi)
% v es el vector (xj-xi,yj-yi)

function j=jacobianoTriangulo(p1,p2,p3)
  % coordenadas de puntos
  xi=p1(1);  yi=p1(2);
  xj=p2(1);  yj=p2(2);
  xk=p3(1);  yk=p3(2);

  % vectores
  u = [xk-xi,yk-yi];  v = [xj-xi,yj-yi];

  % áreas los triángulos
  areaTR = 1/2; % t referencia
  determinante= u(1)*v(2)-u(2)*v(1);
  areaT = (1/2)*determinante;

  % jacobiano = area T / area T*
  j = areaT / areaTR;
  %j = areaTR / areaT; % CREO QUE ESTÁ MAL

  endfunction
