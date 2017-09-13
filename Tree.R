setwd("D://R//Titanic//Script")
getwd()

library(readr)
library(class)
library(rpart)
library(rpart.plot)
library(RColorBrewer)
#install.packages("https://cran.r-project.org/bin/windows/contrib/3.3/RGtk2_2.20.31.zip", repos=NULL)
library(rattle)


train <- read_csv("..//Tree//TrainClean.csv")
test <- read_csv("..//Tree//TestClean.csv")
op <- read_csv("..//Tree//gender_submission.csv")


# Change this command
model <- rpart(survived ~ pclass + sex + age + sibsp + parch + fare + embarked+sex.name+family,
                  data = train, method = "class")
# modelOne <- rpart(survived ~ pclass + sex + age + sibsp + parch + fare + embarked+sex.name+family,
#                     data = train, method = "class", control = rpart.control(minsplit = 2, cp = 0))
# 
# modeltwo <- rpart(survived ~ pclass + sex + age + sibsp + parch + fare + embarked+sex.name+family,
#                        data = train, method = "class", control = rpart.control(minsplit = 50, cp = 0))

my_prediction <- predict(model, test, type = "class")


#keep xerror minimum
fancyRpartPlot(prune(model, cp = model$cptable[which.min(model$cptable[,"xerror"]),"CP"]))
summary.rpart(model)
print(model)
plotcp(model)
printcp(model)
summary(model)
labels(model)

model<-prune(model, cp = model$cptable[which.min(model$cptable[,"xerror"]),"CP"])

my_prediction <- predict(model, test, type = "class")
