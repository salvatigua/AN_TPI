# Análisis Numérico - Trabajo Práctico Integrador
Acá quedará explicada la estructura del repositorio.
Cabe destacar que hay veces que se repiten archivos en distintas carpetas, pero es para mantener la compatbilidad.

## Ejercicio 1
Aquí están los cuatro archivos necesarios para resolver el primer ejercicio.
1. _EJ1_MDF.m_ : resuelve el ej1 con MDF.
2. _EJ1_MEF.m_ : resuelve el ej2 con MEF.
3. _EJ1_ERROR_MDF.m_ : calcula el error de 1.
4. _EJ1_ERROR_MEF.m_ : calcula el error de 2.
  
## Ejercicio 2
Aquí están los archivos que sirven para resolver el segundo ejercicio.
Está dividido en dos carpetas, una para cada método.

### Diferencias finitas
5. _EJ2_SA.m_ : resuelve el ej2 analíticamente.
6. _nodos_SA.m_ : genera nodos para la solución analítica (5).
7. _EJ2_MDF.m_ : resuelve el ej2 con MDF.
8. _EJ2_ERROR_MDF.m_ : calcula el errror de 7.
9. _graficarMalla_MDF.m_ : grafica una malla de tres formas dados (x,y,z), siendo z lo que se quiere graficar. Sirve para el MDF

### Elementos finitos    
10. _EJ2_MEF.m_ : resuelve el ej2 con MEF (método complicado).
11.  _EJ2_MEF_V2.m_ : resuelve el ej2 con MEF (con un triángulo de referencia), todavía no funciona bien.
12. _graficarMalla_MEF.m_ : grafica una malla de tres formas dados (x,y,z), siendo z lo que se quiere graficar. Sirve para el MEF.
13. _EJ2_ERROR_MEF.m_ : calcula el error de 10/11
14. _EJ2_SA.m_ : resuelve el ej2 analíticamente.
15. _nodos_SA.m_: genera nodos para la solución analítica (14).
16. _generarNodos.m_ : genera una matriz que tiene como columnas las coordenadas (x,y) de cada nodo (fila).
17. _generarTriangulacion.m_ : genera una matriz que tiene los nodos que componen cada triángulo (n1, n2, n3).
18. _jacobianoTriangulo.m_ : dados tres puntos, devuelve el jacobiano del triángulo, se usa en el método 2. 
19. _mostrar_triangulacion.m_ : dadas las matrices N, T y un archivo de salida, grafica la triangulación y la guarda.
20. _guardar_matrices.m_ : dadas las matrices N, T y un archivo de salida, guarda los datos en un archivo .txt.

#### Caso especial - dominio con objeto circular
Aquí estará lo necesario para resolver el último punto del segundo ejercicio.

21. _pruebaMEF.m_ : resuelve el último punto (cambiará de nombre).
22. _obtenerDatos.m_ : consigue matrices de nodos (N) y triangulación (T) a partir de un archivo de texto con datos. 
23. _graficarSolucionPRUEBA.m_ : programa para graficar lo de 12 (cambiará de nombre).
24. _jacobianoTriangulo.m_ : dados tres puntos, devuelve el jacobiano del triángulo.
25. _mostrar_triangulacion.m_ : dadas las matrices N, T y un archivo de salida, grafica la triangulación y la guarda.

##### GMSH
26. _leer_GMSH.py_ : contiene funciones útiles para 27.
27. _leerMalla.py_ : lee malla de 'malla.msh' y guarda su información en un archivo legible por 22.
28. _malla.msh_ : generada por 29.
29. _prueba.geo_ : malla legible por GMSH.
