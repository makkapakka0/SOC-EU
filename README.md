# SOC-EU
Soil organic carbon loss around the Baltic Sea: data processing, analysis, and plots

R code supporting “Warming could cause significant soil organic carbon loss around the Baltic Sea”.

The code uses 6 environmental variables to model soil organic carbon (SOC) across Europe with Random Forest (RF). The model is interpreted using SHapley Additive exPlanations (SHAP) values to further explore relationships between SOC and its factors, warming effects on SOC, and dominant variable in different regions.

The nc.r is used to pre-process climate data of annual mean temperature and annual precipitation to get the mean values in the last 60 years and mean annual mean temperature in the next 60 years. The SOC.r includes filtering data, training, predicting, interpreting with SHAP, plotting, and exporting data to Arc Pro. The workflow shows more detailed information.

Please note that the code is not built by a professional computer scientist, thus it may not provide the most efficient and clearest way. And some steps are done in Arc Pro as it is much easier in Arc Pro than in Rstudio. I have tried my best to make sure it is understandable. If you find anything to improve (like saving calculation time, making it clearer etc.), please don’t hesitate to contact me.

Workflow:

Data source

•	SOC: LUCAS 2018 (point data, continuous, csv)

•	Annual mean temperature: Copernicus Climate Change Service (C3S) Climate Data Store (CDS) (multidimensional data, continuous, nc)

•	Annual precipitation: Copernicus Climate Change Service (C3S) Climate Data Store (CDS) (multidimensional data, continuous, nc)

•	Elevation: Copernicus DEM (raster data, continuous, tiff)

•	NDVI: Copernicus Global Land Service (raster data, continuous, tiff) 

•	Land cover: Corine Land Cover 2018 (raster data, discrete, tiff)

•	Parent material: European Soil Data Centre (ESDAC) (raster data, discrete, tiff)

Pre-processing:

The annual mean temperature and annual precipitation are nc files which contain multiple layers with a time dimension. They are calculated to get the mean value in the past 60 years. For annual mean temperature, it is also calculated to get the mean value in the next 60 years to further explore the effect of warming on SOC. The NDVI data is calculated in Arc Pro to get the mean value in the past 20 years. All the data is resampled to 1km resolution with projected coordinate system of ETRS 1989 LAEA (EPSG: 3035).

A fishnet of 1km resolution is created in Arc Pro. It is used to extract value of the variables for prediction and mapping later.

Analysis

Random Forest: 

Here we use RF to model SOC with the six variables. As our study doesn’t focus on predicting SOC but exploring the relationships between SOC and its factors, we don’t actually need the best parameters. Suitable parameters saving calculation time and providing reasonable results fit for our study. The parameters are selected by comparing the Out of Bag Mean Squared Error (OOB MSE). The model is finally trained with parameters of ntree = 150, mtry = 1, and other parameters remain default. This can provide sufficiently accurate results that will be used in further analysis.

Training the model using 18742 SOC observations and the variables.

Predicting SOC in 2018 using about 4,200,000 samples, na value is removed and data that is not shown in training is also removed in predicting, for example, the highest elevation in the training data is 2077m, thus locations above 2077m in predicting data are removed; Some land covers and parent materials that are not shown in training data are also removed.

Predicting SOC in 2080 using predicted annual mean temperature data in the next 60 years.

SHAP value

Calculating the overall SHAP value for the variables using training data.

Calculating the SHAP value for each variable of each sample.

Plotting the SHAP value and fitting the scatters with a smooth curve. Land cover and parent material are shown using boxplot.

Calculating the SHAP value for each variable of each sample in predicting data. As the calculations are massive, we have to divide the data into 5 groups and calculate them respectively. By setting the baseline to 0, it will not influence the results.

Comparing the SHAP values of different variable at each location and labelling the highest one.

Mapping

Combining the variables of prediction, predicted SOC in 2018, predicted SOC in 2080, SHAP values, and the SOC difference between 2018 and 2080. Exporting the dataframe as a shapefile. Then go to GIS.

Software and packages:

•	R 4.3.1

•	Rstudio

•	ncdf4 1.21

•	rgdal 1.6-7

•	randomForest 4.7-1.1

•	raster 3.6-23

•	iml 0.11.1

•	fastshap 0.1.0

•	tidyr 1.3.0

•	ggpolt2 3.4.3

•	ggbeeswarm 0.7.2

•	dplyr 1.1.3

•	writexl 1.4.2








