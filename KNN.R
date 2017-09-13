setwd("D://R//Titanic//Script")
getwd()

library(readr)
library(class)

train <- read_csv("..//Tree//TrainClean.csv")
test <- read_csv("..//Tree//TestClean.csv")
op <- read_csv("..//Tree//gender_submission.csv")

# Normalize function used to normalize thedata
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
#pclass
train$pclass <- normalize(train$pclass)
test$pclass <- normalize(test$pclass)

#Sibsp
train$sibsp <- normalize(train$sibsp)
test$sibsp <- normalize(test$sibsp)

#Parch
train$parch <- normalize(train$parch)
test$parch <- normalize(test$parch)

# Sex in numeric
train$sex <- factor(train$sex, levels=c("male","female"), labels=c(0,1))
train$sex <- as.integer(as.character(train$sex))
test$sex <- factor(test$sex, levels=c("male","female"), labels=c(0,1))
test$sex <- as.integer(as.character(test$sex))


#My input data is normalized
survived <- train$survived
passengers <- op$PassengerId
train <- train[,c("pclass","sex","sibsp","parch", "fare.distance", "family"
                  ,"age_scale", "fare_scale")]
test <- test[,c("pclass","sex","sibsp","parch", "fare.distance", "family"
                ,"age_scale", "fare_scale")]

# Run the KNN function

CreateKNN <- knn(train, test, survived, k = 5,  l = 0, prob = FALSE, use.all = TRUE)
submission <- data.frame(PassengerId = passengers,Survived = CreateKNN)
# write.csv(submission,'titanic_knn.csv')