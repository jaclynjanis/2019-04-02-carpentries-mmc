gapminder <- readr::read_csv(here("data/gapminder/raw/gapminder_data.csv"))

head(gapminder)
mean(gapminder$pop)
mean(gapminder$gdpPercap[gapminder$continent == "Africa"])

library(tidyverse)
year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

year_country_gdp_eur <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year, country, gdpPercap)
  
head(year_country_gdp_eur)

#Challenge 1
afr_life_yr_country <- gapminder %>% 
  filter(continent == "Africa") %>% 
  select(lifeExp, year, country)


grp_continent <- gapminder %>% 
  group_by(continent)
head(grp_continent)

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_val = mean(gdpPercap))

#Challenge 2

gapminder %>% 
  group_by(country) %>% 
  summarize(mean_life = mean(lifeExp))
gapminder %>% 
  group_by(country) %>% 
  summarize(mean_life = mean(lifeExp)) %>% 
  filter(mean_life == min(mean_life) | mean_life == max(mean_life))

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_val = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap))

gapminder %>% 
  filter(continent == "Africa") %>% 
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  facet_wrap(~country)
