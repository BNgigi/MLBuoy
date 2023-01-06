#' @import tidyverse
#' @import ggplot2

#' @title Muskegon Lake Buoy Data
#' @name muskegonLakeBuoyData
#' @description Extracts the Muskegon Lake Buoy Data
#' @export
muskegonLakeBuoyData <- function(x = NULL, y, date = NULL, time = NULL,
                                 concentration = NULL, calculation = NULL) {
  # Creating a named vector of inputs
  inputs <- c( x = x, y = y, date = date, time = time,
               concentration = concentration, calculation = calculation)
  # Constructing URL for API query
  baseURL <- "http://www.gvsu.edu/wri/buoy/data-generate.htm?"
  URL <- paste0(baseURL, paste(paste0(names(inputs), "=", inputs), collapse = "&"), "&format=csv")
  # Fetching data from API
  buoyData <- read.csv(URL)

  return(buoyData)
}

#' @title Y Variable parameters
#' @name get_y_vars
#' @description Creating y's dictionary
#' @export
get_y_vars <- function(){
  y_vars <- c(atmp1 = "Air Temp °F (above surface)",
              atmp1min = "Minimum Air Temperature (Long term since 2011) °F (above surface)",
              tp001 = "Water Temp °F (2m)",
              atmp1max = "Maximum Air Temperature (Long term since 2011) °F (above surface)",
              tp002 = "Water Temp °F (4m)",
              tp003 = "Water Temp °F (6m)",
              tp004 = "Water Temp °F (7m)",
              tp005 = "Water Temp °F (9m)",
              tp006 = "Water Temp °F (11m)",
              rh1 = "Relative Humidity % (above surface)",
              baro1 = "Relative Barometric Pressure in Hg (above surface)",
              wspd1 = "Wind Speed knots (above surface)",
              gust1 = "Wind Gust knots (above surface)",
              wdir1 = "Wind Direction degrees (above surface)",
              raincumulative = "Rain, Cumulative inches (above surface)",
              raincurrent = "Rain, Currently inches (above surface)",
              par001 = "PAR (1m)",
              nit001 = "Nitrate mg/L (2m)",
              spcond001 = "Specific Conductivity µs/cm (2m)",
              spcond002 = "Specific Conductivity µs/cm (5m)",
              spcond003 = "Specific Conductivity µs/cm (8m)",
              spcond004 = "Specific Conductivity µs/cm (11m)",
              clcon001 = "Chlorophyll µg/L (2m)",
              phyco001 = "Phycocyanin Cells/mL (2m)",
              cdom001 = "CDOM µg/L (2m)",
              ph001 = "pH (2m)",
              ph002 = "pH (5m)",
              ph003 = "pH (8m)",
              ph004 = "pH (11m)",
              turb001 = "Turbidity NTU (2m)",
              o2perc001 = "Dissolved Oxygen Saturation % (2m)",
              o2perc002 = "Dissolved Oxygen Saturation % (5m)",
              o2perc003 = "Dissolved Oxygen Saturation % (8m)",
              o2perc004 = "Dissolved Oxygen Saturation % (11m)",
              odo001 = "Dissolved Oxygen mg/L (2m)",
              odo002 = "Dissolved Oxygen mg/L (5m)",
              odo003 = "Dissolved Oxygen mg/L (8m)",
              odo004 = "Dissolved Oxygen mg/L (11m)")
}
#' @title X Variable parameters
#' @name get_x_vars
#' @description Creating x's dictionary
#' @export
get_x_vars <- function(){
  x_vars <- c(date = "Date",
              julian = "Julian Day",
              yearday = "Day of Year",
              yearweek = "Week of Year",
              yearmonth = "Month of Year",
              weekday = "Day of Week",
              dayhour = "Hour of Day",
              atmp1 = "Air Temp °F (above surface)",
              tp001 = "Water Temp °F (2m)",
              tp002 = "Water Temp °F (4m)",
              tp003 = "Water Temp °F (6m)",
              tp004 = "Water Temp °F (7m)",
              tp005 = "Water Temp °F (9m)",
              tp006 = "Water Temp °F (11m)",
              rh1 = "Relative Humidity % (above surface)",
              baro1 = "Relative Barometric Pressure in Hg (above surface)",
              wspd1 = "Wind Speed knots (above surface)",
              gust1 = "Wind Gust knots (above surface)",
              wdir1 = "Wind Direction degrees (above surface)",
              raincumulative = "Rain, Cumulative inches (above surface)",
              raincurrent = "Rain, Currently inches (above surface)",
              par001 = "PAR (1m)",
              nit001 = "Nitrate mg/L (2m)",
              spcond001 = "Specific Conductivity µs/cm (2m)",
              spcond002 = "Specific Conductivity µs/cm (5m)",
              spcond003 = "Specific Conductivity µs/cm (8m)",
              spcond004 = "Specific Conductivity µs/cm (11m)",
              clcon001 = "Chlorophyll µg/L (2m)",
              phyco001 = "Phycocyanin Cells/mL (2m)",
              cdom001 = "CDOM µg/L (2m)",
              ph001 = "pH (2m)",
              ph002 = "pH (5m)",
              ph003 = "pH (8m)",
              ph004 = "pH (11m)",
              turb001 = "Turbidity NTU (2m)",
              o2perc001 = "Dissolved Oxygen Saturation % (2m)",
              o2perc002 = "Dissolved Oxygen Saturation % (5m)",
              o2perc003 = "Dissolved Oxygen Saturation % (8m)",
              o2perc004 = "Dissolved Oxygen Saturation % (11m)",
              odo001 = "Dissolved Oxygen mg/L (2m)",
              odo002 = "Dissolved Oxygen mg/L (5m)",
              odo003 = "Dissolved Oxygen mg/L (8m)",
              odo004 = "Dissolved Oxygen mg/L (11m)")
  return(x_vars)
}

