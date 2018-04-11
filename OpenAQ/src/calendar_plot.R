library(ropenaq)
library("openair")
library("dplyr")
library(here)
thai.locs <- aq_locations(country="TH")
cm.locs <- aq_cities(country="TH")

cm.pcm.pm10 <- aq_measurements(country="TH", 
                               city="Chiang+Mai", 
                               location = "Chang+Phueak%2C+Mueang",
                               parameter="pm10")

cm.pcm.pm10$dateLocal <- as.POSIXct(cm.pcm.no2$dateLocal, format = "%Y-%m-%d %H:%M:%S")
cm.pcm.pm10 <- data.frame(Index=cm.pcm.pm10['dateLocal'], cm.pcm.pm10$value)
names(cm.pcm.pm10) <- c('date', 'pm10')

# cm.pcm.no2 <- aq_measurements(country="TH", city="Chiang+Mai", location = "Chang+Phueak%2C+Mueang", parameter="no2")
cm.pcm.no2$dateLocal <- as.POSIXct(cm.pcm.no2$dateLocal, format = "%Y-%m-%d %H:%M:%S")


calendarPlot(mydata = cm.pcm.pm10, pollutant ='pm10', main = 'PM10 Chang Phueak Mueang', )#
