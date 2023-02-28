# MLBuoy

Muskegon Lake Buoy

## Introduction

Grand Valley State University's Robert B. Annis Water Resources Institute (AWRI) established a buoy-based observatory in Muskegon Lake in 2010. The Muskegon Lake Buoy is an important tool for monitoring the conditions of the lake and providing valuable information about the environment. It provides current conditions and historic data of Muskegon Lake in Muskegon County, Michigan going back to 2011, enabling researchers and stakeholders to gain a comprehensive understanding of the lake's ecosystem over time. 

In order to facilitate ease of extraction and visualization of the data, we developed an R Package called MLBuoy that utilizes an Application Programming Interface (API) to provide users with an efficient way to access and work with the data from the Muskegon Lake Buoy. The R Package includes various functions and tools that enable users to easily extract, manipulate, and visualize the data, allowing for in-depth analysis and insights. By utilizing an API, the MLBuoy package makes it simple for users to access and use the data in their own applications, software, and workflows.

## Description
Here-below is overview of the main functions:-

| Function | Description |
|----------|----------|
| fetch_buoy_data | Obtains data on current and historical conditions of Muskegon Lake in Muskegon County, Michigan from the Muskegon Lake Buoy API. |
| plot_buoy_data | Offers a simple method to visualize data obtained from Muskegon Lake Buoy. |

## Installation of the package

    ### Install the devtools package first
    install.packages("devtools")

    ### Then install MLBuoy package from GitHub as follows
    devtools::install_github("https://github.com/BNgigi/MLBuoy")

## Example

For a detailed description for implementing the MLBuoy Package, see this [Package Vignette](https://github.com/BNgigi/MLBuoy/tree/main/vignette)
