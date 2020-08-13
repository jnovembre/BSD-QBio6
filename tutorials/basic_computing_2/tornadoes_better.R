# This short script produces a plot showing the number of tornado
# events recorded by the NOAA's National Weather Service on each day
# of 2011.

# Load the storm event data downloaded from
# www.ncdc.noaa.gov/stormevents/ftp.jsp
library(readr)
storms <- read_csv("storms2011.csv.gz", guess_max = 5000)
class(storms) <- "data.frame"

# Add columns for date and "day of year" (number from 1 to 365).
storms <- transform(storms, date = as.Date(paste(2011, BEGIN_YEARMONTH - 201100,
                                                 BEGIN_DAY, sep = "-")))
storms <- transform(storms, dayofyear = as.numeric(format(date, "%j")))

# Focus on storm events classified as tornadoes.
tornadoes <- subset(storms, EVENT_TYPE == "Tornado")

# Returns a vector of length 365 giving the number of storm events per day.
count_events <- function (dat) {
  x <- as.numeric(table(cut(dat$dayofyear, breaks)))
  return(x)
}

# Plots the number of events per day.
plot_events <- function (dat, title) {
  x <- count_events(dat)
  plot(breaks[-1], x, type = "l", xaxt = "n", main = title)
  axis(1, cex.axis = 0.7, at = first_days, labels = months)
}

# Plot the total number of tornado events per day.
breaks     <- seq(0, 365, 3)
first_days <- c(1,32,60,91,121,152,182,213,244,274,305,335)
months     <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug",
                "Sep","Oct","Nov","Dec")
layout(matrix(1:2))
plot_events(tornadoes, "Tornadoes in 2011")

# Plot more severe tornadoes only.
plot_events(subset(tornadoes, TOR_F_SCALE == "EF2"), "Severe tornadoes in 2011")
