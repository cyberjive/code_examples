#################################
#KC Crime Map
#Not intended for production use
#TODO: tweak plotting, add firearm
#used flag
################################

#clean the environment
rm(list = ls())

#load libraries
require(ggplot2)
require(caret)
require(ggmap)
require(readr)
require(dplyr)
require(Amelia)

#read the data into a dataframe
setwd("C:/Users/James/Downloads")
df.crime_14 <- read.csv("KCPD_Crime_Data_2014.csv", stringsAsFactors = F)
df.crime_15 <- read.csv("KCPD_Crime_Data_2015.csv", stringsAsFactors = F)

#clean the dataframes of rows without gps
df.crime_14 <- filter(df.crime_14, df.crime_14$Location.1 != "")
df.crime_15 <- filter(df.crime_15, df.crime_15$Location.1 != "")
df.crime_15 <- subset(df.crime_15, grepl(".*\\(", df.crime_15$Location.1))
#grab one final outlier
df.crime_15 <- filter(df.crime_15, df.crime_15$Report_No != 150053326)

#append the two data sets for other analysis
df.crime <- rbind(df.crime_14, df.crime_15)

#check the appended data
head(df.crime)
tail(df.crime)
str(df.crime)
glimpse(df.crime)

#change IBRS to factor for grouping/searching
df.crime$IBRS <- as.factor(df.crime$IBRS)

#check for dupes
#df.kc_crime%>% group_by(Report_No) %>% summarize(count = n()) %>% filter(count!=1)
#multiple duplicate report numbers due to KCPD reporting policies

#remove victim records/duplicate data points to help with overplotting
df.crime <- filter(df.crime, df.crime$Involvement != "VIC")

#pull out lat/long substring, remove parentheses, read into new data frame
coords14 <- sub(".*\\(", "", df.crime_14$Location.1)
coords14 <- sub("\\).*", "", coords14)
coords15 <- sub(".*\\(", "", df.crime_15$Location.1)
coords15 <- sub("\\).*", "", coords15)
t.coords_14 <- read.table(text = coords14, sep = ",")
t.coords_15 <- read.table(text = coords15, sep = ",")
#check results
head(t.coords_14)
tail(t.coords_14)
head(t.coords_15)
tail(t.coords_15)

#make sure we didn't miss any
missmap(t.coords_14)
missmap(t.coords_15)

#add Latitude and Longitude columns and check records
df.crime_14 <- mutate(df.crime_14, Latitude = t.coords_14$V1)
df.crime_14 <- mutate(df.crime_14, Longitude = t.coords_14$V2)
df.crime_15 <- mutate(df.crime_15, Latitude = t.coords_15$V1)
df.crime_15 <- mutate(df.crime_15, Longitude = t.coords_15$V2)
head(df.crime_14)
tail(df.crime_15)

#using ggmap, pull a map of the greater Kansas City Metro
map.kansas_city <- qmap("kansas city", zoom = 11, source = "google", maptype = "toner", darken = c(.3, "#BBBBBB"))
map.kansas_city

#plot the data over the map, first 2014
map.kansas_city +
  geom_point(data = df.crime_14, aes(x = Longitude, y = Latitude)
             , color = "dark green"
             , alpha = .03
             , size = 1.1)+
  ggtitle("Crime Dispersement in Kansas City, Missouri, 2014")
#scale_y_countinuous(limits(c(-91, -105))) +
#scale_x_countinuous(limits(c(31, 42)))

#then 2015
map.kansas_city +
  geom_point(data = df.crime_15, aes(x = Longitude, y = Latitude)
             , color = "dark green"
             , alpha = .03
             , size = 1.1)+
  ggtitle("Crime Dispersement in Kansas City, Missouri, 2015")


#alternative plotting style/heatmap
map.kansas_city +
  stat_density2d(data=df.crime_14, aes(x=Longitude
                                           , y=Latitude
                                           ,color=..density..
                                           ,size=ifelse(..density..<=1,0,..density..)
                                           ,alpha=..density..)
                 ,geom="tile",contour=F) +
  scale_color_continuous(low="orange", high="red", guide = "none") +
  scale_size_continuous(range = c(0, 3), guide = "none") +
  scale_alpha(range = c(0,.5), guide="none") +
  ggtitle("Kansas City Crime Heatmap") +
  theme(plot.title = element_text(family="Trebuchet MS", size=36, face="bold", hjust=0, color="#777777"))
