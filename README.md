# MLBuoy
Muskegon Lake Buoy

---
title: "MLBuoy"
output: 
  html_document:
    code_folding: show
    theme:
      bg: "#202123"
      fg: "#B8BCC2"
      primary: "#EA80FC"
      secondary: "#00DAC6"
      base_font:
        google: Prompt
      heading_font:
        google: Proza Libre
---

```{r setup, include=FALSE}
if (requireNamespace("thematic")) 
  thematic::thematic_rmd(font = "auto")
```

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

In the example here-in, we are utilizing plot_buoy_data to create visualizations of the relationship between weekday and rh1 from July 7, 2011 to July 28, 2011, using different types of graphs.

```{r}
# Load necessary libraries
library(tidyverse)
library(MLBuoy)

# Plot a scatter plot of relative humidity (y) by weekday (x) between 7/7/11 and 7/28/11
plot_buoy_data (x="weekday", y="rh1", start_date="7/7/11", end_date="7/28/11", graph_type="scatter")

# Plot a line plot of relative humidity (y) by weekday (x) between 7/7/11 and 7/28/11
plot_buoy_data (x="weekday", y="rh1", start_date="7/7/11", end_date="7/28/11", graph_type="line")

# Plot a bar plot of relative humidity (y) by weekday (x) between 7/7/11 and 7/28/11
plot_buoy_data (x="weekday", y="rh1", start_date="7/7/11", end_date="7/28/11", graph_type="bar")

# plot a boxplot of relative humidity (y) by weekday (x) between 7/7/11 and 7/28/11
plot_buoy_data (x="weekday", y="rh1", start_date="7/7/11", end_date="7/28/11", graph_type="boxplot")
```
