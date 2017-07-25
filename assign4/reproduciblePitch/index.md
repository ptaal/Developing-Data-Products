---
title       : "shiny document"
subtitle    : 
author      : 
job         : 
framework   : html5slides   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [shiny, interactive]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
output      : html_document
runtime     : shiny 
#output:
    #revealjs::revealjs_presentation:
        #transition: fade
--- {class: class1, id: id1, bg: white}

## Week 4 - Reproducible Pitch Presentation
  
Pouria  
July 25, 2017





--- {class: class2, id: id2, bg: white}

## Application Design With Server.R Code Example
###### This Shiny application conveniently assists you to make predictions on either "iris" or "InsectSprays" data set. You may [Click Here] (https://ptaal.shinyapps.io/shinyApp/) to see the Shiny Application.

```r
radio_buttons <- h6(radioButtons("dataset", "Select Data Set", 
                                 choices = c("iris", "InsectSprays"), 
                                 inline = TRUE, selected = "InsectSprays"))
print(radio_buttons)
```

<h6>
  <div id="dataset" class="form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline">
    <label class="control-label" for="dataset">Select Data Set</label>
    <div class="shiny-options-group">
      <label class="radio-inline">
        <input type="radio" name="dataset" value="iris"/>
        <span>iris</span>
      </label>
      <label class="radio-inline">
        <input type="radio" name="dataset" value="InsectSprays" checked="checked"/>
        <span>InsectSprays</span>
      </label>
    </div>
  </div>
</h6>

--- {class: class3, id: id3, bg: white}

## Application Design With R Code Expression Example  
###### Some R code example for the iris **Data Partition** section:

```r
library(caret)
inTrain <- createDataPartition(y = iris$Species, p = 0.3, list = FALSE)
training <- iris[-inTrain, ]
testing <- iris[inTrain, ]
dim(iris)
```

```
## [1] 150   5
```

```r
dim(training)
```

```
## [1] 105   5
```

```r
dim(testing)
```

```
## [1] 45  5
```

--- {class: class4, id: id4, bg: white}

## How To Use 
1. Select either of "iris" or "InsectSprays" data set
2. Choose between models of, lda, rf, rpart, or lvq
3. Select the percentage of data being allocated to the new testing data set
4. Click the "Submit" button to see the results on the left side

--- {class: class5, id: id5, bg: white}

## Results Interpretation and Why To Use This App!!

* The **table** displays the first 6 unmatched rows
* **Unmatched Index**, displays the original index of all the unmatched rows
* Data Set, displays the selected data set
* Models, displays the selected model
* Model Accuracy, displays the accuracy level in percentage
* Cross-Tabulation Accuracy, displays the actual accuracy between the outcome column and the model predicted column in percentage

#### Finally, use this application if you LOVE prediction

