library(here)
library(openair)
here()
bk <- read.csv(here('data/61aBangkok.csv'))
bk$date <- as.Date(bk$dtLong)

for (pollutant in c("NOX","O3","SO2","PM10","PM2.5")){
  png(filename=here(paste('/figures/',pollutant,"_windrose_season.png",sep='')))
  pollutionRose(bk, pollutant=pollutant, wd='Wind.dir', ws='Wind.speed',type='season')
  dev.off()
  png(filename= here(paste('/figures/',pollutant,"_windrose_all.png",sep='')))
  pollutionRose(bk, pollutant=pollutant, wd='Wind.dir', ws='Wind.speed')
  dev.off()
}
