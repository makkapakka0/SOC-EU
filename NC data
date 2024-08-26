library(ncdf4)
library(raster)
library(rgdal)
library(ggplot2)

#read nc files
nc_data1<-nc_open('D:\\2paper\\working\\tem.nc')
nc_data2<-nc_open('D:\\2paper\\working\\tp.nc')

#current
keep1<-c(1:3)

#future
keep2<-c(4:6)

#extract temperature and precipitation
lon<-ncvar_get(nc_data,nc_data[["dim"]][["longitude"]])
lat<-ncvar_get(nc_data,nc_data[["dim"]][["latitude"]])
t<-ncvar_get(nc_data,nc_data[["dim"]][["time"]])
tem<-ncvar_get(nc_data1,nc_data[["var"]][["BIO01"]])
tp<-ncvar_get(nc_data2,nc_data[["var"]][["BIO12"]])

#current
tem<-tem[ , ,keep1]

#get mean value
tem<-apply(tem,2:1,mean,drop=FALSE)

#save as raster data
print(lon)
print(lat)
extent<-extent(c(-29.99583,49.99583,32.00417,71.99583))
rotated_mat <- t(tem[, ncol(tem):1])
rotated_mat<- t(rotated_mat[, ncol(rotated_mat):1])
flipped_mat <- rotated_mat[, ncol(rotated_mat):1]
raster_data<-raster(flipped_mat,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])

#plot
spplot(raster_data)

#save
crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\tem.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)

#precipitation
tp<-tp[ , ,keep1]

tp<-apply(tp,2:1,mean,drop=FALSE)

rotated_mat <- t(tp[, ncol(tp):1])

rotated_mat<- t(rotated_mat[, ncol(rotated_mat):1])
flipped_mat <- rotated_mat[, ncol(rotated_mat):1]
raster_data<-raster(flipped_mat,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])

spplot(raster_data)

crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\tp.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)

#future
tem<-tem[ , ,keep2]

#get mean value
tem<-apply(tem,2:1,mean,drop=FALSE)

#save as raster data
print(lon)
print(lat)
extent<-extent(c(-29.99583,49.99583,32.00417,71.99583))
rotated_mat <- t(tem[, ncol(tem):1])
rotated_mat<- t(rotated_mat[, ncol(rotated_mat):1])
flipped_mat <- rotated_mat[, ncol(rotated_mat):1]
raster_data<-raster(flipped_mat,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])

#plot
spplot(raster_data)

#save
crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\temf.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)
