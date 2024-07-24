library(ncdf4)
library(raster)
library(rgdal)
library(ggplot2)

nc_data<-nc_open('D:\\2paper\\working\\pre.nc')
nc_data<-nc_open('D:\\2009\\tem.nc')


keep<-c(1:3)

lon<-ncvar_get(nc_data,nc_data[["dim"]][["longitude"]])
lat<-ncvar_get(nc_data,nc_data[["dim"]][["latitude"]])
t<-ncvar_get(nc_data,nc_data[["dim"]][["time"]])
tem<-ncvar_get(nc_data,nc_data[["var"]][["BIO01"]])
tp<-ncvar_get(nc_data,nc_data[["var"]][["BIO12"]])

tem<-tem[ , ,keep]
tp<-tp[ , ,keep]

tem<-apply(tem,2:1,mean,drop=FALSE)
tp<-apply(tp,2:1,mean,drop=FALSE)

print(lon)
print(lat)
extent<-extent(c(-29.99583,49.99583,32.00417,71.99583))
rotated_mat <- t(tem[, ncol(tem):1])
rotated_mat <- t(tp[, ncol(tp):1])
rotated_mat<- t(rotated_mat[, ncol(rotated_mat):1])
flipped_mat <- rotated_mat[, ncol(rotated_mat):1]
raster_data<-raster(flipped_mat,xmn=extent[1],xmx=extent[2],ymn=extent[3],ymx=extent[4])


crs(raster_data) <- '+proj=longlat +datum=WGS84'
writeRaster(raster_data,filename='D:\\2paper\\working\\tp.tif',format='GTiff',
            options=c('TFW=YES'),overwrite = TRUE)

spplot(raster_data)


