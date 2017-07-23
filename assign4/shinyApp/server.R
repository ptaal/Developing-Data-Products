
library(shiny)
library(datasets)
library(caret)
shinyServer(
    function(input, output) {
        # Assigning the selected data set to 
        # the reactive variable dataset 
        dataset <- reactive({
            switch(input$dataset, iris = iris, 
                   InsectSprays = InsectSprays)
        })
        # Rendering the selected data set output
        output$text1 <- renderText({
            #paste("Data Frame: ", input$dataset)
            input$dataset
        })
        
        selected_dataset <- reactive({
            if(input$dataset == "iris") {
                switch(input$dataset, iris = "iris")
            }
            else {
                switch(input$dataset, InsectSprays = "InsectSprays")
            }
        })
        # Creating the options for models
        models <- reactive({
            switch(input$models, lda = "lda", rf = "rf", 
                   rpart = "rpart", lvq = "lvq")
        })
        # Rendering the selected model output
        output$text3 <- renderText({
            #paste("Model:", models())
            models()
        })
        
        partition <- reactive({
            partition <- input$dataPartition
        })
        
        statement <- reactive({
            if(selected_dataset() == "iris") {
                outcome = "Species"
            }
            else {
                outcome = "spray"
            }
        })
        # Creating the data partition based on the
        # previous selections
        inTrain <- reactive({
            inTrain <- createDataPartition(
                y = dataset()[[statement()]], p = partition(), 
                list = FALSE)
        })
        # Creating the training data frame
        training <- reactive({
            dataset()[inTrain(), ]
        })
        # Creating the testing data frame
        testing <- reactive({
            dataset()[-inTrain(), ]
        })
        # Storing the predictors' column names based
        # on the selected information
        predictors <- reactive({
            names(
                dataset()[-which(names(dataset()) == statement())]
            )
        })
        # Setting up the train_control - cross-validation
        set.seed(123)
        train_control <- trainControl(
            method = "cv", number = 10, 
            savePredictions = 'final', classProbs = TRUE)
        # Storing the trained model
        set.seed(123)
        model_fit <- reactive({
            train(training()[predictors()], 
                  factor(training()[[statement()]]), 
                  method = models(), 
                  trControl = train_control
            )
        })
        # Rendering the trained model accuracy output to 
        # be displayed
        output$text4 <- renderText({
            #paste("Model Accuracy: ", 
                  round(max(model_fit()$results$Accuracy), 4)
        })
        # Creating the column with the actual predicted values
        pred <- reactive({
            predict(model_fit(), 
                    newdata = as.data.frame(testing()[predictors()]))
        })
        # Combining the original data set with the above column
        combined_data <- reactive({
            cbind(testing(), predicted = pred())
        })
        # Rendering the confusionMatrix function to 
        # find the actual accuracy of the outcome column
        # with the predicted column
        confusion_matrix <- reactive({
            confusionMatrix(
                testing()[[statement()]], 
                combined_data()$predicted)$overall['Accuracy']
        })
        # Rendering the confusionMatrix output to be displayed
        output$text5 <- renderText({
            #paste("Cross-Tabulation: ", 
             #     round(confusion_matrix()), 4)
            round(confusion_matrix(), 4)
        })
        # Finding out the rows that are not matching, after
        # the actual outcome values and the predicted values
        # are compared row by row and returning the unmatched
        # index/indices
        row_difference <- reactive({
            row_difference <- vector()
            for (i in 1:dim(combined_data())[1]) {
                if (combined_data()[[statement()]][i] != 
                    combined_data()$predicted[i]) {
                    row_difference <- append(
                        row_difference, 
                        rownames(combined_data()[i, ])
                    )
                }
            }
            return(row_difference)
        })
        # Rendering the row_difference() output, to display
        # all the unmatched rows for further investigation
        output$text6 <- renderText({
            paste(row_difference())
        })
        # Adding the "index" column to the entire data set, that 
        # contains the unmtached rows
        final_data <- reactive({
            final_data <- combined_data()[row_difference(), ]
            final_data2 <- cbind("Index" = row_difference(), 
                                 final_data)
        })
        # Rendering to display the head of the final data set, 
        # that contains the unmatched rows between the outcome 
        # columns and the predicted column
        output$table <- renderTable({
            head(final_data())
        })
    }
)
