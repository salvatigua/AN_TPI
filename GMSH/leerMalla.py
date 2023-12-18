from leer_GMSH import xnod_from_msh, LaG_from_msh, plot_msh, guardar_tablas

malla = 'malla.msh'

# Matriz de coordenadas nodales
xnod = xnod_from_msh(malla, dim=2)

# Se imprimen los primeros 10 nodos
for i in range(10):
    x, y = xnod[i]
    print(f'Nodo {i+1:2.0f}: x = {x:.4f}, y = {y:.4f}')

# Matriz de interconexión nodal
LaG = LaG_from_msh(malla)
nef = LaG.shape[0]

# Se imprimen los primeros 5 elementos y los 5 últimos:
print()
for e in list(range(5)) + list(range(nef-5, nef)):
    print(f'Elemento {e+1:3.0f}: Superficie = {LaG[e, 0]+1},   '
          f'Nodos = {LaG[e, 1:]+1}')

# Se grafica la malla:
plot_msh(malla, '2D', mostrar_nodos=True, mostrar_num_nodo=False, 
         mostrar_num_elem=True)

# Llamada a la función para guardar los datos en un archivo llamado "datos.txt"
guardar_tablas('datos.txt', xnod, LaG)