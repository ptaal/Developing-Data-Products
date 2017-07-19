library(shiny)
library(datasets)
library(caret)
shinyServer(
    function(input, output) {
        #data(iris, InsectSprays)
        selectedData <- reactive({
            switch(input$dataset, iris = iris, 
                   InsectSprays = insects)
        })
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


irisInTrain <- createDataPartition(y = iris$Species, 
                                   p = 0.3, list = FALSE)
irisTraining <- iris[irisInTrain, ]
irisTesting <- iris[-irisInTrain, ]
irisOutcome <- "Species"
irisPredictors <- names(iris[-which(names(iris) == irisOutcome)])
set.seed(123)
train_control <- trainControl(method = "cv", number = 10, 
                              savePredictions = 'final', 
                              classProbs = TRUE)
set.seed(123)
irisModelLda <- train(irisTraining[, irisPredictors], 
                  irisTraining[, irisOutcome], 
                  method = "lda", trControl = train_control)
irisModelKnn <- train(irisTraining[, irisPredictors], 
                  irisTraining[, irisOutcome], 
                  method = "knn", trControl = train_control)
irisModelRf <- train(irisTraining[, irisPredictors], 
                      irisTraining[, irisOutcome], 
                      method = "rf", trControl = train_control)
irisModelRpart <- train(irisTraining[, irisPredictors], 
                     irisTraining[, irisOutcome], 
                     method = "rf", trControl = train_control)
## Learning Vector Quantization (LVQ)
irisModelLvq <- train(irisTraining[, irisPredictors], 
                        irisTraining[, irisOutcome], 
                        method = "lvq", trControl = train_control)
# display model 'Accuracy'
irisModelLda$results['Accuracy']
#irisModelKnn$results['Accuracy']
irisModelRf$results['Accuracy']
irisModelRpart$results['Accuracy']
irisModelLvq$results['Accuracy']
# prediction
irisTesting$pred_lda <- predict(
    irisModelLda, irisTesting[, irisPredictors])
irisTesting$pred_rf <- predict(
    irisModelRf, irisTesting[, irisPredictors])
irisTesting$pred_rpart <- predict(
    irisModelRpart, irisTesting[, irisPredictors])
irisTesting$pred_lvq <- predict(
    irisModelLvq, irisTesting[, irisPredictors])
# confusion matrix
confusionMatrix(irisTesting$Species, 
                irisTesting$pred_lda)$overall['Accuracy']
confusionMatrix(irisTesting$Species, 
                irisTesting$pred_rf)$overall['Accuracy']
confusionMatrix(irisTesting$Species, 
                irisTesting$pred_rpart)$overall['Accuracy']
confusionMatrix(irisTesting$Species, 
                irisTesting$pred_lvq)$overall['Accuracy']
# getting & head displaying the unmatched rows
rowDifference <- vector()
for (i in 1:dim(irisTesting)[1]) {
    if(irisTesting$Species[i] != irisTesting$pred_lda[i]) {
        rowDifference <- append(
            rowDifference, rownames(irisTesting[i,]))
    }
}
head(irisTesting[rowDifference, c("Species", "pred_lda")])


## testing with lvq
rowDifference <- vector()
for (i in 1:dim(irisTesting)[1]) {
    if(irisTesting$Species[i] != irisTesting$pred_lvq[i]) {
        rowDifference <- append(
            rowDifference, rownames(irisTesting[i,]))
    }
}
irisTesting[rowDifference, c("Species", "pred_lvq")]



