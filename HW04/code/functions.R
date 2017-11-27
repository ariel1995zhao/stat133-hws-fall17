# Title: HW04 - Grades Visualizer
# Description: This file is a description of functions for data preparation purpose
# Input(s): data file 'rawscores.csv' and 'cleanscores.csv'
# Output(s): data file 'summary-rawscores.txt'
# Author: Tianshu Zhao
# Date: 11-17-2017

# remove_missing()
a <- c(1,4,7, NA, 10)

remove_missing <- function(a) {
  # parameter:
  # a: a numeric vector
  # return vector without missing value
  result <- c()
  for (i in 1:length(a)) {
    if (!is.na(a[i])) {
      result <- c(result, a[i])
    }
  }
  return(result)
}
remove_missing(a)


# get_minimum()
a <- c(1,4,7,NA,10)
get_minimum <- function(a,na.rm = TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return minimum value
  if(na.rm){
    a <- remove_missing(a)
  }
  return(sort(a)[1])
}

get_minimum(a,na.rm = TRUE)

#get_maximum()
a <- c(1,4,7,NA,10)
get_maximum <- function(a,na.rm=TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return maxium value
  if(na.rm){
    a <- remove_missing(a)
  }
  sort(a,decreasing = TRUE)[1]
}

get_maximum(a,na.rm = TRUE)

# get_range()
a <- c(1,4,7,NA,10)
get_range <- function(a,na.rm=TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return range of the vector
  if (na.rm){
    a <- remove_missing(a)
  }
  get_maximum(a,na.rm) - get_minimum(a,na.rm)
}
get_range(a,na.rm = TRUE)

# get_median()
a <- c(1,4,7,NA,10)
get_median <- function(a, na.rm=TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return median of the vector
  if(na.rm){
    a <- remove_missing(a)
  }
  sort(a)
  if(length(a)%%2 == 0){
    (a[length(a)/2] + a[length(a)/2 +1])/2
  }else{
    a[length(a)/2 +1/2]
  }
}

get_median(a,na.rm = TRUE)

# get average()
a <- c(1,4,7,NA,10)
get_average <- function(a, na.rm=TRUE) {
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return average of the vector
  summation <- 0
  if (na.rm){
    a <- remove_missing(a)
  }
  for (i in 1:length(a)) {
    summation <- summation + a[i]
  }
  return(summation / length(a))
}

get_average(a, na.rm = TRUE)

#get_stdev()
a <- c(1,4,7,NA,10)
get_stdev <- function(a, na.rm=TRUE) {
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return standard deviation of the vector
  temp_sd <- 0
  if (na.rm){
    a <- remove_missing(a)
  }
  average_a=get_average(a)
  for (i in 1:length(a)) {
    temp_sd <- temp_sd+ (a[i]-average_a)**2
  }
  stdev=sqrt(temp_sd/(length(a)-1))
  return(stdev)
}
get_stdev(a, na.rm=TRUE)


#get_quartile1()
a <- c(1, 4, 7, NA, 10)
get_quartile1 <- function(a,na.rm=TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return first quartile of the vector
  return(quantile(a, 0.25, na.rm = na.rm, names=FALSE))
}
get_quartile1(a, na.rm = TRUE)

#get_percentile10()
a <- c(1, 4, 7, NA, 10)
get_percentile10 <- function(a,na.rm=TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return first quartile of the vector
  return(quantile(a, 0.1, na.rm = na.rm, names=FALSE))
}
get_percentile10(a, na.rm = TRUE)

#get_quartile3()
a <- c(1, 4, 7, NA, 10)
get_quartile3 <- function(a,na.rm=TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return third quartile of the vector
  return(quantile(a, 0.75, na.rm = na.rm, names=FALSE))
}

