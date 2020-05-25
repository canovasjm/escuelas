# Establecimientos educativos en Argentina  

Este repositorio contiene trabajo hecho con datos del *Padrón Oficial de Establecimientos Educativos*    
del Ministerio de Educación. Se puede acceder a los datos originales [desde aquí](https://www.argentina.gob.ar/educacion/planeamiento/info-estadistica/padron-establecimientos).   

El resultado final es una shiny app que muestra los establecimientos educativos sobre un mapa. Se puede ver [aquí](https://canovasjm.shinyapps.io/escuelas-argentina/).    

## Contenido
Scripts:

* `app.R`: genera una [shiny app](https://canovasjm.shinyapps.io/escuelas-argentina/) y permite compartir el mapa generado.  
* `01_data_wrangling.R`: para importar y limpiar los datos originales.
* `02_geocoding.R`: a partir del domicilio de los establecimientos educativos, permite obtener sus coordenadas usando la API de Google de Maps. Necesitará una key válida.   
* `03_map.R`: permite localizar cada uno de los establecimientos educativos en el mapa de Argentina.   


Carpetas:   
* `correcciones/`: carpeta donde se guarda el archivo correcciones.csv que se usa para editar las coordenadas erróneas.
* `dataset/`: carpeta donde se guardan los datos originales y procesados.   
* `shiny/`: carpeta donde se guardan algunos objetos que la shiny app usa.


## Detalles   
Sobre el mapa se muestran los establecimientos educativos por sector ("Estatal" o "Privado"). Al hacer click sobre cada punto
la etiqueta muestra el nombre, la clave única del establecimiento (CUE), la localidad y la jurisdicción del establecimiento.   

Para más detalles ver el [blog post](https://canovasjm.netlify.app/2020/05/25/establecimientos-educativos-en-argentina/).

## Links útiles   
https://www.argentina.gob.ar/educacion/planeamiento/info-estadistica/padron-establecimientos  
https://www.buenosaires.gob.ar/calidadyequidadeducativa/estadistica/establecimientos-y-edificios/registro-de-establecimientos
