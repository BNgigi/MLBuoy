# MLBuoy

Muskegon Lake Buoy

## Introduction

Grand Valley State University's Robert B. Annis Water Resources Institute established a buoy-based observatory in Muskegon Lake in 2010. The Muskegon Lake Buoy is an important tool for monitoring the conditions of the lake and providing valuable information about the environment. It provides current conditions and historic data of Muskegon Lake in Muskegon County, Michigan going back to 2011, enabling researchers and stakeholders to gain a comprehensive understanding of the lake's ecosystem over time. 

To facilitate access and visualization of the data, we developed an R Package called MLBuoy that uses the Muskegon Lake Buoy API to provide users with an efficient way to access and analyze data from the Muskegon Lake Buoy.

## Description
Here-below is overview of the main functions:-

| Function | Description |
|----------|----------|
| fetch_buoy_data | Obtains data on current and historical conditions of Muskegon Lake in Muskegon County, Michigan from the Muskegon Lake Buoy API. |
| plot_buoy_data | Offers a simple method to visualize data obtained from Muskegon Lake Buoy. |

## Installation of the package

    # Install devtools package if needed
    if(!("devtools" %in% installed.packages())) {
    install.packages("devtools")
    }

    # Install MLBuoy package from GitHub
    devtools::install_github("https://github.com/BNgigi/MLBuoy")

## Example

For a detailed description for implementing the MLBuoy Package, see this [Package Vignette](https://rpubs.com/BNgigi/1010794)
