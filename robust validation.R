library(randomForest)
library(caret)

df<-read.csv('D:\\GIS\\all.csv')
df<-df[,c('OC','soil_types','tem','tp','pm','lc_1','ele','NDVI')]
names(df)<-c('OC','soiltype','tem','tp','pm','lc','ele','NDVI')
df<-na.omit(df)

train_control <- trainControl(method = "cv", number = 10)
tune_grid <- expand.grid(mtry = 1)

model <- train(OC ~ .,  
               data = df,  
               method = "rf",  
               trControl = train_control,
               tuneGrid = tune_grid,
               ntree=150)  

print(model$results)
print(model$resample)

