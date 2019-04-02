# Principals of good software
# 1. Use comments.
# 2. Validate your data.
# 3. Don't repeat yourself.
# 4. Have a consistent style.
library(here)
library(tidyverse)
library(assertthat)

### Read in data and calculate means ---------------
# read in gapminder data
gapminder <- readr::read_csv(here("data/gapminder/raw/gapminder_data.csv"))

mean(gapminder$gdpPercap[gapminder$continent == "Africa"])
mean(gapminder$gdpPercap[gapminder$continent == "Americas"])

year_country_gdp <- select(gapminder, year, country, gdpPercap);
  
assert_that(ncol(year_country_gdp) == 3)
assert_that(is.integer(year_country_gdp$year))
assert_that(!is.na(year_country_gdp$mean_val))

gapminder %>%
  group_by(continent) %>%
  summarize(mean_val = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap))

### Plot the results -----------
gapminder %>%
  filter(continent == "Africa") %>%
  ggplot( aes(x = year, y = lifeExp, color = continent)) +
    geom_line() +
    facet_wrap( ~ country)





