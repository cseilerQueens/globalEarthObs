.libPaths("/home/cseiler/projects/def-cseiler-ab/cseiler/globEarthObs/renv/library/R-4.3/x86_64-pc-linux-gnu")

setwd("/home/cseiler/projects/def-cseiler-ab/cseiler/globEarthObs/LST/MODIS")
library(raster)
library(ncdf4)

classic <- raster::stack("/home/cseiler/projects/def-cseiler-ab/cseiler/data-assimilation/simulations/transient_CRUJRAv2.4.5_2022/netcdf_files/ts_monthly.nc")
modis <- raster::stack("MOYD11C3_128x64.nc")

leo <- raster::stack("/home/cseiler/projects/def-cseiler-ab/cseiler/reference/LEOLSTCMG30/LEOLSTCMG30v02_128x64.nc")

# era: 1980-01
# leo: 2002-08
# esa: 1996-01
# classic: 1970-01

# let's compare 2005-01 to 2009-12
first <- 421
last <- first + 59
classic <- subset(classic, first:last)


first <- 31
last <- first + 59
modis <- subset(modis, first:last)

first <- 30
last <- first + 59
leo <- subset(leo, first:last)

classic <- raster::rotate(classic)
classic <- mean(classic)

modis <- mean(modis)
leo <- mean(leo)

png("compare.png", width = 6, height = 5, units = "in", res = 300)
plot(classic - modis)
dev.off()

png("compare_classic_leo.png", width = 6, height = 5, units = "in", res = 300)
plot(classic - leo)
dev.off()


png("compare_hist.png", width = 6, height = 5, units = "in", res = 300)
hist(classic-modis)
dev.off()