#' @title Muskegon Lake Buoy Data Graph
#' @name muskegonLakeBuoyGraph
#' @description Creating plotting function
#' @export

muskegonLakeBuoyGraph <- function(x,y=NULL,chart_type, mlData) {
  x_vars = get_x_vars()
  y_vars = get_y_vars()
  # Creating selected visualization
  for (i in seq(1, length(x_vars))){
    for (j in seq(1, length(y_vars))){
      x_val = x_vars[i]
      y_val = y_vars[j]
      if(names(x_val) == x && names(y_val) == y){
        if(chart_type == "scatter"){
          plt <- ggplot(mlData, aes_string(x=paste0("x_", x),
                                           y=paste0("y_", y))) +
            geom_point() +
            geom_smooth(se=FALSE, method="lm", size=1) +
            ggtitle(paste('Scatter plot of', x_val, 'by', y_val )) +
            xlab(paste0(x_val)) +
            ylab(paste0(y_val)) +
            labs(caption = "Data Source: The Muskegon Lake Observatory Buoy") +
            theme_bw()
          return(plt)

        } else if (chart_type == "line"){
          plt <- ggplot(mlData, aes_string(x=paste0("x_", x),
                                           y=paste0("y_", y))) +
            stat_summary(geom="line", fun=mean, size=1) +
            ggtitle(paste('Line plot of', x_val, 'by', y_val))+
            xlab(paste0(x_val)) +
            ylab(paste0(y_val)) +
            labs(caption = "Data Source: The Muskegon Lake Observatory Buoy") +
            theme_bw()
          return(plt)

        }else if (chart_type == "boxplot"){

          plt <- ggplot(mlData, aes_string(x=paste0("x_", x),
                                           y=paste0("y_", y))) +
            geom_boxplot() +
            ggtitle(paste('Boxplot of', x_val, 'by', y_val))+
            xlab(paste0(x_val)) +
            ylab(paste0(y_val)) +
            labs(caption = "Data Source: The Muskegon Lake Observatory Buoy") +
            theme_bw() +
            theme(text = element_text(face= "bold"),
                  axis.title=element_text(size=14), legend.position="bottom",
                  plot.title=element_text(hjust=0.50))
          return(plt)
        }
      }
    }
  }
}

