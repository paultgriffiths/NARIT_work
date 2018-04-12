library(ropenaq)
library("openair")
library("dplyr")
library(here)
thai.locs <- aq_locations(country="TH", city="Chiang+Mai", location = "Chang+Phueak%2C+Mueang")


if (file.exists(here('OpenAQ/mungedData/2016_2018_PM10_NO2_CO_CM_CPM.Rda'))) {
  print('data file exists, carrying on')
} else{
  # OPENAQ will only return data in a single column if you ask for one measurement
  # otherwise measurements are separated by rows
  # so load into separate dataframes and then do a merge
  
  # get PM10 data ####
  if (thai.locs$pm10 == TRUE) {
    cm.pcm.pm10 <- aq_measurements(
      country = "TH",
      city = "Chiang+Mai",
      location = "Chang+Phueak%2C+Mueang",
      parameter = "pm10",
      date_from = '2016-01-01',
      date_to   = '2018-01-01'
    )
    cm.pcm.pm10$dateLocal <-
      as.POSIXct(cm.pcm.pm10$dateLocal, format = "%Y-%m-%d %H:%M:%S")
    cm.pcm.pm10 <-
      data.frame(Index = cm.pcm.pm10['dateLocal'], cm.pcm.pm10$value)
    names(cm.pcm.pm10) <- c('date', 'pm10')
  }
  
  # get CO, is problematic and may give an "OH NO" error ! ####
  if (thai.locs$co == TRUE) {
    cm.pcm.co <- aq_measurements(
      country = "TH",
      city = "Chiang+Mai",
      location = "Chang+Phueak%2C+Mueang",
      parameter = "co"
    )#
    
    
    cm.pcm.co$dateLocal <-
      as.POSIXct(cm.pcm.co$dateLocal, format = "%Y-%m-%d %H:%M:%S")
    cm.pcm.co <-
      data.frame(Index = cm.pcm.co['dateLocal'], cm.pcm.no2$value)
    names(cm.pcm.co) <- c('date', 'co')
  }
  
  # get NO2 data ####
  if (thai.locs$no2 == TRUE) {
    cm.pcm.no2 <- aq_measurements(
      country = "TH",
      city = "Chiang+Mai",
      location = "Chang+Phueak%2C+Mueang",
      parameter = "no2",
      date_from = '2016-01-01'
    )
    
    cm.pcm.no2$dateLocal <-
      as.POSIXct(cm.pcm.no2$dateLocal, format = "%Y-%m-%d %H:%M:%S")
    cm.pcm.no2 <-
      data.frame(Index = cm.pcm.no2['dateLocal'], cm.pcm.no2$value)
    names(cm.pcm.no2) <- c('date', 'no2')
  }
  # get O3 data ####
  if (thai.locs$o3 == TRUE) {
    cm.pcm.o3 <- aq_measurements(
      country = "TH",
      city = "Chiang+Mai",
      location = "Chang+Phueak%2C+Mueang",
      parameter = "o3",
      date_from = '2016-01-01'
    )
    
    cm.pcm.o3$dateLocal <-
      as.POSIXct(cm.pcm.o3$dateLocal, format = "%Y-%m-%d %H:%M:%S")
    cm.pcm.o3 <-
      data.frame(Index = cm.pcm.o3['dateLocal'], cm.pcm.o3$value)
    names(cm.pcm.o3) <- c('date', 'o3')
  }
  
  # join data into data frames ####
  all.tmp <- merge(cm.pcm.pm10, cm.pcm.no2, by = "date")
  all <- merge(all.tmp, cm.pcm.o3, by = "date")
  save(all, file = "2016_2018_PM10_NO2_CO_CM_CPM.Rda")
}
# load data ####
load("2016_2018_PM10_NO2_CO_CM_CPM.Rda")

# plot data ####
# PM10 ####
# calendar plot ####
png(paste(here('OpenAQ/figures/'),'PM10_calendar_plot.png',sep=''))
calendarPlot(mydata = cm.pcm.pm10, pollutant ='pm10', main = 'PM10 Chang Phueak Mueang')#
dev.off()

# no2 ####
# calendar plot ####
png(paste(here('OpenAQ','/figures/'),'NO2_calendar_plot.png',sep=''))
calendarPlot(mydata = cm.pcm.no2, pollutant ='no2', main = 'NO2 Chang Phueak Mueang / ppm')#
dev.off()
 
# calcPercentile(cm.pcm.no2, 
#                pollutant = "no2", 
#                avg.time = "week", 
#                percentile = 20, 
#                data.thresh = 0, 
#                start = NA)

# plot of correlations ####
corPlot(all, 
        pollutant = c("no2", "o3", "pm10"),type = "season", cluster = FALSE,
        dendrogram = TRUE)

# scatter plot with trendline ####
library(hexbin)
png(paste(here('OpenAQ','/figures/'),'O3_PM10_cor_plot.png',sep=''))
scatterPlot(all, x='pm10', y='o3',smooth =FALSE, type = 'season', method='hexbin', 
            linear = TRUE, avg.time = "day", pch=16, key = TRUE,  cex=1.5, 
            xlab = "PM10 / micro-g m-3",
            ylab = "O3 / ppbv",
            main='Chiang Mai O3 and PM10 correlated?')
dev.off()
