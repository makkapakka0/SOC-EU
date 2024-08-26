library(randomForest)
library(writexl)
library(ggplot2)

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

df<-read.csv(paste0('D:\\2paper\\working\\para.csv'))

ggplot(df,aes(x=ntree,y=MSE,color=mtry))+
  geom_line()+
  labs(x='ntree',y='MSE',color='mtry')+
  theme_minimal()+
  theme(axis.text = element_text(size=20),
        axis.title = element_text(size=24),
        panel.border = element_rect(colour = 'black',fill=NA),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'),
        legend.position = c(0.9,0.86),
        legend.text = element_text(size=16),
        legend.title = element_text(size=0))+
  ggsave('D:\\2paper\\maps\\parameter.tiff',dpi=300,width=10,height=6)
