module load cdo/2.2.2

cdo showdate MOD11C3_128x64.nc
cdo showdate MYD11C3_128x64.nc

cdo seldate,2002-07-01,2024-03-01 MOD11C3_128x64.nc tmp01.nc
# cdo seldate,2002-07-01,2024-03-01 MYD11C3_128x64.nc  tmp02.nc

cdo ensmean tmp01.nc MYD11C3_128x64.nc MOYD11C3_128x64.nc

rm tmp01.nc
