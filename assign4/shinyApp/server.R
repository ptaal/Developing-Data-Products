library(shiny)
library(datasets)
library(caret)
shinyServer(
    function(input, output) {
        dataset <- reactive({
            switch(input$dataset, iris = iris, 
                   InsectSprays = InsectSprays)
        })
        output$text1 <- renderText({input$dataset})
        
        iristext2 <- reactive({
            if(input$dataset == "iris") {
                switch(input$dataset, iris = "iris")
            }
            else {
                switch(input$dataset, InsectSprays = "InsectSprays")
            }
        })
        output$text2 <- renderText({iristext2()})
    }
)



#diabetesRisk <- function(glucose) glucose / 200

#library(shiny)
#library(datasets)
#library(caret)
#data()
#shinyServer(
    #function(input, output) {
        #data(iris)
        #output$text1 <- renderText({input$text1})
        #output$text2 <- renderText({input$text2})
        #output$text3 <- renderText({
            #if(input$goButton == 0) "You have not pressed the button"
            #else if(input$goButton == 1) "You pressed it once"
            #else "OK quit pressing it"
        #})
    #}
#)






