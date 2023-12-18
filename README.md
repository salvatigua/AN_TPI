# RepoAN
Acá quedará explicada la función de cada archivo.

Archivos del ejercicio 1.
1. _EJ1_MDF.m_ : resuelve el ej1 con MDF.
2. _EJ1_MEF.m_ : resuelve el ej2 con MEF.
3. _EJ1_ERROR_MDF.m_ : calcula el error de 1.
4. _EJ1_ERROR_MEF.m_ : calcula el error de 2.
  
Archivos del ejercicio 2:
5. _EJ2_SA.m_ : resuelve el ej2 analíticamente.
6. _EJ2_MDF_V1.m_ : resuleve el ej2 con MDF versión original.
7. _EJ2_MDF_V2.m_ : resuelve el ej2 con MDF versión nueva (más simple).
8. _EJ2_MEF_V1.m_ : resuelve el ej2 con MEF (método complicado).
9.  _EJ2_MEF_V2.m_ : resuelve el ej2 con MEF (con un triángulo de referencia).
10. _EJ2_ERROR_MDF.m_ : calcula el errror de 6/7.
11. - _EJ2_ERROR_MEF.m_ : calcula el error de 8/9
12. - _pruebaMEF.m_ : resuelve el último punto (cambiará de nombre).

Archivos de uso general:
13. _generarNodos.m_ : genera una matriz que tiene como columnas las coordenadas (x,y) de cada nodo (fila).
14. _generarTriangulacion.m_ : genera una matriz que tiene los nodos que componen cada triángulo (n1, n2, n3).
15. _generarTriangulacionCompleta.m_ : igual que 14 pero agrega una 4ta columna con el jacobiano del triángulo en cuestión. Usa 13.
16. _graficarMalla.m_ : grafica una malla de tres formas dados (x,y,z), siendo z lo que se quiere graficar.
17. _obtenerDatos.m_ : consigue matrices de nodos (N) y triangulación (T) a partir de un archivo de texto con datos. 
18. _jacobianoTriangulo.m_ : dados tres puntos, devuelve el jacobiano del triángulo. 
19. _nodos.m_ : similar a 13 pero necesario por cuestiones de compatibilidad con 5.
20. _triangulacion.m_ : similar a 14, más viejo.
21. _graficarSolucionPRUEBA.m_ : programa para graficar lo de 12 (cambiará de nombre).

Archivos en carpeta GMSH
22. _leer_GMSH.py_ : contiene funciones útiles para 23.
23. _leerMalla.py_ : lee malla de 'malla.msh' y guarda su información en un archivo legible por 17.
24. _malla.msh_ : generada por 26.
25. _malla2.msh_ : generada por 27.
26. _prueba.geo_ : alla legible por GMSH.
27. _prueba2.geo_ :parecida a 26, para otras pruebas. 
