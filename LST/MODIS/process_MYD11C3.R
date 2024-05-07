.libPaths("/home/cseiler/projects/def-cseiler-ab/cseiler/globEarthObs/renv/library/R-4.3/x86_64-pc-linux-gnu")

setwd("/home/cseiler/projects/def-cseiler-ab/cseiler/globEarthObs/LST/MODIS")
library(terra)
library(ncdf4)

# T63 resolution
r <- terra::rast("../../gpp_monthly.nc")
r <- terra::rotate(r)

# set path and filename
hdf_path <- "/home/cseiler/projects/def-cseiler-ab/cseiler/globEarthObs/LST/MODIS/MYD11C3/e4ftl01.cr.usgs.gov/MOLA/MYD11C3.061"

# Get file names
files <- list.files(hdf_path, pattern = "\\.hdf$", full.names = TRUE, recursive = TRUE)
# files <- files[1:5]

# Define dates
start.date <- "2002-07-01"
timeInt <- "month"
nTime <- length(files)
dates <- base::seq(as.Date(start.date), by = timeInt, length = nTime)

try(rm(raster_list))
raster_list <- list()

for (i in files) {
  
  data <- terra::rast(i)
  day <- subset(data, subset = "LST_Day_CMG")
  night <- subset(data, subset = "LST_Night_CMG")
  daily <- (day + night) / 2
  daily <- terra::resample(daily, r, method='bilinear')
  raster_list[[i]] <- daily
  rm(data, day, night, daily)
  gc()
}

# Make a raster stack and assign the dates
data <- terra::rast(raster_list)
names(data) <- dates
time(data) <- dates

# Save data to netCDF file
terra::writeCDF(x = data, filename = "MYD11C3_128x64.nc", varname = "LST", unit = "K", overwrite=T)
