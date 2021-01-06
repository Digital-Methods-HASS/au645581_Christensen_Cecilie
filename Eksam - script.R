
```{r libraries, echo = FALSE}
library(tidyverse)
library(gapminder)
library(dplyr)
library(tidyr)
library(scales)
```#Making sure to activate the packages 

#Getting a plot for the Danes' view of the economy in a year if they answered 1
#in question V81

Data2011_limited <- select(Data2011, V81, V152)
Data2011_limited2 <- filter(Data2011_limited, V81 == "1")

ggplot(subset(Data2011_limited2), aes(x = V152)) +
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  ggtitle("Answer to V152 if answer in V81 was 1") +
  xlab("Answer to V152")+
  ylab("frequency")
#https://stackoverflow.com/questions/19835987/display-frequency-instead-of-count-with-geom-bar-in-ggplot


#Personal economy in 1 year across years

V206 <- select(Data2009, V206)
V164 <- select(Data2007, V164)
V150 <-select(Data2011, V150)

#2007
ggplot(subset(V164), aes(x = V164)) +
  geom_bar(aes(y = (..count..)/sum(..count..)))+
  ggtitle("Economy in a year, from 2007")+
  xlab("Answer to V164")+
  ylab("frequency")

#2009
ggplot(subset(V206), aes(x = V206)) +
  geom_bar(aes(y = (..count..)/sum(..count..)))+
  ggtitle("Economy in a year, from 2009")+
  xlab("Answer to V206")+
  ylab("frequency")

#2011
ggplot(subset(V150), aes(x = V150)) +
  geom_bar(aes(y = (..count..)/sum(..count..)))+
  ggtitle("Economy in a year, from 2011")+
  xlab("Answer to V150")+
  ylab("frequency")

#Denmarks ecomony in a year across 2009 and 2011

#2009
ggplot(subset(Data2009), aes(x = V213))+
  geom_bar(aes(y = (..count..)/sum(..count..)))+
  ggtitle("Denmarks economy in a year, from 2009")+
  xlab("Answer to V213")+
  ylab("frequency")

#2011
ggplot(subset(Data2011), aes(x = V152))+
  geom_bar(aes(y = (..count..)/sum(..count..)))+
  ggtitle("Denmarks economy in a year, from 2011")+
  xlab("Answer to V152")+
  ylab("frequency")


