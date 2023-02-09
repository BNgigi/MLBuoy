rcm
Random Covariance Model

Description
This R package implements a random covariance model (RCM) for joint estimation of multiple sparse precision matrices.

Overview of main functions

Function	Description
randCov	Implements the Random Covariance Model (RCM) for joint estimation of multiple sparse precision matrices. Optimization is conducted using block coordinate descent.
bic_cal	Calculates the BIC for the RCM.
mbic_cal	Calculates the modified BIC for the RCM.
Installation

Install the latest version of the package from GitHub with the following R code:

if("devtools" %in% installed.packages() == FALSE) {
    install.packages("devtools")
}

devtools::install_github("dilernia/rcm")
Example

For a detailed simulation example for implementing the Random Covariance Model (RCM), see this link.
