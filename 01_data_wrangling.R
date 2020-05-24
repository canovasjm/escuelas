# required libraries ------------------------------------------------------
library(tidyverse)
library(readxl)
library(janitor)


# import data -------------------------------------------------------------
df <- read_xls(path = "dataset/mae_actualizado_2019-12-02_envios.xls", 
               range = "A12:T63402")

df <- clean_names(df)


# explore data ------------------------------------------------------------
head(df)
tail(df)
str(df)


# tidy data ---------------------------------------------------------------
# remove an email address in row 2
df[2, "domicilio"] <- "COLON Y MITRE 498"

# create a complete address
df1 <- df %>% 
  mutate_if(is.character, str_squish) %>% 
  mutate(domicilio_completo = ifelse(is.na(domicilio), NA, paste(domicilio, cp, localidad, departamento, jurisdiccion, sep = ", ")))

# check NAs for domicilio are also in domicilio_completo
sum(is.na(df$domicilio))
sum(is.na(df1$domicilio_completo))
identical(is.na(df$domicilio), is.na(df1$domicilio_completo))

# replace X by the column name in variables starting by ed_*
column_names <- colnames(df1)
for (i in 14:20){
  df1[i][df1[i] == "X"] <- column_names[i]
}



# write df1 as csv --------------------------------------------------------
write_csv(df1, path = "dataset/escuelas_tidy.csv")

