rm(list = ls())
library(tidyverse)

######################################
# 1
######################################

dd <- read_csv("All_UofC_Bio_2011-20.csv")

# rename cols for easy access
dd <- dd %>% rename(
  au = Authors,
  au_ids = `Author(s) ID`,
  year = Year,
  journal = `Source title`,
  cits = `Cited by`,
  article = `Document Type`,
  oa = `Access Type`
)

# remove uncited docs (probably editorials, errata, etc)
dd <- dd %>% filter(cits > 0)

######################################
# 2
######################################

# show that the distribution of log citations per year is about normal
# esp for older years

dd %>% ggplot() + 
  aes(x = log(cits),
      fill = year) + 
  geom_histogram() + 
  facet_wrap(~year, scales = "free")

# simple model: only year matters
# for ease of interpretation, remove year from 2010; the coefficient tells us the growth per year
model1 <- lm(log(cits) ~ I(2010 - year), data = dd)
summary(model1)

######################################
# 3
######################################

# try adding number of authors
dd <- dd %>% mutate(nau = str_count(au_ids, ";") + 1)
dd <- dd %>% mutate(multi = nau > 12)
model3 <- lm(log(cits) ~ I(2010 - year) + multi, data = dd)
summary(model3)

# add info on article/review
model4 <- lm(log(cits) ~ I(2010 - year) + multi + article, data = dd)
summary(model4)

######################################
# 4
######################################

# add info on journal
# first transform journal names into factors
dd <- dd %>% mutate(journal = factor(journal)) 
# use PLoS ONE as the baseline
dd <- dd %>% mutate(journal = relevel(journal, ref = "PLoS ONE"))
model5 <- lm(log(cits) ~ I(2010 - year) + multi + article + journal, data = dd)
head(model5$coefficients)

mat_coeff <- as.matrix(summary(model5)$coefficients)[-(1:4),] # do not plot multi, article, year, intercept
jrn_effects <- as_tibble(mat_coeff) %>%  # make coefficients into tibble
  add_column(journal = rownames(mat_coeff)) %>%  # use the row name as journal name (note that each starts with journal[NAME])
  filter(`Pr(>|t|)` < 10^-6) %>% # only small p-values
  mutate(journal = str_replace_all(journal, "^journal", "")) %>% # remove "journal" at beginning of line
  mutate(journal = ifelse(journal == "Proceedings of the National Academy of Sciences of the United States of America", "PNAS", journal))
# last line---change to PNAS for better graph

jrn_plot <- ggplot(jrn_effects) + 
  aes(x = Estimate, 
      y = reorder(journal, Estimate), # a good way to reorder labels
      fill = sign(Estimate)) + 
  geom_col() + 
  scale_fill_gradient2() + 
  theme(legend.position = "none") +
  ylab("")

show(jrn_plot)

######################################
# 5
######################################

# find journals that have published both open access and paywalled articles in a given year
jr_year_oa_test <- dd %>% 
  mutate(oa = ifelse(is.na(oa), "pay", "open")) %>% 
  group_by(journal, year, oa) %>% 
  tally() %>% 
  spread(oa, n, fill = 0) %>% 
  ungroup() %>% 
  filter(pay > 0, open > 0) %>% 
  arrange(desc(open), desc(pay))

# now build data set for testing
testset <- dd %>% 
  inner_join(jr_year_oa_test)

# finally, test whether OA has positive effect
model_oa <- lm(log(cits) ~ year:journal:multi:article + open, data = testset)
# there are too many coeffs to plot---extract the second one
head(summary(model_oa)$coefficients, 2)