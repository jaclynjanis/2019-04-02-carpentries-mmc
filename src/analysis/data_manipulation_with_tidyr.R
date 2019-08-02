#Data manipulation with tidyr

#Create gap_wide
gap_wide <- gapminder %>%
  gather(key = 'key', value = 'value', c('pop', 'lifeExp', 'gdpPercap')) %>%
  mutate(year_var = paste(key, year, sep = '_')) %>%
  select(country, continent, year_var, value) %>%
  spread(key = 'year_var', value = 'value')

library(skimr)
#This is much better than str()
skim(gapminder)

head(gap_wide)

head(gapminder)

#Going to long format in a couple steps...

gap_long <- gap_wide %>%
  gather(key = "obstype_year", 
         value = "obs_values", 
         starts_with('pop'), starts_with('lifeExp'), starts_with('gdpPercap'))
head(gap_long)

skim(gap_long)

#separate() at the _

gap_long <- gap_long %>% separate(obstype_year,into=c('obs_type','year'),sep="_")

head(gap_long)

#Convert year to numeric (can do mutate(year = as.numeric(year)))
gap_long$year <- as.integer(gap_long$year)

head(gap_long)

#Tidy = one row per observation, and depends what you want the obs to be - can be wide or long


#Challenge 2: get mean life exp, mean population, mean gdp by continent from gap_long
skim(gap_long)
str(gap_long)
gap_long %>% distinct(obs_type)

#my solution
gap_long %>% group_by(continent) %>% 
  summarize(mean_life = mean(obs_values [obs_type == "lifeExp"]), 
            mean_pop = mean(obs_values [obs_type == "pop"]),
            mean_gdp = mean(obs_values [obs_type == "gdpPercap"]))

#posted solution - this is more long format, mine's better
gap_long %>% group_by(continent, obs_type) %>%
  summarize(means=mean(obs_values))

gap_normal <- gap_long %>% 
  spread(obs_type, obs_values)

#dimensions of the df
dim(gap_normal)

#see if the dfs match, but different column orders will not match
all.equal(gap_normal, gapminder)
all_equal(gap_normal, gapminder, ignore_col_order = T) #these are still not eq 'cause one int, other dbl


#reorder columns

gap_normal <- gap_normal[,names(gapminder)]
head(gap_normal)
head(gapminder)
#or names() of each df

#Bring continent and country together in one var
gap_temp <- gap_long %>% 
  unite(var_ID, continent, country, sep = "_")
str(gap_temp)


gap_temp <- gap_long %>% 
  unite(ID_var, continent, country, sep = "_") %>% 
  unite(var_names, obs_type, year, sep = "_")
skim(gap_temp)

#Getting really wide
gap_wide_new <- gap_long %>% 
  unite(ID_var, continent, country, sep = "_") %>% 
  unite(var_names, obs_type, year, sep = "_") %>% 
  spread(var_names, obs_values)
head(gap_wide_new)


#Challenge 3
#spread over country, year, and obs

gap_ludicrously_wide <- gap_long %>% 
  unite(var_names, obs_type, year, country, sep = "_") %>% 
  spread(var_names, obs_values)
head(gap_ludicrously_wide)
skim(gap_ludicrously_wide)







