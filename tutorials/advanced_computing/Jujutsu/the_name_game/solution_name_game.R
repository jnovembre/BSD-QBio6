rm(list = ls()) # clear workspace
library(tidyverse) # load tidyverse

# 1. Download and organize the data
# Strategy: 
# * use a temporary file for the zip.
# * use a for loop to go through the files, and unz to extract from zip file
#   again use a connection rather than creating physical file
# * compute proportions within year to speed up calculation
#   i.e., working with a single year and repeating multiple times
#   is much faster that doing it only once on the whole data
# * append with bind_rows (rbind is inefficient)

# check if the parsed file exists to avoid downloading it again
if (file.exists("names.csv") == FALSE){
  yrstart <- 1880 # start year
  yrend <- 2018 # end year

  all_names <- tibble() # store the info
  
  # download using temp file; use unlink() to close
  temp <- tempfile()
  download.file("https://www.ssa.gov/oact/babynames/names.zip",temp)
  
  for (yr in yrstart:yrend){
    # extract the file for a given year and read it
    print(yr)
    con <- unz(temp, paste0("yob", yr, ".txt"))
    dt <- read.table(con, 
                     header = FALSE, sep = ",", 
                     stringsAsFactors = FALSE) # avoid treating names as factors
                                               # because it takes a lot longer to bind them
    colnames(dt) <- c("name", "sex", "num")
    # now compute proportions
    dt <- dt %>% # a) count totals by sex
      group_by(sex) %>% 
      mutate(total = sum(num)) %>% 
      ungroup() %>% # b) compute proportion
      mutate(prop = num / total) %>% # c) add a column for the year
      add_column(year = yr) %>% 
      select(year, name, sex, prop) # select only useful columns
    all_names <- bind_rows(all_names, dt)
  }
  unlink(temp)
  write_csv(all_names, path = "names.csv")
} else {
  all_names <- read_csv("names.csv")
}

# 2. Write a function to plot frequencies in time

plot_name_in_time <- function(data = all_names, 
                              my_name = "Hermione", 
                              highlight = 2001){
  pl <- data %>% filter(name == my_name) %>% 
    ggplot() + 
    aes(x = year, y = prop, fill = sex) + 
    geom_col() + 
    geom_vline(xintercept = highlight, linetype = 2) + 
    facet_wrap(~sex, scales = "free_y") # separate panels by sex
  return(pl)
}

# 4. Names switching sex 

# Strategy:
# To keep this simple, compute the correlation between
# proportion M and proportion F for a name
# across all years
# Names that have switched should show negative correlation
# To avoid clutter due to very rare names, filter by frequency

# a) store proportion for M and F
dd <- all_names %>% spread(sex, prop, fill = 0)
threshold <- 0.0001
# b) only consider names for which the max frequency is > threshold for both sexes
gender_neutral_names <- dd %>% 
  group_by(name) %>% 
  summarise(`M` = max(`M`), `F` = max(`F`)) %>% 
  ungroup() %>% 
  filter(`M` > threshold, `F` > threshold) %>% 
  select(name) %>% distinct()
correlations <- dd %>% 
  inner_join(gender_neutral_names) %>% 
  group_by(name) %>% 
  summarise(cor = cor(`F`, `M`)) %>% arrange(cor)

# nicer plot for this type of data
plot_gender_prop <- function(data = all_names, 
                              my_name = "Hermione"){
  pl <- data %>% filter(name == my_name) %>% 
    ggplot() + 
    aes(x = year, y = prop, fill = sex) + 
    geom_col(position = "fill") 
  return(pl)
}

# this looks pretty
plot_gender_prop(all_names, "Lindsey")

