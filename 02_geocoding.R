# required libraries ------------------------------------------------------
library(tidyverse)
library(readxl)
library(ggmap)


# read df1 from data wrangling script -------------------------------------
df1 <- read_csv("dataset/escuelas_tidy.csv")

# copy data frame df1 and allocate space for new columns
df2 <- df1 %>% 
  add_column(lat = NA, lon = NA, domicilio_gmaps = NA)


# geocode data for San Juan -----------------------------------------------
register_google(key = "here goes your key to Google Maps API",
                account_type = "here your account type")


# loop through domicilio_completo to get the latitude and longitude of each
# address and add it to df2 data frame in new columns lat and lon nrow(df2)

# batch 1 - 3 h 30 m
for (i in 1:20000) {
  if (!is.na(df2$domicilio_completo[i])) {
    print(i)
    df_temp <- geocode(df2$domicilio_completo[i], output = "latlona", source = "google")
    df2$lon[i] <- as.numeric(df_temp[1])
    df2$lat[i] <- as.numeric(df_temp[2])
    df2$domicilio_gmaps[i] <- try(as.character(df_temp[3]), silent = TRUE)
  }
}


# batch 2 - 3 h 18 m
for (i in 20001:40000) {
  if (!is.na(df2$domicilio_completo[i])) {
    print(i)
    df_temp <- geocode(df2$domicilio_completo[i], output = "latlona", source = "google")
    df2$lon[i] <- as.numeric(df_temp[1])
    df2$lat[i] <- as.numeric(df_temp[2])
    df2$domicilio_gmaps[i] <- try(as.character(df_temp[3]), silent = TRUE)
  }
}


# batch 3 - 3 h 13 m
for (i in 40001:63390) {
  if (!is.na(df2$domicilio_completo[i])) {
    print(i)
    df_temp <- geocode(df2$domicilio_completo[i], output = "latlona", source = "google")
    df2$lon[i] <- as.numeric(df_temp[1])
    df2$lat[i] <- as.numeric(df_temp[2])
    df2$domicilio_gmaps[i] <- try(as.character(df_temp[3]), silent = TRUE)
  }
}




# check how many NAs are in domicilio_completo
sum(is.na(df2$domicilio_completo))
sum(is.na(df2$lat))
sum(is.na(df2$lon))
sum(is.na(df2$domicilio_gmaps))



# write a csv file containing df2 to the dataset folder -------------------
write_csv(df2, path = "dataset/escuelas_geolocalizado.csv")


