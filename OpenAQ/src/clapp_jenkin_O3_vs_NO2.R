# R script for Clapp-Jenkin type analysis
Sys.setenv(TZ = "Asia/Bangkok")
library(tidyverse)
library(here)
library(openair)

load(here::here('bkk_data/BKKhaze2019.Rdata'))

#subd <- selectByDate(df2, day = "weekday")
#daily <- timeAverage(subd, avg.time = "night")

# Bodindecha is 61a
y <- db[['61a']]$O3
x <- db[['61a']]$NOX
#fit<- lm(y ~  x)

#fit.int <- fit$coeff[1]
#fit.grad <- fit$coeff[2]
png(filename = here::here("figures/Clapp_Jenkin_O3_vs_NO2.png"), width = 640, height = 480, units="px", bg="white")
plot(log10(x),y, cex=0.1,
     main = 'Site 61a - Bodinecha, ambient station',
     xlab = "NOX",
     ylab="OX = O3")
#text(300, 100, paste("y = ", format(fit.grad, digits=3), "x +", format(fit.int, digits=3), sep=''))
#abline(fit, col='red', lwd=3)
dev.off()

