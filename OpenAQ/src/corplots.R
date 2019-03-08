require(ropenaq)
require("openair")
require("dplyr")
require(here)

library(hexbin)

load(here::here('bkk_data/BKKhaze2019.Rdata'))
all <- db[['05a']]
all <- subset(all, all$O3<400.)
all$date <- as.Date(all$dtLong)
all$dtLong <- NULL
# plot of correlations ####
corPlot(all,
        pollutant = c("NOX", "O3", "PM10", "PM2.5"),type = "season", cluster = FALSE,
        dendrogram = TRUE)

corPlot(all,
        pollutant = c("NOX", "O3", "NO", "NO2"),type = "season", cluster = FALSE,
        dendrogram = TRUE)

#png(paste(here('/figures/'),'O3_temp_cor_plot.png',sep=''))
scatterPlot(all, x="NOX", y="NMHC", z="O3",  smooth =TRUE, method='level', 
            linear = TRUE, col=openColours(n=8), ci=True, avg.time = "day",  
            pch=16, key = TRUE,  cex=1.5)
#dev.off()
scatterPlot(all, x="Temp", y="O3", z="NOX",  smooth =TRUE, method='level', 
            linear = TRUE, col=openColours(n=8), ci=True, avg.time = "day",  
            pch=16, key = TRUE,  cex=1.5)
#dev.off()
scatterPlot(all, x="Temp", y="O3",  smooth =TRUE, method='hexbin', 
            linear = TRUE, col=openColours(n=8), ci=TRUE, avg.time = "day", type='season', 
            pch=16, key = TRUE,  cex=1.5, main="site 05a")

