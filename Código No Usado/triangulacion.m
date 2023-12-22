% -------------- TRIANGULACIÓN --------------
%
%     Programa para dividir una malla
%        rectangular en triángulos
%
% --------------- PARAMETROS ----------------
%
%  m: cantidad de cuadrados sobre x
%  n: cantidad de cuadrados sobre y
%
% --------------- DEVUELVE ------------------
%
%  (N1, N2, N3), Ni: i-ésimo nodo
%
% -------------------------------------------

function T = triangulacion(m,n);

N = 2*m*n;       # Cantidad de triangulos
T = zeros(N,3);  # Matriz

T(1,1) = 1;
T(1,2) = 2;
T(1,3) = m+2;
T(2,1) = 2;
T(2,2) = m+3;
T(2,3) = T(1,3);

j = 1;
for i=3:2:(2*m)
    T(i,1) = i-j;
    T(i,2) = T(i,1)+1;
    T(i,3) = m+1+T(i,1);
    T(i+1,1) = T(i,1)+1;
    T(i+1,2) = m+1+T(i,2);
    T(i+1,3) = T(i,3);
    ++j;
endfor;

for k=2*m:2*m:N-(2*m)
     T(k+1:k+(2*m),:) = T(k+1-(2*m):k,:)+(m+1);
 endfor;

endfunction;

