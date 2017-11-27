library(shiny)
library(readr)

cleanscores <- read_csv("../data/cleandata/cleanscores.csv")
# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Grade Visualizer"),
  
  # Sidebar with table
  sidebarPanel(
    conditionalPanel(condition="input.tabselected==1",
                     h4('Grades Distribution'),tableOutput("view")),
    conditionalPanel(condition="input.tabselected==2",
                     selectInput("variable", "X-axis varable", 
                                 choices = names(cleanscores)),
                     sliderInput("Bin", "Bin Width", 
                                   min = 1, max = 10, value = 10)),
    conditionalPanel(condition="input.tabselected==3",
                     selectInput("variableX", "X-axis varable", 
                                 choices = names(cleanscores),
                                 selected='Test1'),
                     selectInput("variableY", "Y-axis varable", 
                                 choices = names(cleanscores),
                                 selected='Overall'),
                     sliderInput("Opacity", "Opacity", 
                                 min = 0, max = 1, value = 0.5),
                     radioButtons("line_opt", "Show line:",
                                  list("none" = "none",
                                       "lm" = "lm",
                                       "loess" = "loess"))
    )
  ),
  # Show a disPlot
  mainPanel(
    tabsetPanel(
      tabPanel("Barchart", value=1,plotOutput("distPlot")), 
      tabPanel("Histogram", value=2, plotOutput("histogram"), 
               h4('Summary Statistics'),verbatimTextOutput("summary")),
      tabPanel("Scatterplot", value=3, plotOutput("Scatter"),
               h4('Correlation'), verbatimTextOutput("printCor")),
      id = "tabselected"
    )
  )
))