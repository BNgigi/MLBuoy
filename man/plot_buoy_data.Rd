% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MLBuoy.R
\name{plot_buoy_data}
\alias{plot_buoy_data}
\title{Plot Muskegon Lake Buoy Data}
\usage{
plot_buoy_data(
  x = "date",
  y = NULL,
  start_date = "10/01/2022",
  end_date = "10/31/2022",
  graph_type
)
}
\arguments{
\item{x}{The values to be plotted on the x-axis of the graph.
If no value is specified, date will be used as the default.}

\item{y}{The values to be used on the y-axis of the graph.
Multiple y values should be separated by a comma.}

\item{start_date}{A specific date in time that marks the beginning of a particular period.
Date values must be in the format MM/DD/YYYY or M/D/YY.
The default value is 10/01/2022.}

\item{end_date}{A specific date in time that marks the end of a particular period.
Values must be in the format MM/DD/YYYY or M/D/YY.
The default date is 10/31/2022.}

\item{graph_type}{The type of chart to be plotted.
The supported types are scatter, line, bar, and boxplot.}
}
\value{
A graph of x values by y values
}
\description{
This function offers a simple method to visualize data from Muskegon Lake in Muskegon County, Michigan from the Muskegon Lake Buoy API.
Grand Valley State University's Robert B. Annis Water Resources Institute (AWRI) established the buoy-based observatory in 2010. More information on the Muskegon Lake Buoy is available on the AWRI website: \url{https://www.gvsu.edu/wri/buoy/}.
The API documentation is available at \url{https://www.gvsu.edu/wri/buoy/data-api.htm}.
}
\details{
The arguments for x and y must be supported values. More information can be found at Grand Valley State University Muskegon Lake Buoy API website: \url{https://www.gvsu.edu/wri/buoy/data-api.htm}
}
\examples{
plot_buoy_data(x="weekday",y="rh1", graph_type="line")
}
\author{
Beatrice Ngigi

Prof. Andrew DiLernia
}
