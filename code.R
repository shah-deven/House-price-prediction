# reading the training dataset
library(readr)
to_train <- read_csv("F:/sbu/homework_2/properties_2016.csv/to_train.csv")
View(to_train)
#reading the file to test
library(readr)
to_test <- read_csv("F:/sbu/homework_2/properties_2016.csv/to_test.csv")
View(to_test)
library(readr)
joined_tables_to_submit <- read_csv("F:/sbu/homework_2/properties_2016.csv/joined_tables_to_submit.csv")
View(joined_tables_to_submit)
library(readr)
to_train_new <- read_csv("F:/sbu/homework_2/properties_2016.csv/to_train_new.csv")
View(to_train_new)
library(brnn)
#splitting the dataset into training and testing set
test_set <- to_train_new[entire_train, ]
train_set <- to_train_new[-entire_train, ]
df = data.frame(calculatedfinishedsquarefeet = test_set$calculatedfinishedsquarefeet, fips = test_set$fips)
#df
attach(train_set)
# making a model of brnn with fips and calculatedfinishedsquarefeet and fips as features and neurons = 75
out = brnn(logerror ~ fips + calculatedfinishedsquarefeet, neurons = 75)
#View(df)
output = predict(out, newdata = df)
library(Metrics)
#calculating mean square error value
mse(output, test_set$logerror)
#creating the submission file to submit it for Kaggle challenge
final = data.frame(parcelid = joined_tables_to_submit$parcelid, '201610' = output, '201611' = output, '201612' = output, '201710' = output, '201711' = output, '201712' = output)
write.csv(final, file = "to_submit_2.csv", row.names = F)
