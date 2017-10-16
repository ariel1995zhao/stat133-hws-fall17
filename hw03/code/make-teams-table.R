# ===================================================================
# Title: hw03 Ranking Teams
# Description: This file is for the data preparation so that we are able to use the 
#  raw data in ranking analysis.
# Input(s): data file 'nba2017-roster.csv' and 'nba2017-stats.csv'
# Output(s): data file 'nba2017-teams.csv'
# Author: Tianshu Zhao
# Date: 10-15-2017
# ===================================================================
#Basic packages needed
library(scales)
library(ggplot2)
library(readr)
library(dplyr)
# Import tables
setwd("C:/Users/ariel/stat133/stat133-hws-fall17/hw03")
data_stats <- read.csv("./data/nba2017-stats.csv",
                       stringsAsFactors = FALSE)
data_roster <- read.csv("./data/nba2017-roster.csv",
                        stringsAsFactors = FALSE)
# Add variables
data_stats <- mutate(data_stats,missed_fg = field_goals_atts - field_goals_made)
data_stats <- mutate(data_stats,missed_ft = points1_atts - points1_made)
data_stats <- mutate(data_stats,points = 1*points1_made + 2*points2_made +3*points_made)
data_stats <- mutate(data_stats,rebounds = def_rebounds + off_rebounds)
data_stats <- mutate(data_stats,efficiency = (points + rebounds + assists + steals + blocks
                                              - missed_fg - missed_ft - turnovers)/games_played)
sink(file = '.output/efficiency-summary.txt')
summary(data_stats$efficiency)
sink()

# Merging Tables
teams_merge <- merge(data_roster,data_stats)

## Creating nba2017-teams.csv
#create a data frame teams
teams <- summarise(group_by(teams_merge,team),experience = sum(experience),salary = sum(salary),
                   points3 = sum(points3_made),points2 = sum(points2_made),
                   free_throws = sum(points1_made),points = sum(points),
                   off_rebounds = sum(off_rebounds),def_rebounds = sum(def_rebounds),
                   assists = sum(assists), steals = sum(steals), blocks = sum(blocks),
                   turnovers = sum(turnovers), fouls = sum(fouls), efficiency = sum(efficiency)
                   )
summary(teams)

sink(file = './data/teams-summary.txt')
summary(teams)
sink()

write.csv(team, file = './data/nba2017-teams.csv')

# Some graphics
pdf(file = './images/teams_star_plot.pdf')
stars(teams[,-1],labels = as.character(teams$team))
dev.off

library(ggplot2)
ggplot(teams,aes(x = experience, y = salary,label = team)) + geom_point() +
    geom_text(aes(label = team))
ggsave('./images/experience_salary.pdf',width = 5,height = 5)









