rm(list=ls())
memory.size(max=F)
setwd("C:\\Users\\fevty\\Desktop\\NSS\\Capstone")
library(tidyverse)
library(ggplot2)
library(tidyr)
library(magrittr)
library(dplyr)
library(broom)
library(rmarkdown)
library(knitr)
# Install packes geojsonio and geojsonR 
library(geojsonio)
library(geojsonR)
library(leaflet)
library(spdplyr)



# additonal datases

state_geoj<-geojson_read("data/gz_2010_us_040_00_500k.json",what = 'sp')
head(state_geoj)

names(state_geoj)

head(state_geoj)

state_Median_charge=read_csv("data/state_median_charge.csv")
head(state_Median_charge)

colnames(state_Median_charge)<-c("STATE","Median_Hospital_Charge")


# merge data with matching columns named differently
state_geoj<-state_geoj%>%
  inner_join(state_Median_charge,by=c("NAME"="STATE"))


state_geoj

# Instruction how  plot choropleth in R
# https://rstudio.github.io/leaflet/choropleths.html 

m <- leaflet(state_geoj) %>%
  setView(-96, 37.8, 4) %>%
  addTiles("MapBox", options = providerTileOptions(
    GEO_ID="mapbox.light"))

saveRDS(m,'Median_Hospital_Charge.RDS')
# add polygons , it will add blue bordered polygons

m%>% addPolygons()


ggplot(data=state_Median_charge,aes(x=STATE,y=Median_Hospital_Charge)) +
  geom_point()

# bins puts ranges of your column (Median_Hospital_Charge in this case)
bins <- c(0, 5000, 10000,20000,30000,50000,70000,80000,100000,Inf)
pal <- colorBin("YlOrRd", domain = state_geoj$Median_Hospital_Charge, bins = bins)

m %>% addPolygons(
  fillColor = ~pal(Median_Hospital_Charge),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7)

# this will make the corropleh more interactive

m %>% addPolygons(
  fillColor = ~pal(Median_Hospital_Charge),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE))

# adding states on the choropleths

labels <- sprintf(
  "<strong>%s</strong><br/>%g charge in US $",
  state_geoj$NAME, state_geoj$Median_Hospital_Charge
) %>% lapply(htmltools::HTML)

m<-m %>% addPolygons(
  fillColor = ~pal(Median_Hospital_Charge),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = labels,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "15px",
    direction = "auto"))

# print map
m

# additional hints for coropleth lotting 
# # https://rstudio-pubs-static.s3.amazonaws.com/292287_894b2591571b4acdab51269e04f45125.html





