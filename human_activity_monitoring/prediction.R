library(caret)    

har_data <- read.csv("dataset-har-PUC-Rio-ugulino.csv", na.strings = c("NA",""), sep= ";")
har_data_ <- har_data[,6:19]

set.seed(33833)
har_in_train <- createDataPartition(har_data_$class, p=0.8, list = F)
har_data_training <- har_data_[har_in_train,]
har_data_testing <- har_data_[-har_in_train,]

control <- trainControl(method = "cv", number = 5)
model_fit_rf <- train(class ~ ., data = har_data_training, method = "rf", trControl = control)
model_fit_rf$results
