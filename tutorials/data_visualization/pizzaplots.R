# This is my analysis of the data on inspections of pizza restaurants
# in Chicago.

# SET UP ENVIRONMENT
# ------------------
# These are the R packages I used to load the data and create the plots.
library(readr)
library(ggplot2)
library(cowplot)

# SCRIPT PARAMETERS
# -----------------
# This is the compressed CSV file containing the Food Inspection data
# that I downloaded from data.cityofchicago.org.
data.file <- "Food_Inspections.csv.gz"

# LOAD DATA
# ---------
# I use read_csv from the readr package instead of the standard
# function, read.csv, because read_csv is *much* faster. However, I
# prefer working with data frames rather than "tibbles", so I set the
# class to "data.frame".
#
# The data set should be a table with 17 columns and 172,041 rows.
dat        <- read_csv(data.file)
class(dat) <- "data.frame"

# PREPARE DATA
# ------------
# First, I remove the columns I don't need, then I fix the column
# names to simplify the code below.
#
# Note that "DBA" means "doing business as".
cols     <- c(2:5,7,8,11,13,15,16)
colnames <- c("dba","aka","license","type","address","city","date",
              "results","latitude","longitude")
dat        <- dat[cols]
names(dat) <- colnames

# I only need the years, so I create a new column containing the year
# of the inspection only.
get.third.entry <- function(x) { return(x[3]) }
out      <- strsplit(dat$date,"/")
dat$year <- sapply(out,get.third.entry)
dat$year <- as.numeric(dat$year)

# I'm only interested in inspections in Chicago restaurants that have
# a latitude & longitude. I also throw away entries with a missing
# license, since that is needed for my analysis.
#
# After this step, I obtained 113,585 entries satisfying these criteria.
dat <- subset(dat,
              type == "Restaurant" &
              city == "CHICAGO" &
              !is.na(latitude) &
              !is.na(longitude) &
              !is.na(license))

# To obtain data on pizza restaurants, I only take entries in which
# the restaurant name contains "pizza" (as in "pizza" or
# "pizzeria").
#
# I obtained data on 6,163 inspections of pizza restaurants.
pdat <- subset(dat,
               grepl("pizz",dba,ignore.case = TRUE) |
               grepl("pizz",aka,ignore.case = TRUE))

# I think that the "license" column can be used to uniquely identify a
# restaurant. And I would like an entry from the first year that the
# restaurant was inspected, so I first sort the restaurant data by
# year of inspection.
#
# After taking these steps, the pdat table should contain 945
# entries---most or all of these should (hopefully) be pizza
# restaurants.
rows <- order(pdat$year)
pdat <- pdat[rows,]
rows <- which(!duplicated(pdat$license))
pdat <- pdat[rows,]

# PLOT NUMBER OF NEW PIZZA RESTAURANTS PER YEAR
# ---------------------------------------------
# Here I use the first inspection date as a proxy for a restaurant
# opening. I remove the counts for 2010 since we don't have any data
# prior to 2010, and I remove the counts for 2018 since we don't have
# all the data for 2018 yet.
counts <- table(pdat$year)
counts <- counts[2:8]
counts <- as.data.frame(counts)
names(counts) <- c("year","count")

# Create a bar chart.
aes1 <- aes(x = year,y = count)
p1   <- ggplot(counts,aes1)
out  <- geom_col(fill = "darkblue",width = 0.5)
p1   <- ggplot_add(out,p1)
out  <- labs(y = "number of locations")
p1   <- ggplot_add(out,p1)

# PLOT PIZZA RESTAURANTS
# ----------------------
# Next, I create a map of pizza restaurants in Chicago. I highlight
# more recent pizza restaurants in warmer (red) colours.
aes2 <- aes(x = longitude,y = latitude,color = year)
p2   <- ggplot(pdat,aes2)
out  <- geom_point(shape = 20)
p2   <- ggplot_add(out,p2)
out  <- scale_color_gradient2(low = "skyblue",mid = "white",
                              high = "orangered",midpoint = 2014)
p2   <- ggplot_add(out,p2)

# COMBINE THE PLOTS
# -----------------
p1  <- ggplot_add(theme_cowplot(font_size = 10),p1)
p2  <- ggplot_add(theme_cowplot(font_size = 10),p2)
p12 <- plot_grid(p1,p2,labels = c("A","B"))
