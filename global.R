library(shiny)
library(xgboost)
library(DT)

dmClass <- xgb.load("diamons model")
load("dmClassinfo.rda")


generatepreds <- function(depth = 60, table = 50, price = 335, x = 4, y = 4) {
  testDF <- 
    as.matrix(depth, table, price, x, y)
  
  
  preds <- predict(dmClass, testDF)
  
  
  data.frame(Cut = dmClassinfo$var.levels
             ,preds) %>%
    arrange(desc(preds))
  
}