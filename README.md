# Establecimientos educativos en Argentina  

Este repositorio contiene trabajo hecho con datos del *Padrón Oficial de Establecimientos Educativos*    
del Ministerio de Educación. Se puede acceder a los datos originales [desde aquí](https://www.argentina.gob.ar/educacion/planeamiento/info-estadistica/padron-establecimientos).   

El resultado final es una shiny app que muestra los establecimientos educativos sobre una mapa. Se puede ver [aquí](https://canovasjm.shinyapps.io/escuelas-argentina/).    

## Contenido
Scripts:

* `app.R`: genera una [shiny app](https://canovasjm.shinyapps.io/escuelas-argentina/) y permite compartir el mapa generado con usuarios no técnicos.     
* `01_data_wrangling.R`: para importar y limpiar los datos originales.
* `02_geocoding.R`: a partir del domicilio de las escuelas, permite obtener sus coordenadas usando la API de Google de Maps. 
Necesitará una key válida.   
* `03_map.R`: permite localizar cada una de las ecuelas en el mapa de Argentina.   


Carpetas:   
* `shiny/`: carpeta donde se guardan algunos objetos que la shiny app usa.   
* `dataset/`: carpeta donde se guardan los datos originales y procesados.   


## Detalles   
Sobre el mapa se muestran los establecimientos educativos por sector ("Estatal" o "Privado"). Al hacer click sobre cada punto
la etiqueta muestra el nombre, la clave única del establecimiento (CUE), la localidad y la jurisdicción del establecimiento.   


## Links útiles   
https://www.argentina.gob.ar/educacion/planeamiento/info-estadistica/padron-establecimientos  
https://www.buenosaires.gob.ar/calidadyequidadeducativa/estadistica/establecimientos-y-edificios/registro-de-establecimientos
