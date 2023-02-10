# MLBuoy

Muskegon Lake Buoy

## Introduction

The Muskegon Lake Buoy is an important tool for monitoring the conditions of the lake and providing valuable information about the environment. MLBuoy R Package provides two functions that allow users to easily extract and visualize the data from the Muskegon Lake Buoy through the use of Application Programming Interface (API).

## Description
Here-below is overview of the main functions:-

| Function | Description |
|----------|----------|
| muskegonLakeBuoyData | Retrieves the data from the API and returns it as a data frame |
| muskegonLakeBuoyGraph | Obtains data and creates a visual representation of the data in the form of a graph |

## Installation of the package

    ### Install the devtools package first
    install.packages("devtools")

    ### Then Install the package from GitHub
    devtools::install_github("https://github.com/BNgigi/MLBuoy")

## Example

For a detailed description for implementing the MLBuoy Package, see this [Package Vignette](https://github.com/BNgigi/MLBuoy/blob/main/vignette/MLBuoy%20-%20Vignette.Rmd).
