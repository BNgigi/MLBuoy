# MLBuoy

Muskegon Lake Buoy

## Introduction

The Muskegon Lake Buoy is an important tool for monitoring the conditions of Muskegon Lake and providing valuable information about the environment. The MLBuoy R Package provides functions that facilitate queries from the Muskegon Lake Buoy API directly from within R and create related visualizations as well.

## Description
Here-below is overview of the main functions:-

| Function | Description |
|----------|----------|
| fetch_buoy_data | Retrieves the data from the API and returns it as a data frame |
| plot_buoy_data | Obtains data and creates a its visual representation in the form of a graph |

## Installation of the package

    ### Install the devtools package first
    install.packages("devtools")

    ### Then install MLBuoy package from GitHub as follows
    devtools::install_github("https://github.com/BNgigi/MLBuoy")

## Example

For a detailed description for implementing the MLBuoy Package, see this [Package Vignette](https://github.com/BNgigi/MLBuoy/blob/main/vignette/MLBuoy---Vignette.html)
