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
        output$text4 <- renderText({
            if(iristext2() == "iris") {
                outcome = "Species"
            }
            else {
                outcome = "spray"
            }
            inTrain <- createDataPartition(
                y = dataset()[[outcome]], p = partition(), 
                list = FALSE)
            training <- reactive({
                dataset()[inTrain, ]
            })
            testing <- reactive({
                dataset()[-inTrain, ]
            })
            predictors <- reactive({
                names(
                    dataset()[-which(names(dataset()) == outcome)]
                    )
            })
            set.seed(123)
            train_control <- trainControl(
                method = "cv", number = 10, 
                savePredictions = 'final', classProbs = TRUE)
            set.seed(123)
            model_fit <- train(training()[predictors()], 
                               factor(training()[[outcome]]), 
                               method = models(),
                               trControl = train_control
                               )
            return(model_fit$results[['Accuracy']])
            #output$text5 <- renderText({
                #model_fit$results['Accuracy']})
            #return(model_fit)
        })
    }
)






