Etherpad notes:



Welcome to the MMC Software Carpentry Workshop!
Date: April 2, 2019

Post-Workshop Survey: https://www.surveymonkey.com/r/swc_post_workshop_v1?workshop_id=2019-04-02-mmc


RStudio cloud MMC workspace
https://rstudio.cloud/spaces/2891/join?access_code=Ctck%2FrxeytEf8AOLUF9duUD6kJhFZTW030gNz8RK

R Packages of interest:
    - skimr
    - here
    - beepr
    - rticles
    - drake
    - tidyverse
    - pander
    - stargazer
    - assertthat
    -papaja

Free online R books by Hadley Wickham:
    - R for data science: https://r4ds.had.co.nz/index.html
    - R packages: http://r-pkgs.had.co.nz/
    - Advanced R: http://adv-r.had.co.nz/


### Initial Setup

1. Create a github account
2. Create a Rstudio Cloud account and join the MMC workspace: https://rstudio.cloud/spaces/2891/join?access_code=Ctck%2FrxeytEf8AOLUF9duUD6kJhFZTW030gNz8RK
3. On Github, fork this repository: https://github.com/potterzot/2019-04-02-carpentries-mmc.git
4. On Rstudio Cloud, create a new project from github repository

Course website: 
https://potterzot.com/2019-04-02-mmc/

### 


"File organization and naming are powerful weapons against chaos." - Jenny Bryan

“Your closest collaborator is you from six months ago, but you don't reply to emails." -(Paraphrasing) Mark Holder

### Github Setup

git config --global user.name "Vlad Dracula" 
git config --global user.email "vlad@tran.sylvan.ia"

git add readme.md
git status
git commit -m "commit message"
git push
git log
git reflog
git diff

# pull one file from prior commit to into working folder
git checkout HEAD~2 -- src/analysis/gapminder_plot.R


: (colon in terminal) means paged results.  push space bar to go forward and q to quit


### GIt Use
- To check the log in git: "git log"
- To get a condensed version of the log: "git reflog"
- If you see ":" then you have additional output. You can see this by tapping the spacebar or hit "q" to exit


What is the name for GIT? Where does it come from? 
Naming: [https://en.wikipedia.org/wiki/Git#Naming]
Torvalds quipped about the name git (which means unpleasant person in British English slang): "I'm an egotistical bastard, and I name all my projects after myself. First 'Linux', now 'git'."[23][24] The man page describes Git as "the stupid content tracker". The readme file of the source code elaborates further:
    The name "git" was given by Linus Torvalds when he wrote the very first version. He described the tool as "the stupid content tracker" and the name as (depending on your way):
random three-letter combination that is pronounceable, and not actually used by any common UNIX command. The fact that it is a mispronunciation of "get" may or may not be relevant.
stupid. contemptible and despicable. simple. Take your pick from the dictionary of slang.
"global information tracker": you're in a good mood, and it actually works for you. Angels sing, and a light suddenly fills the room.
"goddamn idiotic truckload of sh*t": when it breaks

(haha!)

Git parable: http://tom.preston-werner.com/2009/05/19/the-git-parable.html

### R Projects for Reproducible Research

Good Practicecs: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/good-enough-practices-for-scientific-computing.pdf

Get data from here: https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv

### dplyr
What is this called >? WIKI: https://en.wikipedia.org/wiki/Guillemet

https://www.theguardian.com/notesandqueries/query/0,,-203993,00.html


ggplot code:
    ggplot(data = gapminder, aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  facet_wrap( ~ country)

dplyr/tidyr cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

# Create gap_wide
gap_wide <- gapminder %>%
  gather(key = 'key', value = 'value', c('pop', 'lifeExp', 'gdpPercap')) %>%
  mutate(year_var = paste(key, year, sep = '_')) %>%
  select(country, continent, year_var, value) %>%
  spread(key = 'year_var', value = 'value')

To install skimr:
    "install.packages("skimr")

# Creating gap_long
gap_long <- gap_wide %>%
    gather(obstype_year, obs_values, starts_with('pop'),
           starts_with('lifeExp'), starts_with('gdpPercap'))
gap_long <- gap_long %>% separate(obstype_year,into=c('obs_type','year'),sep="_")
gap_long$year <- as.integer(gap_long$year)

# summarizing it
gap_long %>% group_by(continent,obs_type) %>%
   summarize(means=mean(obs_values))

### Using Rmarkdown
- Cheatsheet: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

###Error question: received error, "Error: attempt to use zero-length variable name" when running this chunk:

```{r, echo=FALSE, message=FALSE}
dat <- readr::read_csv(here("data/gapminder/raw/gapminder.csv"))

```

...but then when I copy/paste the same text above, it runs without error...?
###


To get the code in the HTML to toggle between show and hide

title: "Analysis of Life Expectancy"
author: "Karla Hyde"
date: "4/2/2019"
output: 
  html_document:
      code_folding: hide


The data consist of `r length(unique(d$country))` unique countries tracked from `r range(d$year)[1]` to `r range(d$year)[2]`. Table 1 presents a summary of the variables.

```{r}
pander(summary(d))
```


### Writing Good Software

- Use comments
create code blocks with
### Name of code block --------

- Use asserthat package to create reproducible data validation

Examples of assertions:
    assert_that(ncol(year_country_gdp) == 3)
assert_that(is.integer(year_country_gdp$year))
assert_that(!is.na(year_country_gdp$mean_val))

- Dont repeat yourself
If you are coding something more than a couple times then write a function










































































































































































\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\























Could you please copy your R commands for downloading the data?
library(here)

file_url <- "https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv"
c

download.file(file_url, destfile = here("data/gapminder/raw/gapminder_data.csv"))

# To add:
    git add .gitignore
    git add src/data/gapminder
    Or both at once: git add .

git commit -m "get gapminder data."
git push

Other Reproducible Resources:
https://github.com/ropensci/rrrpkg
http://projecttemplate.net/
https://github.com/cboettig/template







