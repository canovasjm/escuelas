# required libraries ------------------------------------------------------
library(tidyverse)
library(shiny)
library(leaflet)
library(leaflet.extras)
library(htmltools)
library(emojifont)
library(shinybusy)

# read geolocalized data --------------------------------------------------
d <- readRDS("shiny/escuelas_geolocalizado.rds")

label_estatal <- readRDS("shiny/label_estatal.rds")
label_privado <- readRDS("shiny/label_privado.rds")

# prepare data ------------------------------------------------------------
# filter data by sector
sector_estatal <- d %>% 
  filter(sector == "Estatal")

sector_privado <- d %>% 
  filter(sector == "Privado")


# general objects ---------------------------------------------------------
# define color palette
# pal <- colorFactor(palette = viridis_pal()(2), 
#                    levels = c("Estatal", "Privado"))

pal <- colorFactor(palette = c("darkred", "steelblue"),
                   levels = c("Estatal", "Privado"))


# shiny app ---------------------------------------------------------------
ui <- fluidPage(
  tags$head(HTML('<link href="https://fonts.googleapis.com/css?family=Roboto+Mono" rel="stylesheet">')),
  tags$head(HTML('<style>* {font-size: 100%; font-family: Roboto Mono;}</style>')),
  h2("Establecimientos Educativos en Argentina", lapply(search_emoji("student"), emoji), emoji("argentina")),
  fluidRow(
    column(3,
           h4(emoji("school"), strong("¿Qué hay acá?")),
           HTML("<p> Un mapa con los establecimientos educativos (<span style= \"color: darkred;\">estatales</span> y 
                <span style= \"color: steelblue;\">privados</span>) de la República Argentina.</p>"),
           br(),
           h4(emoji("memo"), strong("Sobre los datos")),
           HTML("<p> Provienen del <i>Padrón Oficial de Establecimientos Educativos</i>, que es el nomenclador unificado
                de escuelas e incluye ofertas educativas de distintos programas, carreras y títulos; entre otras variables. <p>"),
           br(),
           h4(emoji("blue_book"), strong("Fuente")),
           HTML("<p> Ministerio de Educación: <a href=https://www.argentina.gob.ar/educacion/planeamiento/info-estadistica/padron-establecimientos > 
                https://www.argentina.gob.ar/educacion/planeamiento/info-estadistica/padron-establecimientos </a>
                Consultado: 2020-05-10 </p>"),
           br(),
           h4(emoji("nerd_face"), strong("Quiero saber más")),
           HTML("<p> <a href=https://canovasjm.netlify.app > 
                https://canovasjm.netlify.app </a> </p>")
    ),
    
    column(9,
           add_busy_spinner(spin = "fading-circle"),
           leafletOutput("map", height = "85vh")
    )
  )
)
  
server <- function(input, output, session) {
  output$map <- renderLeaflet({
    # create base map
    m <- d %>% 
      leaflet() %>% 
      addTiles(group = "OSM") %>% 
      addProviderTiles("Stamen.TonerLite", group = "Toner") %>% 
      addProviderTiles("CartoDB.DarkMatter", group = "Dark") %>% 
      addResetMapButton() %>% 
      setView(lat = -39.0147402, lng = -63.6698073, zoom = 4)
    
    # add sectors to base map 
    m %>%
      addCircleMarkers(
        data = sector_estatal,
        radius = 2,
        color = ~ pal(sector),
        label = lapply(label_estatal, htmltools::HTML),
        group = "Estatal",
        clusterOptions = markerClusterOptions(disableClusteringAtZoom = 8)) %>% 
      addCircleMarkers(
        data = sector_privado,
        radius = 2,
        color = ~ pal(sector),
        label = lapply(label_privado, htmltools::HTML),
        group = "Privado",
        clusterOptions = markerClusterOptions(disableClusteringAtZoom = 8)) %>% 
      addLayersControl(baseGroups = c("Toner", "Dark", "OSM"),
                       overlayGroups = c("Estatal", "Privado"),
                       position = "topleft",
                       options = layersControlOptions(collapsed = FALSE)) %>% 
      addLegend(title = "Referencias", position = "bottomright" , pal = pal , values = c("Estatal", "Privado")) 
    })
}

shinyApp(ui, server)