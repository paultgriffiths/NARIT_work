library(here)
library(ggplot2)

lndn.data <-
  read.csv(here("ldn_data/london_aq.csv"),
           header = TRUE,
           sep = ",")
lndn.data$Month <- as.Date(lndn.data$Month, format = "%d-%m-%Y")

BKK.data <- load(here("bkk_data/BKKhaze.Rdata"))

a <-
  ggplot(
    data = lndn.data,
    aes(
      x = lndn.data$Month,
      y = lndn.data$London.Mean.Roadside.PM2.5.Particulate..ug.m3.
    )
  ) +
  geom_line(color = "black", size = 1.2)

a <-
  a + geom_line(data = pm25_mo, aes(x = as.Date(pm25_mo$date), y = pm25_mo$`61a`)) +
  geom_line(color = "red", size = 1.3)

a <-
  a + geom_hline(yintercept = 25,
                 color = "dark gray",
                 size = 1.1) + geom_hline(
                   yintercept = 10,
                   color = "dark gray",
                   size = 1.1,
                   show.legend = TRUE
                 )

a <-
  a + xlim(as.Date("2008-01-01", "%Y-%m-%d"), as.Date("2019-01-02")) +
  ylim(0,
       60) +
  xlab("Year") + ylab("PM 2.5 concentration in microgram per m3")

png(filename = here::here("figures/London_vs_BKK_PM2.5_2008_2019.png"), width = 640, height = 480, units="px", bg="white")
print(a)
dev.off()
