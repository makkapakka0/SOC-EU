library(rgdal)
library(raster)
library(ggplot2)
library(ggbeeswarm)
library(randomForest)
library(fastshap)
library(iml)
library(tidyr)
library(dplyr)
library(writexl)
library(gplots)
library(sf)

#read data
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

#train random forest model
rf<-randomForest(OC~ele+tp+tem+NDVI+pm+lc+soiltype,
                  ntree=150,
                  mtry=1,
                  data=df)

#selected 6 variables
df1<-df[ ,c('lc','ele','tp','tem','NDVI','pm','soiltype')]

#read map for prediction
map<-shapefile(paste0('D:\\2paper\\working\\fishnetclip.shp'))
#select variables
df2<-map@data[ ,c('POINT_X','POINT_Y','lc','ele','tp','tem','NDVI','pm','soil_types','temf')]
#remove -9999
df2<-df2[df2$lc!=-9999,]
df2<-df2[df2$ele!=-9999,]
df2<-df2[df2$tp!=-9999,]
df2<-df2[df2$tem!=-9999,]
df2<-df2[df2$NDVI!=-9999,]
df2<-df2[df2$pm!=-9999,]
df2<-df2[df2$soil_types!=-9999,]
df2<-df2[df2$temf!=-9999,]
#remove land cover types that are not shown in training data
df2<-df2[df2$lc!=5, ]
df2<-df2[df2$lc!=43, ]
df2<-df2[df2$lc!=38, ]
df2<-df2[df2$lc!=39, ]
df2<-df2[df2$lc!=40, ]
df2<-df2[df2$lc!=41, ]
df2<-df2[df2$lc!=42, ]
df2<-df2[df2$lc!=43, ]
df2<-df2[df2$lc!=44, ]
df2<-df2[df2$lc!=45, ]
df2<-df2[df2$lc!=46, ]
df2<-df2[df2$lc!=47, ]
df2<-df2[df2$lc!=49, ]
#remove parent material types that are not shown in training data
df2<-df2[df2$pm!=1120, ]
df2<-df2[df2$pm!=3410, ]
df2<-df2[df2$pm!=3430, ]
df2<-df2[df2$pm!=4310, ]
df2<-df2[df2$pm!=4410, ]
df2<-df2[df2$pm!=5420, ]
df2<-df2[df2$pm!=5700, ]
df2<-df2[df2$pm!=5800, ]
df2<-df2[df2$pm!=5820, ]
df2<-df2[df2$pm!=6100, ]
df2<-df2[df2$pm!=8100, ]
df2<-df2[df2$pm!=8200, ]
#remove elevations that are not shown in training data
df2<-df2[df2$ele<2078, ]
#remove soil types that are not shown in training data
df2<-df2[df2$soil_types!=2,]
df2<-df2[df2$soil_types!=4,]
df2<-df2[df2$soil_types!=5,]
df2<-df2[df2$soil_types!=10,]
df2<-df2[df2$soil_types!=11,]
df2<-df2[df2$soil_types!=15,]
df2<-df2[df2$soil_types!=17,]
df2<-df2[df2$soil_types!=19,]
df2<-df2[df2$soil_types!=22,]
df2<-df2[df2$soil_types!=24,]
df2<-df2[df2$soil_types!=25,]
df2<-df2[df2$soil_types!=29,]
df2<-df2[df2$soil_types!=30,]
df2<-df2[df2$soil_types!=35,]
df2<-df2[df2$soil_types!=37,]
df2<-df2[df2$soil_types!=40,]
df2<-df2[df2$soil_types!=41,]
df2<-df2[df2$soil_types!=42,]
df2<-df2[df2$soil_types!=43,]
df2<-df2[df2$soil_types!=44,]
df2<-df2[df2$soil_types!=45,]
df2<-df2[df2$soil_types!=46,]
df2<-df2[df2$soil_types!=51,]
df2<-df2[df2$soil_types!=53,]
df2<-df2[df2$soil_types!=54,]
df2<-df2[df2$soil_types!=55,]
df2<-df2[df2$soil_types!=60,]
df2<-df2[df2$soil_types!=63,]
df2<-df2[df2$soil_types!=64,]
df2<-df2[df2$soil_types!=66,]
df2<-df2[df2$soil_types!=69,]
df2<-df2[df2$soil_types!=70,]
df2<-df2[df2$soil_types!=71,]
df2<-df2[df2$soil_types!=72,]
df2<-df2[df2$soil_types!=74,]
df2<-df2[df2$soil_types!=75,]
df2<-df2[df2$soil_types!=80,]
df2<-df2[df2$soil_types!=81,]
df2<-df2[df2$soil_types!=82,]
df2<-df2[df2$soil_types!=84,]
df2<-df2[df2$soil_types!=94,]
df2<-df2[df2$soil_types!=99,]
df2<-df2[df2$soil_types!=100,]
df2<-df2[df2$soil_types!=103,]
df2<-df2[df2$soil_types!=104,]
df2<-df2[df2$soil_types!=105,]
df2<-df2[df2$soil_types!=106,]
df2<-df2[df2$soil_types!=109,]
df2<-df2[df2$soil_types!=112,]
df2<-df2[df2$soil_types!=117,]
df2<-df2[df2$soil_types!=118,]
df2<-df2[df2$soil_types!=125,]
df2<-df2[df2$soil_types!=127,]

