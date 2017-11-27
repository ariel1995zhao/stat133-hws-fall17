source("functions.R")

library(readr)
rawscores <- read_csv("../data/rawdata/rawscores.csv")


sink('../output/summary-rawscores.txt')
str(rawscores)
for(rc in rawscores){
  temp_stats=summary_stats(rc)
  print_stats(temp_stats)
  }
sink()

#replacing all mising values
for(i in 1:nrow(rawscores)){
  for(j in 1:ncol(rawscores)){
    if(is.na(rawscores[i,j])){
      rawscores[i,j]<-0
    }
  }
}

#rescale all columns
rawscores$QZ1=rescale100(rawscores$QZ1,0,12)
rawscores$QZ2=rescale100(rawscores$QZ2,0,18)
rawscores$QZ3=rescale100(rawscores$QZ3,0,20)
rawscores$QZ4=rescale100(rawscores$QZ4,0,20)
rawscores$Test1=rescale100(rawscores$EX1,0,80)
rawscores$Test2=rescale100(rawscores$EX2,0,90)

#Add Homework
raw_homework=rawscores[,1:9]
rawscores$Homework=apply(raw_homework, 1, score_homework)

#Quiz
raw_quiz=rawscores[, 11:14]
rawscores$Quiz=apply(raw_quiz, 1, score_quiz)

#Overall
temp_Lab = rawscores$ATT
for(i in 1:length(rawscores$ATT)){
  temp_Lab[i]=score_lab(rawscores$ATT[i])}
rawscores$Lab=temp_Lab

#Overall
cal_overall <- function(all_scores){
  all_scores['Lab']*0.1 + all_scores['Homework']*0.3+
    all_scores['Quiz']*0.15+all_scores['Test1']*0.2+all_scores['Test2']*0.25
}
rawscores$Overall<-apply(rawscores, 1, cal_overall)

#Grade
get_grade <- function(overall_score){
  if(overall_score>=0 && overall_score <50){return('F')}
  else if(overall_score >=50 && overall_score < 60) {return('D')}
  else if(overall_score >=60 && overall_score < 70) {return('C-')}
  else if(overall_score >=70 && overall_score < 77.5) {return('C')}
  else if(overall_score >=77.5 && overall_score < 79.5) {return('C+')}
  else if(overall_score >=79.5 && overall_score < 82) {return('B-')}
  else if(overall_score >=82 && overall_score < 86) {return('B')}
  else if(overall_score >=86 && overall_score < 88) {return('B+')}
  else if(overall_score >=88 && overall_score < 90) {return('A-')}
  else if(overall_score >=90 && overall_score < 95) {return('A')}
  else if(overall_score >=95 && overall_score <= 100) {return('A+')}
}

#Overall
temp_grade = rawscores$Overall
for(i in 1:length(rawscores$Overall)){
  temp_grade[i]=get_grade(rawscores$Overall[i])}
rawscores$Grade=temp_grade

#sink all results
result_list=c('Lab','Homework','Quiz','Test1','Test2','Overall')
for(result in result_list){
  sink(gettextf('../output/%s-stats.txt', result))
  temp_stats=summary_stats(rawscores[[result]])
  print_stats(temp_stats)
  sink()
}
sink('../output/summary-cleanscores.txt')
cleanscores=rawscores
str(cleanscores)
sink()

write_csv(cleanscores, '../data/cleandata/cleanscores.csv')
