#' @import tidyverse

#' @title Fetch Muskegon Lake Buoy Data
#'
#' @description This function fetches data on current and historical conditions of Muskegon Lake in Muskegon County, Michigan from the Muskegon Lake Buoy API. API documentation is available at \url{https://www.gvsu.edu/wri/buoy/data-api.htm}
#'
#' Grand Valley State University's Robert B. Annis Water Resources Institute (AWRI) established a buoy-based observatory in Muskegon Lake in 2010, and the earliest data available from the API is in 2011. More information on the Muskegon Lake Buoy is available on the AWRI website: \url{https://www.gvsu.edu/wri/buoy/}
#' @param y At least one y value is required.
#' Multiple y values should be separated by a comma.
#' @param x A single x value may be used.
#' @param date Date values must be in the format MM/DD/YYYY or M/D/YY.
#' If no value is provided then all dates are considered.
#' @param time Time values must be in the 24-hour format H:MM or HH:MM.
#' The values must also be divisible by 15 minutes (0:00, 0:15, 0:30, and 0:45).
#' If no value is provided then all times are considered.
#' @param calculation The mathematical calculation performed on the range points within an x variable's concentration.
#' @param concentration A decimal number in the range .01-1.0 which represents the total amount of y plots per x variable.
#' The closer to 1 this number is, the more points will be present in the output and the more accurate the graph.
#' If no value is provided then all points are considered.
#' @return A data frame based on the provided parameters.
#' @import tidyverse tibble ggplot2
#' @examples fetch_buoy_data(y="atmp1,tp001,tp002", x="date", date="7/7/11,7/14/11,7/21/11,7/28/11", concentration="1")
#' @author Beatrice Ngigi
#' @author Andrew DiLernia
#'
#'
#' @export

fetch_buoy_data <- function(y, x=NULL, date = NULL, time = NULL,
                                 calculation = NULL, concentration = NULL,
                                 start_date = NULL, end_date = NULL) {

  # Creating a named vector of inputs
  inputs <- c(x = x, y = y, date = date, time = time,
               calculation = calculation, concentration = concentration,
               start_date = start_date, end_date = end_date)

  # Constructing URL for API query
  baseURL <- "http://www.gvsu.edu/wri/buoy/data-generate.htm?"
  URL <- paste0(baseURL, paste(paste0(names(inputs), "=", inputs), collapse = "&"), "&format=csv")

  # Fetching data from API
  MLbuoyData <- read.csv(URL)

  # Applying the start and end date filter
  if (!is.null(start_date) & !is.null(end_date)) {
    filtered_data <- MLbuoyData[MLbuoyData$date >= start_date & MLbuoyData$date <= end_date, ]
    if (nrow(filtered_data) == 0) {
      return(data.frame())
    } else {
      MLbuoyData <- filtered_data
    }
  }

  return(MLbuoyData)
}


#' @title Plot Muskegon Lake Buoy Data
#'
#' @description This function offers a simple method to retrieve and display data from the Muskegon Lake Buoy through the use of Application Programming Interface.
#' The raw data is transformed into an easy-to-read and visually appealing graph, facilitating comprehension and analysis.
#' @param x The values to be plotted on the x-axis of the graph.
#' @param y The values to be used on the y-axis of the graph.
#' Multiple y values should be separated by a comma.
#' @param graph_type The type of chart to be plotted.
#' The supported types are scatter, line, bar, and boxplot.
#' @details The arguments for x and y must be supported values. More information can be found at Grand Valley State University Muskegon Lake Buoy website: \url{https://www.gvsu.edu/wri/buoy/data-api.htm}
#' @return A graph of x values by y values
#' @import tidyverse tibble ggplot2
#' @examples plot_buoy_data(x="weekday",y="rh1", graph_type="line")
#' @author Beatrice Ngigi
#' @author Andrew DiLernia
#'
#'
#' @export

