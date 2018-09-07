###### complete calculation for median, polygon x

require("rgdal")
require(stinepack)
require(forecast)
require(Rcpp)
require(imputeTS)
require(SparseM)
require(coda)
require(gtools)
require(MatrixModels)
require(mcmc)
require(MCMCpack)
require(quantreg)
require(HKprocess)
require(changepoint)
.libPaths("/home/kit/ifgg/cq4398/R/3.3.1")
require(raster)
require(matrixStats)
require(foreach)
require(doParallel)
require(trend)
require("trend")
require(extraDistr)


##### step 1: calculate 100 small matrices from the 31 tif-files


# change directory to folder which contains all Landsat NDVI files
# x indicated the number of the file
setwd("/path_to_landsat_ndvi_mosaics/x")
# get file names of individual Landsat NDVI files
fils <- list.files("/path_to_landsat_ndvi_mosaics/x", pattern=".tif")

# stack all NDVI bands of the 31 years into one raster stack
nd_st_f2 <- stack(fils)


# convert raster dataset to numeric matrix
nd_st_f_out <- as.matrix(nd_st_f2)

# divide the matrix into 100 small matrices of the same length
l <- length(nd_st_f_out[,1])
step <- floor(length(nd_st_f_out[,1])/100)
iter <- seq(1, l, step)


for(i in 1:100){
  nd_out <- nd_st_f_out[iter[i]:(iter[i+1]-1),]
  save(nd_out, file = paste("ts_1986_2016_median_test_mat", i, ".RData", sep=""))

}

# matrix number 101 contains the rest of the pixels
nd_out <- nd_st_f_out[(iter[101]):(nrow(nd_st_f_out)),]
save(nd_out, file = paste("ts_1986_2016_median_test_mat", 101, ".RData", sep=""))






##### step 2: calculate mk trend test for all the small matrices

# change directory to folder which contains all the small matrices
setwd("/path_to_landsat_ndvi_mosaics/x")

# load matrices:
fils <- list.files("/path_to_landsat_ndvi_mosaics/x", pattern=".RData")
# matrix is referred to as nd_out

# Number of cpu cores that should be used
ncors <- 30

# setup parallel backend to use ncors processors
cl<-makeCluster(ncors)
registerDoParallel(cl)


# use foreach and doParallel packages
foreach(c = 1:length(fils), .packages=c("raster", "matrixStats", "imputeTS", "HKprocess", "changepoint")) %dopar%
{

  # set working directory:
  setwd("/path_to_landsat_ndvi_mosaics/x")

  # load respective matrix
  load(fils[[c]])

  # initialize a matrix which is overwritten in each iteration with one row and six columns
  # and store it in "res"
  res <- matrix(NA, nrow=nrow(nd_out), ncol=9)
  # initialize matrix for pettitt test:
  nd_out1 <- matrix(NA, nrow=nrow(nd_out), ncol=ncol(nd_out))
  # prerequisite for pettitt test:
  # perform linear interpolation for all of the rows which actually have values other than NA


  # for-loop to get through the respective matrix:
  for (i in 1:nrow(nd_out))
  {
    # nd_out_count counts the number of entries other than NA
    nd_out_count <- sum(!is.na(nd_out[i,]))
    res[i, 6] <- nd_out_count
    
    # calculate the row medians
    res[i, 7] <- median(nd_out[i, ], na.rm=TRUE)
    
    # na.interpolation is only necessary for pettitt-test, because the output year is only interpretable if we know
    # that the time series is complete; otherwise we would have to know the places of missing values for each pixel
    # function na.interpolation needs a minimum of two non-NA values, 
    # so that is checked in the if statement as well 
    # - if there are less, nothing is done
    if ((all(is.na(nd_out[i,]))==FALSE) && (nd_out_count > 1))
     {
        nd_out1[i,] <- na.interpolation(nd_out[i,], option="spline")
     }  
    
  
    # examine whether more than 5 entries of the NDVI-pixel time series have a valid value
    # if yes perform the mann-kendall trend test
    if (length(na.omit(nd_out[i,])) > 5)

      # calculate mann-kendall trend test and store the object created by the test in the
      # variable "data"
      {
        data <- MannKendallLTP(na.omit(nd_out[i, ]))
        # pettitt test:
        pt <- pettitt.test(na.omit(nd_out1[i,]))
        # the number of the year is stored in the 8th column of res, the p-value for it in the 9th one:
        res[i, 8] <- pt$estimate[1]
        res[i, 9] <- pt$p.value
        # tau:
        res[i, 1] <- data$Mann_Kendall[1]
        # p-value:
        res[i, 2] <- data$Mann_Kendall[6]
        # p-value of Hurst parameter test:
        res[i, 3] <- data$Significance_of_H[2]
        # p-value under scaling hypothesis:
        res[i, 4] <- data$Mann_Kendall_LTP[2]
        # significant trend?
        # =1 if significant, =0 if not
        # see also Hamed et al. (2017): 
        # "An R function for the estimation of trend significance under the scaling hypothesisapplication in PET parametric annual time series"
        # for explanation of the following steps
        if (res[i,2] < 0.05)
        {
          if (res[i,3] > 0.05)
          {
            res[i,5] <- 1
          }
          else
          {
            if (res[i, 4] < 0.05)
            {
              res[i,5] <- 1
            }
            else
            {
              res[i,5] <- 0
            }
          }
        }
          else
          {
            res[i,5] <- 0
          }
    }
    else
    # if MK-test is not calculated, save a -9999 for this cell:
    {
      res[i,1] <- -9999
      res[i,2] <- -9999
      res[i,3] <- -9999
      res[i,4] <- -9999
      res[i,5] <- -9999
    }
  }

  setwd("/path_to_landsat_ndvi_mosaics/x/mkTrend/HK")
  save(res, file = paste("HKprocess_", fils[[c]]))
  # matrix is called "res"
}



