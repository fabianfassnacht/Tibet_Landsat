require(raster)
require(rgdal)

#########################################################
######## calculate NDVI differences for 1986-1999
#########################################################

######
## Tile 01
######

setwd("I:/1_Inputs_Landsat_GEE/1")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/1", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s
plot(ndvi_diff)

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T01.tif", format="GTiff")


######
## Tile 01
######


setwd("I:/1_Inputs_Landsat_GEE/2")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/2", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T02.tif", format="GTiff")


######
## Tile 03
######


setwd("I:/1_Inputs_Landsat_GEE/3")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/3", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T03.tif", format="GTiff")


######
## Tile 04
######


setwd("I:/1_Inputs_Landsat_GEE/4")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/4", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T04.tif", format="GTiff")

######
## Tile 05
######


setwd("I:/1_Inputs_Landsat_GEE/5")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/5", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T05.tif", format="GTiff")


######
## Tile 06
######


setwd("I:/1_Inputs_Landsat_GEE/6")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/6", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T06.tif", format="GTiff")


######
## Tile 07
######


setwd("I:/1_Inputs_Landsat_GEE/7")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/7", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T07.tif", format="GTiff")


######
## Tile 05
######


setwd("I:/1_Inputs_Landsat_GEE/8")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/8", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T08.tif", format="GTiff")


######
## Tile 05
######


setwd("I:/1_Inputs_Landsat_GEE/9")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/9", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T09.tif", format="GTiff")


######
## Tile 05
######


setwd("I:/1_Inputs_Landsat_GEE/10")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/10", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T10.tif", format="GTiff")


######
## Tile 11
######


setwd("I:/1_Inputs_Landsat_GEE/11")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/11", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T11.tif", format="GTiff")



######
## Tile 12
######


setwd("I:/1_Inputs_Landsat_GEE/12")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/12", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T12.tif", format="GTiff")


######
## Tile 13
######


setwd("I:/1_Inputs_Landsat_GEE/13")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/13", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T13.tif", format="GTiff")


######
## Tile 14
######


setwd("I:/1_Inputs_Landsat_GEE/14")

fils_01 <- list.files("I:/1_Inputs_Landsat_GEE/14", pattern=".tif$", full.names = T)
ls_01 <- stack(fils_01)

ls_01_s <- mean(ls_01[[1:3]], na.rm=TRUE)
ls_01_e <- mean(ls_01[[(nlayers(ls_01)-19):(nlayers(ls_01)-17)]], na.rm=TRUE)

ndvi_diff <- ls_01_e - ls_01_s

setwd("I:/2_Outputs_Landsat_Christopher/NDVI_change_1986_1999")
writeRaster(ndvi_diff, filename = "NDVI_diff_1986_1999_T14.tif", format="GTiff")