plot_buoy_data <- function(x = NULL, y = NULL, filter=NULL, graph_type) {

  # Fetching data
  mlData <- fetch_buoy_data(x = x, y = y, date = NULL, time = NULL,
                                 concentration = NULL, calculation = NULL)

  if (!is.null(filter)) {
    mlData <- mlData[mlData[,filter[1]] >= filter[2] & mlData[,filter[1]] <= filter[3], ]
  }

  if("yearmonth" %in% names(mlData)){
    mlData <- mlData %>%
      dplyr::mutate(yearmonth = case_when(
        yearmonth == 1 ~ "Jan",
        yearmonth == 2 ~ "Feb",
        yearmonth == 3 ~ "March",
        yearmonth == 4 ~ "April",
        yearmonth == 5 ~ "May",
        yearmonth == 6 ~ "June",
        yearmonth == 7 ~ "July",
        yearmonth == 8 ~ "Aug",
        yearmonth == 9 ~ "Sept",
        yearmonth == 10 ~ "Oct",
        yearmonth == 11 ~ "Nov",
        yearmonth == 12 ~ "Dec"))
  }

  if("weekday" %in% names(mlData)){
    mlData <- mlData %>%
      mutate(weekday = case_when(
        weekday == 1 ~ "Mon",
        weekday == 2 ~ "Tue",
        weekday == 3 ~ "Wed",
        weekday == 4 ~ "Thur",
        weekday == 5 ~ "Fri",
        weekday == 6 ~ "Sat",
        weekday == 7 ~ "Sun"))
  }

  # Creating the arguments for x and y parameters
  y_parameters <- tibble(atmp1 = "Air Temp °F (above surface)",
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

  x_parameters <- tibble(date = "Date",
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

  # Creating selected visualization
  x_val <- x_parameters[[x]]
  y_val <- y_parameters[[y]]

  if(graph_type == "scatter"){
    plt <- ggplot(mlData, aes_string(x=paste0('x_',x),
                                     y=paste0('y_',y))) +
      geom_point() +
      geom_smooth(se=FALSE, method="lm", size=1) +
      ggtitle(paste('Scatter plot of', x_val, 'by', y_val )) +
      xlab(paste0(x_val)) +
      ylab(paste0(y_val)) +
      labs(caption = "Data Source: The Muskegon Lake Observatory Buoy") +
      theme_bw()

    return(plt)

  } else if (graph_type == "line"){

    plt <- ggplot(mlData, aes_string(x=paste0('x_',x),
                                     y=paste0('y_',y)))  +
      stat_summary(geom="line", fun=mean, size=1) +
      ggtitle(paste('Line plot of', x_val, 'by', y_val))+
      xlab(paste0(x_val)) +
      ylab(paste0(y_val)) +
      labs(caption = "Data Source: The Muskegon Lake Observatory Buoy") +
      theme_bw()

    return(plt)

  }else if (graph_type == "boxplot"){
    plt <- ggplot(mlData, aes_string(x=paste0("x_", as.factor(x)),
                                     y=paste0("y_", y))) +
      geom_boxplot() +
      ggtitle(paste('Boxplot of', x_val, 'by', y_val)) +
      xlab(paste0(x_val)) +
      ylab(paste0(y_val)) +
      labs(caption = "Data Source: The Muskegon Lake Observatory Buoy") +
      theme_bw() +
      theme(text = element_text(face= "bold"),
            axis.title=element_text(size=14), legend.position="bottom",
            plot.title=element_text(hjust=0.50))

    return(plt)

  }else if (graph_type == "bar"){
    plt <- ggplot(mlData, aes_string(x=paste0("x_", x),
                                     y=paste0("y_", y))) +
      geom_bar(stat="identity") +
      ggtitle(paste('A Bar Graph of', x_val, 'by', y_val))+
      xlab(paste0(x_val)) +
      ylab(paste0(y_val)) +
      labs(caption = "Data Source: The Muskegon Lake Observatory Buoy") +
      theme_classic() +
      theme(text = element_text(face= "bold"),
            axis.title=element_text(size=14), legend.position="bottom",
            plot.title=element_text(hjust=0.50))

    return(plt)
  }
}

