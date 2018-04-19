library(xgboost)
library(tidyverse)
dm<- diamonds

y1 <- dm$cut
var.levels <- levels(y1)
y = as.integer(y1) - 1

noOutcome <-dm[,-2] 
x = noOutcome[,c('depth', 'table', 'price', 'x', 'y')]
var.names <- names(x)
x = as.matrix(x)

params <- list(
  "objective" = "multi:softprob"  #does a 1 vs all sort of thing
  , "eval_metric" = "mlogloss"
  , "num_class" = length(table(y))
  , "eta" = .5
  , "max_depth" = 3
)

cv.nround = 250

bst.cv <- xgb.cv(param = params, data = x, label = y
                 ,nfold = 5, nrounds = cv.nround
                 , missing = NA, prediction = TRUE)


nrounds = which.min(bst.cv$evaluation_log$test_mlogloss_mean)
bst.cv$evaluation_log[nrounds,]

dmClass <- xgboost(param = params, data = x, label = y
                 , nrounds = nrounds
                 , missing = NA)

xgb.importance(var.names, model = dmClass)

xgb.save(dmClass, "diamons model")


dmClassinfo <- list(
  var.names =var.names
  ,var.levels = var.levels
)

save(dmClassinfo, file = "dmClassinfo.rda")


generatepreds <- function(depth = 60, table = 50, price = 335, x = 4, y = 4) {
testDF <- 
  as.matrix(depth, table, price, x, y)


preds <- predict(dmClass, testDF)


data.frame(Cut = var.levels
           ,preds) %>%
  arrange(desc(preds))

}