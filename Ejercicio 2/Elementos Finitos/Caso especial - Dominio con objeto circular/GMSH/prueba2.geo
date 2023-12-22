// CONSTANTES
l = 1; // largo = ancho
c = l/2; // centro
n = 10; // "nro intervalos"
tm = l/n; // tamaño de malla normal

// PUNTOS
Point(1)={0,0,0,tm};
Point(2)={l,0,0,tm};
Point(3)={l,l,0,tm};
Point(4)={0,l,0,tm};

// LÍNEAS y CÍRCULOS
Line(1)={1,2};
Line(2)={2,3};
Line(3)={3,4};
Line(4)={4,1};

// SUPERFICIE
Curve Loop(1)={1,2,3,4}; // bordes exteriores
Plane Surface(1) = {1};

Mesh 2; // generamos malla de dim. 2

Mesh.SurfaceFaces=1;
Mesh.Points=1;

Save "malla2.msh";