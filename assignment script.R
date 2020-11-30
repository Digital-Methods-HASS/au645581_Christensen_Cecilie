---
  title: "HW5 - Make Data Move"
author: ""
date: "05/10/2020"
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Explore the recent global developments with R
Today, you will load a filtered gapminder dataset - 
with a subset of data on global development from 
1952 - 2007 in increments of 5 years - to capture 
the period between the Second World War and the 
Global Financial Crisis. 

**Your task: Explore the data and visualise it in both static
and animated ways, providing answers and solutions to 
7 questions/tasks below.**
  
  ## Get the necessary packages
  First, start with installing the relevant packages 
'tidyverse', 'gganimate', and 'gapminder'.
install.packages("gganimate")
install.packages("gapminder")
install.packages("gifski")
install.packages("av")
install.packages("knitr")

```{r libraries, echo = FALSE}
library(tidyverse)
library(gganimate)
library(gapminder)
library(av)
library(gifski)
library(knitr)
```

## Look at the data
First, see which specific years are actually represented in 
the dataset and what variables are being recorded for 
each country. Note that when you run the cell below, 
Rmarkdown will give you two results - one for each line 
- that you can flip between.

```{r}
unique(gapminder$year)
head(gapminder)
```
The dataset contains information on each country in the 
sampled year, its continent, life expectancy, population, 
and GDP per capita.

Lets plot all the countries in 1952.
```{r 1957}
theme_set(theme_bw()) 
# set theme to white background for better visibility
ggplot(subset(gapminder, year == 1952), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() 
```
We see an interesting spread with an outlier to the right. 
Answer the following questions, please:

Q1. Why does it make sense to have a log10 scale on x axis?
 the difference in size between the lifeExp. and the gdpPercap 
would make the plot very hard to read, because the x axis would
be to long, but by having a log10 scale on the x axis, 
you make it more readeble. 

Q2. What country is the richest in 1952 (far right on x axis)? 
 
  subset(gapminder, year == 1952)%>% 
  group_by(country,gdpPercap) %>% 
  summarize(min_gdpPercap=min(gdpPercap),
            max_gdpPercap=max(gdpPercap)) %>%
  arrange(desc(max_gdpPercap)) #stigende med desc

by running this script you get a ranking of the countries with the highest 
GdpPercap, highest to lowest. the highest is Kuwait. 

# You can generate a similar plot for 2007 and compare the differences

```{r 2007}
ggplot(subset(gapminder, year == 2007), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10()

subset(gapminder, year == 2007)%>% 
  group_by(country,gdpPercap) %>% 
  summarize(min_gdpPercap=min(gdpPercap),
            max_gdpPercap=max(gdpPercap)) %>%
  arrange(desc(max_gdpPercap)) #stigende med desc

if you change the year to 2007 you will see that it has changed to Norweay 
just above Kuwait. 

```
The black bubbles are a bit hard to read, the comparison would 
be easier with a bit more visual differentiation.

Q3. Can you differentiate the continents by color and fix 
the axis labels?
  
 #change the color
   ggplot(subset(gapminder, year == 2007), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point(alpha = 0.5, aes(color = continent)) +
  scale_x_log10() 


Q4. What are the five richest countries in the world in 2007?

per what I did in 2007 the five richest countries are, Norway, Kuwait, 
Singapore, USA and Ireland


##  Make it move!

The comparison would be easier if we had the two graphs together, animated.
We have a lovely tool in R to do this: the `gganimate` package. 
And there are two ways of animating the gapminder ggplot.

### Option 1: Animate using transition_states() 

The first step is to create the object-to-be-animated
```{r anim1 start}
anim <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10()  # convert x to log scale
anim
```

#This plot collates all the points across time. The next step is to split it
#into years and animate it. This may take some time, depending on the processing
#power of your computer (and other things you are asking it to do). Beware that 
#the animation might appear in the 'Viewer' pane, not in this rmd preview.
#You need to knit the document to get the viz inside an html file.

```{r anim1}
anim + transition_states(year,  
                      transition_length = 1,
                      state_length = 1)
```
#Notice how the animation moves jerkily, 'jumping' from one year
#to the next 12 times in total. This is a bit clunky,
#which is why its good we have another option. 


###Option 2 
Animate using transition_time()
This option smoothes the transition between different 'frames', 
because it interpolates and adds transitional years where there 
are gaps in the timeseries data.

```{r anim2}
anim2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() + 
  transition_time(year)
anim2
```
# convert x to log scale

The much smoother movement in Option 2 will be much more 
noticeable if you add a title to the chart, that will page
through the years corresponding to each frame.


Q5 Can you add a title to one or both of the animations above
that will change in sync with the animation? 
  [hint: search labeling for transition_states()
   and transition_time() functions respectively]

```{r anim2}
anim2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() + # convert x to log scale
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
anim2
```

Q6 Can you made the axes labels and units more readable? 
Consider expanding the abreviated lables as well as the 
scientific notation in the legend and x axis to whole numbers.
[hint:search disabling scientific notation]

{r anim2}
anim2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() + # convert x to log scale
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
  options(scipen = 999)             # Modify global options in R
anim2

the second to last line will change the numbers to actual numbers



