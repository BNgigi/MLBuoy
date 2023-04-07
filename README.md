# MLBuoy
Muskegon Lake Buoy

## Description

Grand Valley State University's Robert B. Annis Water Resources Institute established a buoy-based observatory in Muskegon Lake in 2010. The Muskegon Lake Buoy is an important tool for monitoring the conditions of the lake and providing valuable information about the environment. It provides current conditions and historic data of Muskegon Lake in Muskegon County, Michigan going back to 2011, enabling researchers and stakeholders to gain a comprehensive understanding of the lake's ecosystem over time.


To facilitate access and visualization of the data, we developed an R Package called MLBuoy that uses the Muskegon Lake Buoy API to provide users with an efficient way to access and visualize data from the Muskegon Lake Buoy.

## Overview of the package's functions

| Function | Description |
|----------|----------|
| fetch_buoy_data | Extracts and obtains data on current and historical conditions of Muskegon Lake in Muskegon County, Michigan from the Muskegon Lake Buoy API. |
| plot_buoy_data | Retrieves and extracts data from the Muskegon Lake Buoy through the use of an Application Programming Interface (API). The raw data is then transformed into an easy-to-read and visually appealing graph, facilitating comprehension and analysis. |


## Installation

Install the package from [GitHub](https://github.com/) using the code below:


```{r}
if("devtools" %in% installed.packages() == FALSE) {
    install.packages("devtools")
}

devtools::install_github("BNgigi/MLBuoy")
```

## Example

The function fetch_buoy_data makes use of several parameters including x, y, start_date, end_date, time, and calculation. On the other hand, the function plot_buoy_data uses x, y, start_date, end_date, and graph_type as its parameters. For additional information regarding these parameters, please refer to [Package Vignette](https://rpubs.com/BNgigi/1010794). It is important to use valid values for these parameters. You can find more details about the supported values by visiting the Grand Valley State University Muskegon Lake Buoy API website at \url{https://www.gvsu.edu/wri/buoy/data-api.htm}.


In the example below, we are utilizing the fetch_buoy_data() function to retrieve data for atmp1, tp001, and tp002 for each day of the week within the time frame of July 7, 2011 to July 28, 2011."

```{r}
# Load the MLBuoy library and the tidyverse package
library(MLBuoy)
library(tidyverse)

# Fetch buoy data with specific parameters
buoyData <- fetch_buoy_data(x="weekday", y="atmp1,tp001,tp002", start_date="7/7/11", end_date="7/28/11")

# Display the first 12 rows of the buoy data in a table format
knitr::kable(head(buoyData, n = 12))
```
| x_weekday| y_atmp1| y_tp001| y_tp002|date       |
|---------:|-------:|-------:|-------:|:----------|
|         5|   68.00|   76.96|   76.96|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |
|         5|   67.46|   77.09|   76.86|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |
|         5|   66.92|   76.96|   76.86|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |
|         5|   66.20|   76.96|   76.86|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |
|         5|      NA|      NA|      NA|0011-07-28 |


In the following example, we will be utilizing the plot_buoy_data function from the MLBuoy library to create different types of visualizations. Specifically, we will be generating a scatter plot, line plot, bar plot, and box plot.

To get started, we need to load the MLBuoy library and the tidyverse package:

```{r}
# Load the MLBuoy library and the tidyverse package
library(MLBuoy)
library(tidyverse)
```

Next, we will generate a scatter plot using the plot_buoy_data function. The x parameter is set to "weekday" and the y parameter is set to "rh1", representing the weekday and relative humidity variables, respectively. We also specify the start date as "7/7/11" and the end date as "7/28/11". Lastly, we set graph_type to "scatter" to generate a scatter plot.

```{r}
# Generate a scatter plot of relative humidity vs. time of day
plot_data <- plot_buoy_data(x = "weekday", y = "rh1", start_date = "7/7/11", end_date = "7/28/11", graph_type = "scatter")

# Save the plot as a PNG image
png("scatter_plot.png", width = 800, height = 600, res = 72)
print(plot_data)
dev.off()
```

![ ](scatter_plot.png)

Next, we create a line plot using plot_buoy_data() to visualize the change in relative humidity by air temperature. We specified x = "rh1" and y = "atmp1" and set start_date and end_date to "7/7/11" and "7/28/11", respectively, to limit the data to the specified time period. 

```{r}
# Create a line plot of air temperature (y) by relative humidity (x) between 7/7/11 and 7/28/11
plot_data <- plot_buoy_data(x = "rh1", y = "atmp1", start_date = "7/7/11", end_date = "7/28/11", graph_type = "line")

# Save the plot as a PNG image
png("line_plot.png", width = 800, height = 600, res = 72)
print(plot_data)
dev.off()
```

![ ](line_plot.png)

We can also generate a bar plot by setting graph_type to "bar":

```{r}
# Generate a bar plot of relative humidity vs. weekday
plot_data <- plot_buoy_data(x = "weekday", y = "rh1", start_date = "7/7/11", end_date = "7/28/11", graph_type = "bar")

# Save the plot as a PNG image
png("bar_plot.png", width = 800, height = 600, res = 72)
print(plot_data)
dev.off()
```

![ ](bar_plot.png)

Finally, we can generate a box plot by setting graph_type to "boxplot": 

```{r}
# Generate a box plot of relative humidity vs. weekday
plot_data <- plot_buoy_data(x = "weekday", y = "rh1", start_date = "7/7/11", end_date = "7/28/11", graph_type = "boxplot")

# Save the plot as a PNG image
png("box_plot.png", width = 800, height = 600, res = 72)
print(plot_data)
dev.off()
```

![ ](box_plot.png)

## References
Biddanda, B., S. Kendall, A. Weinke, I. Stone, N. Dugener, and S. Ruberg. Muskegon Lake
Observatory Buoy Data: Muskegon Lake, Michigan, USA: 2011-2022.
(www.gvsu.edu/buoy) Time Series Data accessed: 7 April, 2023.