##### step 3: combine the 100 small matrices to one big matrix


# set working directory:
setwd("/path_to_landsat_ndvi_mosaics/x/mkTrend/HK")


# load list of matrices
fils <- list.files("/path_to_landsat_ndvi_mosaics/x/mkTrend/HK", pattern=".RData")
# matrix is referred to as "res"

# initialize empty matrix
median_mat <- matrix(nrow=0, ncol=9)

# attention: correct order is important!
for (i in 1:length(fils))
{
  # filter only the matrix with the respective number "i"
  fils2 <- list.files("/path_to_landsat_ndvi_mosaics/x/mkTrend/HK", pattern=paste("mat", i, ".RData", sep=""))
  load(fils2[[1]])
  # matrix is referred to as "res"
  # bind to empty (or pre-computed) matrix
  median_mat <- rbind(median_mat, res)
}

# save combined matrix
save(median_mat, file="Bound_HKprocess_median_1986_2016_poly1_mat.RData")
# Matrix is referred to as "median_mat"




##### step 4: calculate .tif-files from big matrix

# set working directory to get the combined big matrix
setwd("/path_to_landsat_ndvi_mosaics/x")

# load a raster file which has the same coordinates/pixels as the big matrix called "median_mat"
nd_st_f2 <- stack("pval_mask_med_poly1_HKprocess_1986_1999.tif")


# change work directory to store results
setwd("/path_to_landsat_ndvi_mosaics/x/mkTrend/HK")


# take a single band of the raster file
p_vals <- nd_st_f2[[1]]


load("Bound_HKprocess_median_1986_2016_poly1_mat.RData")
# matrix is referred to as median_mat

# check if length of the two files that are to be merged actually match
length(p_vals)
nrow(median_mat)

# add correct number of rows automatically!
diff <- length(p_vals) - nrow(median_mat)
blind <- matrix(NA, nrow=diff, ncol=9)
median_mat <- rbind(median_mat, blind)

# check if length of the two files that are to be merged actually match
nrow(median_mat)
length(p_vals)


# overwrite the values in the raster file with the results stored in the data matrix
values(p_vals) <- median_mat[,5]
# write the results into a new rasterfile which contains the results of the trend test
# in this case the corrected p-values
writeRaster(p_vals, filename = "pvals_med_poly1_HKprocess_1986_2016.tif", format="GTiff", overwrite=T)

# create a mask from the p-values raster by identifying all pixels that have a p-value of smaller
# than 0.05 and hence indicate a statistically significant trend.
p_mask <- p_vals < 1
writeRaster(p_mask, filename = "pval_mask_med_poly1_HKprocess_1986_2016.tif", format="GTiff", overwrite=T)


# take a single band of the raster file
tau_vals <- nd_st_f2[[1]]
# use tau values for further analysis without p_vals mask
values(tau_vals) <- median_mat[,1]
writeRaster(tau_vals, filename = "tau_med_poly1_HKprocess_1986_2016.tif", format="GTiff", overwrite=T)

tau_vals_mask <- mask(tau_vals, p_mask, maskvalue=0, updatevalue=NA)
writeRaster(tau_vals_mask, filename = "tau_masked_med_poly1_HKprocess_1986_2016.tif", format="GTiff", overwrite=T)



### save pettitt test results:
# take a single band of the raster file
pettitt_vals <- nd_st_f2[[1]]
# overwrite the values with pettitt test estimates of changepoint
values(pettitt_vals) <- median_mat[,8]
writeRaster(pettitt_vals, filename = "Changepoint_med_poly1_1986_2016.tif", format="GTiff", overwrite=T)

# save p-values of pettitt test:
pettitt_p_vals <- nd_st_f2[[1]]
values(pettitt_p_vals) <- median_mat[,9]
writeRaster(pettitt_p_vals, filename = "Changepoint_p_val_med_poly1_1986_2016.tif", format="GTiff", overwrite=T)



# step 5: mask it

setwd("/path_to_landsat_ndvi_mosaics/x/mkTrend/HK")

# ndvi_mask will mask all the values of median NDVIs smaller than or equal to 0.1
ndvi_mask <- nd_st_f2[[1]]
nd_med <- median_mat[,7] > 0.1
values(ndvi_mask) <- nd_med

# load raster as saved above
setwd("/path_to_landsat_ndvi_mosaics/x/mkTrend/HK")
tau_vals_mask_wo_ndvi <- raster("tau_masked_med_poly1_HKprocess_1986_2016.tif")

# mask the raster and save it
tau_vals_mask_ndvi <- mask(tau_vals_mask_wo_ndvi, ndvi_mask, maskvalue=0, updatevalue=NA)
writeRaster(tau_vals_mask_ndvi, filename = "tau_masked_w_ndvi_med_poly1_HKprocess_1986_2016.tif", format="GTiff")

# create a raster containing the number of data entries of the time series
rowsums <- nd_st_f2[[1]]
values(rowsums) <- median_mat[,6]
writeRaster(rowsums, filename = "Rowsums_med_poly1_HKprocess_1986_2016.tif", format="GTiff", overwrite=T)



##### end of script #####










