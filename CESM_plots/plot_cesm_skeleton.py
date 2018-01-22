import numpy as np
import netCDF4

filename='/lustre/paul/netcdf/sresa1b_ncar_ccsm3_0_run1_200001.nc'

ncfile = netCDF4.Dataset(filename, 'r')

longitude = ncfile.variables['lat'][:]
latitude = ncfile.variables['lon'][:]
wind = ncfile.variables['ua'][:]
pressure=ncfile.variables['pr'][:]

#reshape to a 2-d array suitable for plotting
new_wind=wind[0,7,:,:]
plt.contour(latitude,longitude,new_wind)
plt.show()
