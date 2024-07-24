library(randomForest)
library(writexl)

df<-read.csv(paste0('D:\\2paper\\working\\all.csv'))
#select variables
df<-df[,c('POINT_X','POINT_Y','OC','ele','tp','tem','NDVI','pm','lc_1','soil_types')]
names(df)<-c('long','lat','OC','ele','tp','tem','NDVI','pm','lc','soiltype')
df<-na.omit(df)
df<-df[df$lc!=40,]
df<-df[df$lc!=41,]
df<-df[df$lc!=42,]
df<-df[df$lc!=43,]
df<-df[df$lc!=44,]

tree<-c(50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,
        230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,
        400,410,420,430,440,450,460,470,480,490,500)

try<-c(1,2,3)

mse<-data.frame()

for(i in tree){
  for (j in try){
    rf<-randomForest(OC~ele+tp+tem+NDVI+lc+pm+soiltype,
                     ntree=i,
                     mtry=j,
                     data=df)
    mse[i/10,j]<-rf[["mse"]][length(rf[["mse"]])]
  }
}

write_xlsx(obbmse,'D:\\2paper\\working\\pamameter.csv')