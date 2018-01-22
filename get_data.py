import numpy as np
import netCDF4

# get data for plotting
filename='/lustre/ARU/Projects/GeogridSensitivity/wrfout_d01_2016-04-08_00_00_00_ThaiGeogrid'
print(filename)
ncfile = netCDF4.Dataset(filename, 'r')
latitude = ncfile.variables['XLAT'][:]
longitude = ncfile.variables['XLONG'][:]
no2_thai  = ncfile.variables['no2'][:]
no_thai  = ncfile.variables['no'][:]
o3_thai  = ncfile.variables['o3'][:]
date_thai = ncfile.variables['Times'][:]

filename='/lustre/ARU/Projects/GeogridSensitivity/wrfout_d01_2016-04-08_00_00_00_USGS'
print(filename)
ncfile = netCDF4.Dataset(filename, 'r')
latitude = ncfile.variables['XLAT'][:]
longitude = ncfile.variables['XLONG'][:]
data_usgs  = ncfile.variables['no2'][:]
no2_usgs  = ncfile.variables['no2'][:]
no_usgs  = ncfile.variables['no'][:]
o3_usgs  = ncfile.variables['o3'][:]
date_usgs = ncfile.variables['Times'][:]

filename='/lustre/ARU/Projects/GeogridSensitivity/wrfout_d01_2016-04-10_00_00_00_MODIS'
print(filename)
ncfile = netCDF4.Dataset(filename, 'r')
latitude = ncfile.variables['XLAT'][:]
longitude = ncfile.variables['XLONG'][:]
no2_mods  = ncfile.variables['no2'][:]
no_mods  = ncfile.variables['no'][:]
o3_mods  = ncfile.variables['o3'][:]
date_mods = ncfile.variables['Times'][:]
