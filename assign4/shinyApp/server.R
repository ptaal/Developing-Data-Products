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
        models <- reactive({
            switch(input$models, lda = "lda", rf = "rf", 
                   rpart = "rpart", lvq = "lvq")
        })
        output$text3 <- renderText({models()})
        partition <- reactive({
            partition <- input$dataPartition
        })
        output$table <- renderTable({
            if(iristext2() == "iris") {
                outcome = "Species"
            }
            else {
                outcome = "spray"
            }
            #return(outcome)
            inTrain <- createDataPartition(
                y = dataset()[[outcome]], p = partition(), 
                list = FALSE)
            #return(length(inTrain))
            #training <- dataset()[inTrain, ]
            training <- reactive({
                dataset()[inTrain, ]
            })
            return(head(training()))
            #testing <- reactive({
                #dataset()[-inTrain, ]
            #})
            #testing <- dataset()[-inTrain, ]
            #predictors <- reactive({
                #names(
                    #dataset()[-which(names(dataset()) == outcome)]
                    #)
            #})
            #set.seed(123)
            #return(training()[[1]])
            #return(predictors())
            #predictors <- names(
                #dataset()[-which(names(dataset()) == outcome)])
            #return(predictors)
            #set.seed(123)
            #train_control <- trainControl(
                #method = "cv", number = 10, 
                #savePredictions = 'final', classProbs = TRUE)
            #set.seed(123)
            #model_fit <- train(training[[ ,predictors]], 
                               #training[[ ,outcome]], 
                               #method = models(),
                               #trControl = train_control)
            #output$text5 <- renderText({
                #model_fit$results['Accuracy']})
            #return(model_fit)
        }, align = 'l')
        #output$table <- renderTable(training)
        #inTrain <- createDataPartition(
         #   y = models$outcome, p = 0.3, list = FALSE
        #)
        
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






