
library(kernlab)

# Load in the cleaned data sets
load("D:/HPCC_Example/R/Titanic/train_clean.RData")  # 891 obs
load("D:/HPCC_Example/R/Titanic/test_clean.RData")   # 418 obs


### Create SVM model


# Create the SVM model with SEX, PCLASS, FARE, and AGE
svm.model <- ksvm(survived ~ sex.name + pclass + age + fare + fare.distance, data = train)

# Save our model as a string
model <- "ksvm(survived ~ name + pclass + age + fare + fare.distance, data = train)"


### Saving our model and prediction as a new CSV


# Make our prediction on the TRAIN data set [For calculating error]
train$survived_pred <- predict(svm.model, train, type = "response")

# Make our prediction on the TEST data set
my_prediction <- predict(svm.model, test, type = "response")

my_solution <-data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

test$PassengerId
str(test$survived)

head(test$survived)
# save csv file for submission
write.csv(my_prediction, "svm.csv")
