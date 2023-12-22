// CONSTANTES
l = 1; // largo = ancho
c = l/2; // centro
n = 7; // "nro intervalos"
r = 1/6; // radio circunferencia
tm = l/n; // tamaño de malla normal
tmr = tm/6; // tamaño de malla refinada

// PUNTOS
Point(1)={0,0,0,tm};
Point(2)={l,0,0,tm};
Point(3)={l,l,0,tm};
Point(4)={0,l,0,tm};

Point(5)={c,c,0};
Point(6)={c+r,c,0,tmr};
Point(7)={c-r,c,0,tmr};

// LÍNEAS y CÍRCULOS
Line(1)={1,2};
Line(2)={2,3};
Line(3)={3,4};
Line(4)={4,1};
Circle(5)={6,5,7};
Circle(6)={7,5,6};

// SUPERFICIE
Curve Loop(1)={1,2,3,4}; // bordes exteriores
Curve Loop(2)={5,6}; // borde interior
Plane Surface(1) = {1,2};

Mesh 2; // generamos malla de dim. 2

Mesh.SurfaceFaces=1;
Mesh.Points=1;

Save "malla.msh";