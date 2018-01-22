import pylab as plt
import numpy as np
from mpl_toolkits.basemap import Basemap, shiftgrid

def plot_data(lat, lon, data_1,data_2,data_3,levels,outfile):
  plt.figure(figsize=(16,8), dpi=200)
  plt.subplot(1,3,1)
## create a new instance of the basemap class for plotting
  map = Basemap(projection='cyl', llcrnrlat=3.0, llcrnrlon=93.0, urcrnrlat=22.0, urcrnrlon=107.0)
  map.drawcoastlines()
## need to make a meshgrid of lats and lons for use in Basemap
  lonx, laty = np.meshgrid(lon, lat)
  x, y = map(lonx, laty)
## can now plot
  cs = map.contourf(x,y,data_1,levels)
  plt.colorbar(fraction=0.046, pad=0.04)
  city_hall_lat = 18.84
  city_hall_lon = 98.98
  map.plot(city_hall_lon, city_hall_lat, 'bo', markersize=12)
  plt.title('Thai')

  plt.subplot(1,3,2)
## create a new instance of the basemap class for plotting
  map = Basemap(projection='cyl', llcrnrlat=3.0, llcrnrlon=93.0, urcrnrlat=22.0, urcrnrlon=107.0)
  map.drawcoastlines()
## can now plot
  cs = map.contourf(x,y,data_2,levels)
  plt.colorbar(fraction=0.046, pad=0.04)
  map.plot(city_hall_lon, city_hall_lat, 'bo', markersize=12)
  plt.title('USGS')

  plt.subplot(1,3,3)
## create a new instance of the basemap class for plotting
  map = Basemap(projection='cyl', llcrnrlat=3.0, llcrnrlon=93.0, urcrnrlat=22.0, urcrnrlon=107.0)
  map.drawcoastlines()
  cs = map.contourf(x,y,data_3,levels)
  plt.colorbar(fraction=0.046, pad=0.04)
  map.plot(city_hall_lon, city_hall_lat, 'bo', markersize=12)
  plt.title('MODIS')
  plt.savefig(outfile)

lat=latitude[0,:,0]
lon = longitude[0,0,:]

print(date_thai[:][95+6])
print(date_usgs[:][95+6])
print(date_mods[:][47+6])


levels=np.arange(0,0.22,0.02)
plot_data(\
    lat,\
    lon,\
    o3_thai[101,0,:,:],\
    o3_usgs[101,0,:,:],\
    o3_mods[53,0,:,:],\
    levels,\
    'o3.png'\
    )

levels=np.arange(0,0.022,0.002)/5
plot_data(\
    lat,\
    lon,\
    no_thai[101,0,:,:],\
    no_usgs[101,0,:,:],\
    no_mods[53,0,:,:],\
    levels,\
    'no.png'\
    )

levels=np.arange(0,0.22,0.02)/10
plot_data(\
    lat,\
    lon,\
    no2_thai[101,0,:,:],\
    no2_usgs[101,0,:,:],\
    no2_mods[53,0,:,:],\
    levels,\
    'no2.png'\
    )
