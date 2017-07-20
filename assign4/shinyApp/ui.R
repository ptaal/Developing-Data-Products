# 07/10/17(main): my shiny app project is:
# let the user create a project for themselves (i think)
# it works on particular data and predicts for a certain 
# variable (basically created app similar to my course 
# project for the practical-machine-learning course project!)
# working with (iris and InsectSprays) data frame 


library(shiny)
library(datasets)
library(caret)
shinyUI(fluidPage(
    titlePanel("Prediction Application"), 
    sidebarPanel(
        radioButtons("dataset", "Data Set", 
                     choices = c("iris", "InsectSprays"), 
                     inline = TRUE, selected = "InsectSprays") 
        #sliderInput('sliderMPG', 'What is the MPG of the car?', 
                    #10, 35, value = 20)
        
    ),
    mainPanel(
        p('Output text1'), 
        textOutput('text1'),
        p('Output text2'), 
        textOutput('text2')
    )
))


#shinyUI(pageWithSidebar(
    #headerPanel("Hello Shiny!"), 
    #sidebarPanel(
        #textInput(inputId = "text1", label = "Input Text1"), 
        #textInput(inputId = "text2", label = "Input Text2"), 
        #actionButton("goButton", "Go!")
    #), 
    #mainPanel(
        #p('Output text1'),
        #textOutput('text1'), 
        #p('Output text2'), 
        #textOutput('text2'), 
        #p('Output text3'), 
        #textOutput('text3')
    #)
#))