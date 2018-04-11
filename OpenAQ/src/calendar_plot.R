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

cm.pcm.pm10$dateLocal <- as.POSIXct(cm.pcm.pm10$dateLocal, format = "%Y-%m-%d %H:%M:%S")
cm.pcm.pm10 <- data.frame(Index=cm.pcm.pm10['dateLocal'], cm.pcm.pm10$value)
names(cm.pcm.pm10) <- c('date', 'pm10')

png(paste(here('OpenAQ/figures/'),'PM10_calendar_plot.png',sep=''))
calendarPlot(mydata = cm.pcm.pm10, pollutant ='pm10', main = 'PM10 Chang Phueak Mueang')#
dev.off()

cm.pcm.no2 <- aq_measurements(country="TH", 
                              city="Chiang+Mai", 
                              location = "Chang+Phueak%2C+Mueang", 
                              parameter="no2")

cm.pcm.no2$dateLocal <- as.POSIXct(cm.pcm.no2$dateLocal, format = "%Y-%m-%d %H:%M:%S")
cm.pcm.no2 <- data.frame(Index=cm.pcm.no2['dateLocal'], cm.pcm.no2$value)
names(cm.pcm.no2) <- c('date', 'no2')
png(paste(here('OpenAQ','/figures/'),'NO2_calendar_plot.png',sep=''))
calendarPlot(mydata = cm.pcm.no2, pollutant ='no2', main = 'NO2 Chang Phueak Mueang / ppm')#
dev.off()

