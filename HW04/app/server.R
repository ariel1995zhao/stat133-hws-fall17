library(shiny)
library(readr)

source('../code/functions.R')
# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  cleanscores <- read_csv("../data/cleandata/cleanscores.csv")
  freq=table(cleanscores$Grade)
  freq=freq[ c(3,1,2,6,4,5,9,7,8,10,11)]
  
  output$distPlot <- renderPlot({
    barplot(freq, col=4, xlab="Grade",ylab= "frequency")
  })
  output$histogram <- renderPlot({
    hist(cleanscores[[input$variable]], col="grey",
         breaks=100/input$Bin,main='',xlab=input$variable, ylab = 'count')
  })
  
  output$summary <- renderPrint({
    temp_stats=summary_stats(cleanscores[[input$variable]])
    print_stats(temp_stats)
  })
  output$view <- renderTable({
    Grade=names(freq)
    Prop=round(freq/sum(freq),2)
    new_table=cbind(Grade,freq, Prop)
  })
  get_col <-function(opacity){
    return(rgb(opacity,opacity,opacity))
  }
  output$Scatter <- renderPlot({
    X=input$variableX
    Y=input$variableY
    plot(cleanscores[[X]], cleanscores[[Y]], xlab=X, ylab=Y,
         pch=16, col=get_col(input$Opacity))
    if(input$line_opt == 'lm'){
    abline(lm(formula = as.formula(paste(X, " ~ ", Y)), 
              data = cleanscores))}
    if(input$line_opt == 'loess'){
      loess_pred=predict(loess(formula = as.formula(paste(X, " ~ ", Y)), 
                data = cleanscores))
      lines(loess_pred)}
  })
  output$printCor <- renderPrint({
    X=input$variableX
    Y=input$variableY
    cor(cleanscores[[X]], cleanscores[[Y]])
  })
})