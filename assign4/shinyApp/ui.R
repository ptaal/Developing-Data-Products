
library(shiny)
library(datasets)
library(caret)
library(e1071)
shinyUI(fluidPage(
    titlePanel("Prediction Application"), 
    sidebarPanel(
        radioButtons("dataset", "Select Data Set", 
                     choices = c("iris", "InsectSprays"), 
                     inline = TRUE, selected = "InsectSprays"), 
        selectInput(inputId = "models",
                    label = "Choose a Model:",
                    choices = c("lda", "rf", "rpart", "lvq")),
        sliderInput('dataPartition', 
                    'Data Partition for Testing Data Set', 
                    min = .20, max = .45, step = .025, value = .30), 
        submitButton("Submit")
    ),
    fluidRow(
        column(3, 
               tableOutput('table')
    ), 
    fluidRow(
        column(6, 
               strong("Unmatched Index: "), 
               textOutput('text6')
        ), 
        column(1, 
               strong("Data Set: "), 
               textOutput('text1')
        ), 
        column(2, 
               strong("Models: "), 
               textOutput('text3')
        ), 
        column(2, 
               strong("Model Accuracy: "), 
               textOutput('text4')
               ), 
        column(2, 
               strong("Cross-Tabulation Accuracy: "), 
               textOutput('text5')
        )
        )
    )
))
