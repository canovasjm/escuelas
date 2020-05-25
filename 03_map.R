# required libraries
library(tidyverse)
library(leaflet)
library(leaflet.extras)


# read geolocalized data --------------------------------------------------
d <- read_csv("dataset/escuelas_geolocalizado.csv")


# prepare data ------------------------------------------------------------
# filter data by sector
sector_estatal <- d %>% 
  filter(sector == "Estatal")

sector_privado <- d %>% 
  filter(sector == "Privado")


# create labels for map ---------------------------------------------------
# create label for sector estatal
label_estatal <- lapply(seq(nrow(sector_estatal)), function(i) {
  paste0('<br>', "Nombre: ", sector_estatal[i, "nombre"], '</br>',
         '<br>', "CUE: ", sector_estatal[i, "cue_anexo"], '</br>', 
         '<br>', "Localidad: ", sector_estatal[i, "localidad"],'</br>', 
         '<br>', "Jurisdiccion: ", sector_estatal[i, "jurisdiccion"], '</br>') 
})

saveRDS(label_estatal, file = "shiny/label_estatal.rds")

# create label for sector privado
label_privado <- lapply(seq(nrow(sector_privado)), function(i) {
  paste0('<br>', "Nombre: ", sector_privado[i, "nombre"], '</br>',
         '<br>', "CUE: ", sector_privado[i, "cue_anexo"], '</br>', 
         '<br>', "Localidad: ", sector_privado[i, "localidad"],'</br>', 
         '<br>', "Jurisdiccion: ", sector_privado[i, "jurisdiccion"], '</br>') 
})

saveRDS(label_privado, file = "shiny/label_privado.rds")


# maps in leaftlet --------------------------------------------------------
# define color palette
pal <- colorFactor(palette = c("darkred", "steelblue"), 
                   levels = c("Estatal", "Privado"))

# create base map
m <- d %>% 
  leaflet() %>% 
  addTiles(group = "OSM") %>% 
  addProviderTiles("Stamen.TonerLite", group = "Toner") %>% 
  addProviderTiles("CartoDB.DarkMatter", group = "Dark") %>% 
  addResetMapButton() %>% 
  setView(lat = -37.0147402, lng = -81.6698073, zoom = 4)


# add sector estatal and sector privado to base map 
m %>%
  addCircleMarkers(
    data = sector_estatal,
    radius = 1,
    color = ~ pal(sector),
    label = lapply(label_estatal, htmltools::HTML),
    group = "Estatal",
    clusterOptions = markerClusterOptions(disableClusteringAtZoom = 8)) %>% 
  addCircleMarkers(
    data = sector_privado,
    radius = 1,
    color = ~ pal(sector),
    label = lapply(label_privado, htmltools::HTML),
    group = "Privado",
    clusterOptions = markerClusterOptions(disableClusteringAtZoom = 8)) %>% 
  addLayersControl(baseGroups = c("Toner", "Dark", "OSM"),
                   overlayGroups = c("Estatal", "Privado"),
                   position = "topleft") %>% 
  addLegend(title = "Referencias", position = "bottomright", pal = pal, values = c("Estatal", "Privado"))
  