#rename the variables
names(df2)<-c('long','lat','lc','ele','tp','tem','NDVI','pm','soiltype','temf')
#predict current SOC in Europe
pred<-predict(rf,newdata=df2)


#global shap model
X<-df[,c('lc','ele','tp','tem','NDVI','pm','soiltype')]
Y<-as.data.frame(rf[["predicted"]])

#local shap model for the traning data
df_shap<-df[ ,c('lc','ele','tp','tem','NDVI','pm','soiltype')]
shap<-fastshap::explain(rf,
               X = df_shap,
               nsim = 100,
               baseline = 0,
               adjust = TRUE,
               pred_wrapper = function(model,newdata){
                 predict(model,newdata)
               },
               newdata = df_shap)

#convert into dataframe
shap<-as.data.frame(shap)
#select variables
shap_s<-shap[ ,c('ele','tp','tem','NDVI')]
#create id for each row of shap values
shap_s$id<-seq_len(nrow(shap_s))
names(shap_s)<-c('Elevation','Annual 
precipitation','Annual 
mean 
temperature',
                 'NDVI','id')
#convert into long dataframe
data1<-gather(shap_s,key='name',value = 'shap',-id)
#create id for each row of variable values
X$id<-seq_len(nrow(X))
#standardization
X$ele1=(X$ele-min(X$ele))/(max(X$ele)-min(X$ele))
X$tp1=(X$tp-min(X$tp))/(max(X$tp)-min(X$tp))
X$tem1=(X$tem-min(X$tem))/(max(X$tem)-min(X$tem))
X$NDVI1=(X$NDVI-min(X$NDVI))/(max(X$NDVI)-min(X$NDVI))
#select standardized data
X1<-X[ , c('id','ele1','tp1','tem1','NDVI1')]
#rename the names
names(X1)<-c('id','Elevation','Annual 
precipitation','Annual 
mean 
temperature','NDVI')
#convert into long dataframe
data2<-gather(X1,key='name',value='value',-id)
#combine the 2 dataframes
data1<-left_join(data1,data2)

#plot the summary
ggplot(data1,aes(x=shap,y=name,color=value))+
  geom_quasirandom(method='pseudorandom',alpha=0.2,size=0.8)+
  labs(x='SHAP value (g/kg)',y='Variable',color='Feature value')+
  scale_color_gradient(
    low='#6600cc',
    high='#ffcc33',
    breaks=c(0,1),
    labels=c('Low','High'),
    guide=guide_colorbar(barwidth=3,barheight = 6)
  )+
  xlim(-20,100)+
  theme_minimal()+
  theme(axis.text = element_text(size=20),
        axis.title = element_text(size=24),
        panel.border = element_rect(colour = 'black',fill=NA),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'),
        legend.title = element_text(size = 20),
        legend.text = element_text(size = 18))+
  ggsave('D:\\2paper\\maps\\all.tiff',dpi=300,width = 10, height=6)

#get sum of the shap values
shap$sum<-rowSums(shap)
#add xy to variables dataset
df_shap_xy<-df[ ,c('long','lat','lc','ele','tp','tem','NDVI','pm','soiltype')]
#combine the 2 dataframes
merge<-cbind(df_shap_xy,shap)
#rename the variables
names(merge)<-c('x','y','lc','ele','tp','tem','NDVI','pm','soiltype',
                'lcs','eles','tps','tems','NDVIs','pms','soiltypes','sum')
#convert K to C
merge$tem<-merge$tem-273.15
#convert m/s to mm/y
merge$tp<-merge$tp*3600*24*365*1000

#plot elevation
ggplot(merge,aes(x=ele,y=eles))+
  geom_jitter(size=0.8,height=0.4,width=0,alpha=0.2)+
  geom_smooth(method='loess',span=0.1,se=TRUE,color='red',linetype='solid',size=1.5)+
  ylim(-15,40)+
  xlab('Elevation (m)')+
  ylab('SHAP value (g/kg)')+
  theme_minimal()+
  theme(axis.text = element_text(size=24),
        axis.title = element_text(size=28),
        panel.border = element_rect(colour = 'black',fill=NA,size=2),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\eleshap.tiff',dpi=300,width=10,height=6)

#plot temperature
ggplot(merge,aes(x=tem,y=tems))+
  geom_jitter(size=0.8,height=0.4,width=0,alpha=0.2)+
  geom_smooth(method='loess',span=0.1,se=TRUE,color='red',linetype='solid',size=1.5)+
  ylim(-10,80)+
  xlab('Annual mean temperature (℃)')+
  ylab('SHAP value (g/kg)')+
  theme_minimal()+
  theme(axis.text = element_text(size=24),
        axis.title = element_text(size=28),
        panel.border = element_rect(colour = 'black',fill=NA,size=2),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\temshap.tiff',dpi=300,width=10,height=6)

#plot precipitation
ggplot(merge,aes(x=tp,y=tps))+
  geom_jitter(size=0.8,height=0.4,width=0,alpha=0.2)+
  geom_smooth(method='loess',span=0.1,se=TRUE,color='red',linetype='solid',size=1.5)+
  ylim(-10,80)+
  xlim(0,2000)+
  xlab('Annual precipitation (mm/y)')+
  ylab('SHAP value (g/kg)')+
  theme_minimal()+
  theme(axis.text = element_text(size=24),
        axis.title = element_text(size=28),
        panel.border = element_rect(colour = 'black',fill=NA,size=2),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\tpshap.tiff',dpi=300,width=10,height=6)

#plot NDVI
ggplot(merge,aes(x=NDVI,y=NDVIs))+
  geom_jitter(size=0.8,height=0.4,width=0,alpha=0.2)+
  geom_smooth(method='loess',span=0.1,se=TRUE,color='red',linetype='solid',size=1.5)+
  ylim(-15,60)+
  xlab('NDVI')+
  ylab('SHAP value (g/kg)')+
  theme_minimal()+
  theme(axis.text = element_text(size=24),
        axis.title = element_text(size=28),
        panel.border = element_rect(colour = 'black',fill=NA,size=2),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\NDVIshap.tiff',dpi=300,width=10,height=6)

#plot parent material
#get parent material and its shap
gd<-merge[,c('pm','pms')]
#group the data by parent material
gd<-group_by(gd,pm)
#get the mean shap value of each type of parent material
smd<-summarise(gd,mean_value=mean(pms))
#get the top 5
pmdata<-merge[merge$pm %in% c(8000,6111,5500,2115,2111),]
#change the id into real name
pmdata$pm[pmdata$pm==8000]<-c('Organic 
materials')
pmdata$pm[pmdata$pm==6111]<-c('Boulder
clay')
pmdata$pm[pmdata$pm==5500]<-c('Lake 
deposits')
pmdata$pm[pmdata$pm==2115]<-c('Detrital
limestone')
pmdata$pm[pmdata$pm==2111]<-c('Hard 
limestone')
#plot
ggplot(pmdata,aes(x=pm,y=pms,group=pm))+
  stat_boxplot(geom='errorbar',width=0.1)+
  geom_boxplot()+
  ylim(-5,40)+
  xlab('Parent material')+
  ylab('SHAP value (g/kg)')+
  theme_minimal()+
  theme(axis.text = element_text(size=24),
        axis.title = element_text(size=28),
        panel.border = element_rect(colour = 'black',fill=NA,size=2),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\pmshap.tiff',dpi=300,width=10,height=6)

#plot land cover
#get land cover and its shap
gd<-merge[,c('lc','lcs')]
#group the data by land cover
gd<-group_by(gd,lc)
#get the mean shap value of each type of land cover
smd<-summarise(gd,mean_value=mean(lcs))
#get the top 5
lcdata<-merge[merge$lc %in% c(36,24,29,35,32),]
#change the id into real name
lcdata$lc[lcdata$lc==36]<-c('Peat bogs')
lcdata$lc[lcdata$lc==24]<-c('Coniferous
forest')
lcdata$lc[lcdata$lc==29]<-c('Transitional
woodland
shrub')
lcdata$lc[lcdata$lc==35]<-c('Inland 
marshes')
lcdata$lc[lcdata$lc==32]<-c('Sparsely 
vegetated 
area')
#plot
ggplot(lcdata,aes(x=lc,y=lcs,group=lc))+
  stat_boxplot(geom='errorbar',width=0.1)+
  geom_boxplot()+
  ylim(0,100)+
  xlab('Land cover')+
  ylab('SHAP value (g/kg)')+
  theme_minimal()+
  theme(axis.text = element_text(size=24),
        axis.title = element_text(size=28),
        panel.border = element_rect(colour = 'black',fill=NA,size=2),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\lcvshap.tiff',dpi=300,width=10,height=6)

#plot soil types
#get soil types and its shap
gd<-merge[,c('soiltype','soiltypes')]
#group the data by land cover
gd<-group_by(gd,soiltype)
#get the mean shap value of each type of land cover
smd<-summarise(gd,mean_value=mean(soiltypes))
#get the top 5
stdata<-merge[merge$soiltype %in% c(111,67,77,108,68),]
#change the id into real name
stdata$soiltype[stdata$soiltype==111]<-c('Placic 
podzol')
stdata$soiltype[stdata$soiltype==67]<-c('Dystric 
histosol')
stdata$soiltype[stdata$soiltype==77]<-c('Dystric 
leptosol')
stdata$soiltype[stdata$soiltype==108]<-c('Haplic 
podzol')
stdata$soiltype[stdata$soiltype==68]<-c('Eutric 
histosol')
#plot
ggplot(stdata,aes(x=soiltype,y=soiltypes,group=soiltype))+
  stat_boxplot(geom='errorbar',width=0.1)+
  geom_boxplot()+
  ylim(0,60)+
  xlab('Soil type')+
  ylab('SHAP value (g/kg)')+
  theme_minimal()+
  theme(axis.text = element_text(size=24),
        axis.title = element_text(size=28),
        panel.border = element_rect(colour = 'black',fill=NA,size=2),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\stshap.tiff',dpi=300,width=10,height=6)


#to GIS
#residual
merge$res<-rf[["predicted"]]-df$OC
#get xy
coordinates(merge)<-c('x','y')
#define crs
shap_df1<-st_as_sf(merge,coords=c('x','y'),crs=4326)
#save as shapefile
st_write(shap_df1,'D:\\2paper\\working\\pointshap.shp',append=FALSE)


#local shap model for the whole study area
#select variables
df3<-df2[ ,c('lc','ele','tp','tem','NDVI','pm','soiltype')]
#split the data to small datasets to avoid RAM issue
splite1<-df3[1:1000000,]
splite2<-df3[1000001:2000000,]
splite3<-df3[2000001:3000000,]
splite4<-df3[3000001:4000000,]
splite5<-df3[4000001:4188083,]
df_s<-df[ ,c('lc','ele','tp','tem','NDVI','pm','soiltype')]
#calculate shap. Here if I use loop, an error occurs and I don't know why
shap1<-fastshap::explain(rf,
              X=df_s,
              nsim=100,
              baseline = 0,
              adjust = TRUE,
              pred_wrapper = function(model,newdata){
                predict(model,newdata)
              },
              newdata = splite1)
shap2<-fastshap::explain(rf,
               X=df_s,
               nsim=100,
               baseline = 0,
               adjust = TRUE,
               pred_wrapper = function(model,newdata){
                 predict(model,newdata)
               },
               newdata = splite2)
shap3<-fastshap::explain(rf,
               X=df_s,
               nsim=100,
               baseline = 0,
               adjust = TRUE,
               pred_wrapper = function(model,newdata){
                 predict(model,newdata)
               },
               newdata = splite3)
shap4<-fastshap::explain(rf,
               X=df_s,
               nsim=100,
               baseline = 0,
               adjust = TRUE,
               pred_wrapper = function(model,newdata){
                 predict(model,newdata)
               },
               newdata = splite4)
shap5<-fastshap::explain(rf,
               X=df_s,
               nsim=100,
               baseline = 0,
               adjust = TRUE,
               pred_wrapper = function(model,newdata){
                 predict(model,newdata)
               },
               newdata = splite5)
#combine the splited data and convert it into dataframe
shap_all<-rbind(shap1,shap2,shap3,shap4,shap5)
shap_all<-as.data.frame(shap_all)
shap_all<-na.omit(shap_all)
#calculate the sum of the shap values
shap_all$sum<-rowSums(shap_all)
#contribution ratio of each variable
pro<-shap_all[,1:7]/shap_all$sum


#add the name of the variable that contributes the most
shap_all$pro<-colnames(shap_all[,1:7])[apply(pro,1,which.max)]

#predict SOC in the next 60 years
#get the variables
df5<-df2[ ,c('lc','ele','tp','temf','NDVI','pm','soiltype')]
#rename the variables
names(df5)<-c('lc','ele','tp','tem','NDVI','pm','soiltype')
#predict SOC
predf<-predict(rf,newdata=df5)
#calculate SOC change
diff<-predf-pred
#combine with variables
shap_all<-cbind(shap_all,df2,pred,predf,diff)

#to GIS
#map residual for LUCAS data
df$pred<-rf[["predicted"]]
df$res<-df$pred-df$OC
write_xlsx(df,'D:\\2paper\\working\\res.csv')
#for fishnet
#coordinates, crs
output<-st_as_sf(shap_all,coords=c('long','lat'),crs=4326)
#save as shapefile
st_write(output,'D:\\2paper\\working\\allshap6.shp',append=FALSE)

#barchart of SOC distribution along latitude
SOC<-raster('D:\\2paper\\processed\\predsoc2018.tif')
SOC<-as.data.frame(SOC,xy=TRUE)
SOC<-na.omit(SOC)
SOC<-group_by(SOC,y)
median<-summarise(SOC,median_value=median(predsoc2018))
ggplot(median,aes(x=y,y=median_value))+
  geom_bar(stat='identity',fill='brown')+
  geom_smooth(method='loess',span=0.1,se=FALSE,color='black',linetype='solid',size=1.5)+
  xlab('')+
  ylab('')+
  coord_flip()+
  theme(panel.background = element_rect(fill='transparent',colour = NA),
        plot.background = element_rect(fill='transparent',color = NA),
        panel.border = element_rect(colour = 'black',fill=NA),
        panel.grid.major = element_line(colour = 'transparent'),
        panel.grid.minor = element_line(colour = 'transparent'),
        axis.text = element_text(size=16),
        axis.title = element_text(size=18),
        axis.text.y=element_blank())+
  ggsave('D:\\2paper\\maps\\bar.tiff',dpi=300,width=9,height=9)
  

#plot LUCAS SOC and latitude
ggplot(df,aes(x=lat,y=OC))+
  geom_jitter(size=0.4,height=0.4,width=0,alpha=0.2)+
  geom_smooth(method='loess',span=0.1,se=FALSE,color='red',linetype='solid',size=1.5)+
  ylim(0,600)+
  xlab('')+
  ylab('')+
  theme(axis.text = element_text(size=16),
        axis.title = element_text(size=18))+
  coord_flip()+
  theme(panel.background = element_rect(fill='transparent',colour = NA),
        plot.background = element_rect(fill='transparent',color = NA),
        panel.border = element_rect(colour = 'black',fill=NA),
        panel.grid.major = element_line(colour = 'gray80'),
        panel.grid.minor = element_line(colour = 'gray80'),
        axis.line = element_line(colour = 'black'))+
  ggsave('D:\\2paper\\maps\\SOClatitude.tiff',dpi=300,width=9,height=9)