#get_percentile90()
a <- c(1, 4, 7, NA, 10)
get_percentile90 <- function(a,na.rm=TRUE){
  # parameter:
  # a: a numeric vector
  # na.rm : logical argument on missing value
  # return first quartile of the vector
  return(quantile(a, 0.9, na.rm = na.rm, names=FALSE))
}
get_percentile90(a, na.rm = TRUE)

#count_missing()
a <- c(1, 4, 7, NA, 10)
count_missing <- function(a){
  # parameter:
  # a: a numeric vector
  # return the number of NA
  count_NA<-0
  for (i in 1:length(a)) {
    if (is.na(a[i])) {
      count_NA <- count_NA+1
    }
  }
  return(count_NA)
}
count_missing(a)

#summary_stats()
get_pro_name <- function(){
  #return names of properties
  return(c('minimum', 'percent10', 'quartile1',
                    'median','mean', 'quartile3','percent90',
                    'maximum','range', 'stdev', 'missing'))
}
get_fun_name <- function(){
  #return names of functions
  return(c('get_minimum', 'get_percentile10', 'get_quartile1',
           'get_median','get_average', 'get_quartile3','get_percentile90',
           'get_maximum','get_range', 'get_stdev', 'count_missing'))
}

summary_stats <- function(a){
  # parameter:
  # a: a numeric vector
  # return the summary of stats
  property_names=get_pro_name()
  function_names=get_fun_name()
  for(i in 1:length(property_names)){
    assign(property_names[i], get(function_names[i])(a))
  }
  stats<-list(minimum=minimum,percent10=percent10,quartile1=quartile1,
              median=median, mean=mean, quartile3=quartile3, percent90=percent90,
              maximum=maximum,range=range,stdev=stdev,missing=missing
              )
  return(stats)
}
stats<- summary_stats(a)
stats

#print_stats
print_stats <-function(stats){
  # parameter:
  # stats: a list returned by summary_stats
  # print summary of stats
  stats_name=names(stats)
  i<-1
  for(s in stats){  
    print(gettextf('%9s: %4.4f',stats_name[i],s))
    i<-i+1
  }
}
print_stats(stats)

#rescaled100
b <- c(18, 15, 16, 4, 17,9)
rescale100<-function(x, xmin, xmax){
  #parameter:
  #x a numeric vector
  #xmin minimum
  #xmax maximum
  #return rescaled vector
  return(100*(x-xmin)/(xmax-xmin))
}
rescale100(b, xmin=0, xmax=20)

#drop_lowest
b <-c(10, 10, 8.5, 4, 7, 9)
drop_lowest<-function(b){
  #parameter:
  #b a numeric vector
  #return a numeric vector without lowest value
  return(b[-order(b)[1]])
  
}
drop_lowest(b)

#score_homework
hws <-c(100, 80, 30, 70, 75, 85)
score_homework <- function(hws, drop=TRUE){
  #parameter:
  #hws: a numeric vector
  #drop: logical argument to drop lowest value
  #return average value
  if(drop){
    hws=drop_lowest(hws)
  }
  return(get_average(hws))
}
score_homework(hws, drop=TRUE)
score_homework(hws, drop=FALSE)

#score_quiz
quizzes <-c(100,80,70,0)
score_quiz<-function(quizzes, drop=TRUE){
  #quiz: a numeric vector of quiz score
  #drop: logical argument to drop lowest value
  #return average value
  if(drop){
    quizzes=drop_lowest(quizzes)
  }
  return(get_average(quizzes))
}
score_quiz(quizzes, drop=TRUE)
score_quiz(quizzes, drop=FALSE)

#score_lab
score_lab<-function(attendance){
  #attendance: value of lab attendance
  #return lab score
  if(attendance==11 || attendance ==12){return(100)
  } else if(attendance ==10){return(80)
  } else if(attendance ==9){return(60)
  } else if(attendance ==8){return(40)
  } else if(attendance ==7){return(20)
  } else if(attendance <=6){return(0)}
}
score_lab(12)
score_lab(10)
score_lab(6)