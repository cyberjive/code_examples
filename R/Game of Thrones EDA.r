#############################################
# GoT EDA on Kaggle for (eventual) submission
# TODO: Handle outliers/NA's, 
# complete analysis of battles
# start analysis/prediction for characters
# not intended production
###########################################

#clean the environment
rm(list=ls())

#load libraries
#require(caret)
require(dplyr)
require(ggplot2)
require(readr)
require(tidyr)
require(Amelia)
require(readr)
require(plotly)
require(plyr)
require(dplyr)
#require(Hmisc)
#require(corrplot)

#set the working directory
setwd("C:/Users/james.putterman/Downloads")

#read .csv's into dataframes
battles <- read.csv("battles.csv", na.strings = c(""), stringsAsFactors = F)
c.deaths <- read.csv("character-deaths.csv", na.strings = c(""), stringsAsFactors = F)
c.pred <- read.csv("character-predictions.csv", na.strings = c(""), stringsAsFactors = F)

#check for any missing values
missmap(battles, main = "Missing values vs Observerd")
#missmap(c.deaths, main = "Missing values vs Observerd")
#missmap(c.pred, main = "Missing values vs Observerd")

#change battle_type to factor
battles$battle_type <- as.factor(battles$battle_type)

#set the levels for the battle type factor
revalue(battles$battle_type, c("ambush"="Ambush",
                               "pitched battle" = 'Pitched Battle',
                               "razing" = "Razing",
                               "siege" = "Siege"))

#change attacker_outcome to factor
battles$attacker_outcome <- as.factor(battles$attacker_outcome)

#set the levels for the factor so the case is correct
revalue(battles$attacker_outcome, c("win" = "Win", "loss" = "Loss"))
levels(battles$attacker_outcome)

#change Allegiance to factor
#c.deaths$Allegiances <- as.factor(c.deaths$Allegiances)

#change Book to a factor
#c.deaths$Book.of.Death <- as.factor(c.deaths$Book.of.Death)


#changing a few things in the data...
glimpse(battles)
# I'm going to give Joffrey the appropriate credit for the War he started, 
# Also, while he may be the Devil incarnate, we've not been privy to Euron's plan, so only
# Balon gets credit for his second failed rebellion

#change attacker and defender king variables to factors and correct the names
#attacker king
battles$attacker_king <- as.factor(battles$attacker_king)
#check levels and correct as needed
levels(battles$attacker_king)
#change level labels
battles$attacker_king <- revalue(battles$attacker_king, c("Balon/Euron Greyjoy" = "Balon Greyjoy",
                                                          "Joffrey/Tommen Baratheon" = "Joffrey Baratheon",
                                                          "Robb Stark" = "Robb Stark",
                                                          "Stannis Baratheon" = "Stannis Baratheon"))

#defender king
battles$defender_king <- as.factor(battles$defender_king)
#check levels and correct as needed
levels(battles$defender_king)
#change level labels
battles$defender_king <- revalue(battles$defender_king, c("Balon/Euron Greyjoy" = "Balon Greyjoy",
                                                          "Joffrey/Tommen Baratheon" = "Joffrey Baratheon",
                                                          "Mance Rayder" = "Mance Rayder",
                                                          "Renly Baratheon" = "Renly Baratheon",
                                                          "Robb Stark" = "Robb Stark",
                                                          "Stannis Baratheon" = "Stannis Baratheon"))

#change location to a factor
battles$location <- as.factor(battles$location)
levels(battles$location)

#change region to a factor
battles$region <- as.factor(battles$region)
levels(battles$region)

#pull the substring out (R could be better with this :|)
#test.kings <- strsplit(battles$attacker_king, "/")
#print(test.kings)

#hist(battles$major_death)

#plot a general look at battles, their participants, and the end result
x <- ggplot(data=battles, aes(x=attacker_king, y=name, fill=attacker_outcome, color=attacker_outcome)) +
  geom_point() + 
  theme(axis.text.x = element_text(size = 8, angle=35, hjust=1),
        axis.text.y = element_text(size = 8, hjust=1)) +
  scale_fill_discrete(name = "Attacker Outcome",
                      labels =c("Loss", "Win")) +
  scale_color_discrete(name = "Attacker Outcome",
                       label = c("Loss", "Win")) +
  xlab("Attacker King") + 
  ylab("Battle Name") + 
  ggtitle("Battles of A Song of Ice and Fire")

#We have a few outliers: the NA king represents the two Razing's presented in the set:
#Saltpans and Burning Septry, both perpetrated by outlwas with no allegiance. We've
#also got one dot for Attacker Outcome that isn't filled in: this is the Siege of Winterfell
#(The Mannis vs. Bolton) which has occured in the show but not the books...yet. They're removalbe
#in terms of 'clean data', but the insights they represent are big enough I believe they deserve
#to be left in.

battles[which(battles$attacker_king==""), "name"]

y <- ggplot(data=battles, aes(x=attacker_king)) +
  geom_bar(aes(fill=region)) + 
  coord_flip() +
  xlab("Attacker King") +
  ylab("Count of Battles") +
  ggtitle("Battle Distribution by Region") +
  scale_fill_discrete(name = "Region")


y2 <- ggplotly(x)
print(y2)

ggplot(data=battles, aes(x=defender_size, y=attacker_size, color=battle_type)) +
  geom_point() +
  geom_line()

ggplot(data=battles, aes(y=attacker_outcome, x=attacker_size)) +
  geom_point(aes(color=attacker_outcome))

print(x)
print(y)
