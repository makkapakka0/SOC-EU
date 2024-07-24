library(ncdf4)
library(raster)
library(rgdal)
library(ggplot2)
library(randomForest)

nc_data<-nc_open('D:\\2paper\\working\\era5.nc')

lon<-ncvar_get(nc_data,nc_data[["dim"]][["longitude"]])
lat<-ncvar_get(nc_data,nc_data[["dim"]][["latitude"]])
t<-ncvar_get(nc_data,nc_data[["dim"]][["time"]])
tem<-ncvar_get(nc_data,nc_data[["var"]][["t2m"]])
tp<-ncvar_get(nc_data,nc_data[["var"]][["tp"]])


tem<-tem[ , ,1:120]
tp<-tp[ , ,1:120]

tem<-apply(tem,2:1,mean,drop=FALSE)
tp<-apply(tp,2:1,mean,drop=FALSE)

print(lon)
print(lat)
extent<-extent(c(-15,35,30,75))

raster_data<-raster(tem,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])
crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\temv1.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)

raster_data<-raster(tp,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])
crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\tpv1.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)


tem<-ncvar_get(nc_data,nc_data[["var"]][["t2m"]])
tp<-ncvar_get(nc_data,nc_data[["var"]][["tp"]])

tem<-tem[ , ,121:240]
tp<-tp[ , ,121:240]

tem<-apply(tem,2:1,mean,drop=FALSE)
tp<-apply(tp,2:1,mean,drop=FALSE)

raster_data<-raster(tem,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])
crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\temv2.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)

raster_data<-raster(tp,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])
crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\tpv2.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)

df<-read.csv(paste0('D:\\2paper\\working\\validation.csv'))
df<-na.omit(df)
train<-df[,c('OC09','ele','tpv09','tem09','NDVI09','pm','lc09','soiltypes')]
names(train)<-c('OC','ele','tp','tem','NDVI','pm','lc','soiltype')

rf<-randomForest(OC~ele+tp+tem+NDVI+pm+lc+soiltype,
                 ntree=150,
                 mtry=1,
                 data=train)

mse<-sum((rf[["predicted"]]-train[['OC']])*(rf[["predicted"]]-train[['OC']]))/13054


test<-df[,c('OC18','ele','tpv18','tem18','NDVI18','pm','lc18','soiltypes')]
names(test)<-c('OC','ele','tp','tem','NDVI','pm','lc','soiltype')

pred<-predict(rf,test)
mse<-sum((pred-test[['OC']])*(pred-test[['OC']]))/13054

rf2<-randomForest(OC~ele+tp+tem+NDVI+pm+lc+soiltype,
                 ntree=150,
                 mtry=1,
                 data=test)

mse<-sum((rf2[["predicted"]]-test[['OC']])*(rf2[["predicted"]]-test[['OC']]))/13054

temc<-df[,c('ele','tpv09','tem18','NDVI09','pm','lc09','soiltypes')]
names(temc)<-c('ele','tp','tem','NDVI','pm','lc','soiltype')
predtemc<-predict(rf,temc)
mse<-sum((predtemc-test[['OC']])*(predtemc-test[['OC']]))/13054

