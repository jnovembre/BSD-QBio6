rm(list = ls()) # clean workspace
library(tidyverse) # load tidyverse
library(readxl) # library to read excel

######################################
# 1
######################################

# function for downloading/massaging data for a single year
read_excel_from_url <- function(url, 
                                year, 
                                skip = 1, 
                                read_lines = NA){
  temp <- tempfile() # use temporary file
  download.file(url,temp)  
  if(!is.na(read_lines)) {
    # skip is to remove lines at the top; n_max is the number 
    # of lines to read
    dd <- read_xlsx(temp, skip = skip, n_max = read_lines)
  } else {
    dd <- read_xlsx(temp, skip = skip)
  }
  unlink(temp)
  # change col names for easier typing
  colnames(dd) <- c("field", "total", 
                    "male", "female", "perc_female") 
  dd <- dd %>% 
    select(field, total) %>% # take only field, total
    filter(!is.na(field)) %>% # remove empty lines
    add_column(year = year) # keep track of year
  return(dd)
}

# info on table location
tt <- read_csv("urls_and_skip_NSF_SED.csv")

# option 1: good old R
tb_sed <- tibble()
for (i in 1:nrow(tt)){
  tb_sed <- bind_rows(tb_sed, read_excel_from_url(tt$url[i],
                                            tt$year[i],
                                            tt$skip[i],
                                            tt$read[i]))
}

# option 2, using functional programming
tb_sed2 <- bind_rows(pmap(tt, read_excel_from_url))

######################################
# 2
######################################

# be careful: some names have changed: For example
# Neurosciences, neurobiology
# Neurosciences and neurobiology
# to select certain fields and normalize the field name, 
# join with lookup table
tb_sed <- tb_sed %>% 
  inner_join(read_csv("lookup_fields_filter.csv"))

######################################
# 3
######################################

# to plot, use something like this
plot_PhD_in_time <- function(my_tibble){
  pl <- my_tibble %>% 
    ggplot() +
    aes(x = year, y = total, colour = name_to_use) + 
    geom_point() + 
    geom_line() + 
    facet_wrap(~name_to_use, scales = "free") + 
    theme(legend.position = "none")
  return(pl)
}

plot_PhD_in_time(tb_sed)

######################################
# 4
######################################

# max change

# compute max and min per field
tb_sed %>% 
  group_by(name_to_use) %>% 
  summarize(max_n = max(total), 
            min_n = min(total),
            ratio = max_n / min_n) %>% # note you can use max_n/min_n already!
  ungroup() %>% 
  arrange(ratio)

######################################
# 5
######################################

# compute the correlation between any
# two fields using cor

cdt <- tb_sed %>%
  select(name_to_use, total, year) %>%
  spread(name_to_use, total) %>% # now each field is a column
  select(-year) %>%
  cor()

# cor is now a matrix!!

# transform back to tibble for plotting
cdt <- cdt %>%
  as_tibble() %>%
  add_column(field1 = rownames(cdt)) %>%
  gather(field, correlation, -field1)

# plot using geom_tile

ggplot(cdt) +
  aes(x = field, y = field1, fill = correlation) +
  geom_tile() +
  scale_fill_gradient2() + # what follows is to rotate labs
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 1)) + # and clean a bit
  xlab("") + ylab("") + theme(legend.position = "bottom")

######################################
# 6
######################################

# as 5, but save the matrix to compute eigenvectors
cdt <- tb_sed %>%
  select(name_to_use, total, year) %>%
  spread(name_to_use, total) %>%
  select(-year) %>%
  cor()

# use the leading eigenvector to order

M <- as.matrix(cdt)
my_order <- colnames(M)[order(eigen(M)$vectors[,1])]

# build the tibble

cdt <- cdt %>%
  as_tibble() %>%
  add_column(field1 = rownames(cdt)) %>%
  gather(field, correlation, -field1)

# use factors to force the order in the plot

cdt <- cdt %>% mutate(field = factor(field, levels = my_order),
                      field1 = factor(field1, levels = my_order))

# plot using geom_tile

ggplot(cdt) +
  aes(x = field, y = field1, fill = correlation) +
  geom_tile() +
  scale_fill_gradient2() + # what follows is to rotate labs
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 1)) + # and clean a bit
  xlab("") + ylab("") + theme(legend.position = "bottom")

