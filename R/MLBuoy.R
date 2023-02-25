#' @import tidyverse

#' @title Fetch Muskegon Lake Buoy Data
#'
#' @description This function fetches data on current and historical conditions of Muskegon Lake in Muskegon County, Michigan from the Muskegon Lake Buoy API.
#' Grand Valley State University's Robert B. Annis Water Resources Institute (AWRI) established the buoy-based observatory in 2010. More information on the Muskegon Lake Buoy is available on the AWRI website: \url{https://www.gvsu.edu/wri/buoy/}.
#' The API documentation is available at \url{https://www.gvsu.edu/wri/buoy/data-api.htm}.
#' @param x A single x value may be used.
#' If no value is specified, date will be used as the default.
#' @param y At least one y value is required.
#' Multiple y values should be separated by a comma.
#' @param start_date A specific date in time that marks the beginning of a particular period.
#' Date values must be in the format MM/DD/YYYY or M/D/YY.
#' The default value is 10/01/2022.
#' @param end_date A specific date in time that marks the end of a particular period.
#' Values must be in the format MM/DD/YYYY or M/D/YY.
#' The default date is 10/31/2022.
#' @param time Time values must be in the 24-hour format H:MM or HH:MM.
#' The values must also be divisible by 15 minutes (0:00, 0:15, 0:30, and 0:45).
#' If no value is provided then all times are considered.
#' @param calculation The mathematical calculation performed on the range points within an x variable's concentration.
#' @details The arguments for x and y must be supported values. More information can be found at Grand Valley State University Muskegon Lake Buoy API website: \url{https://www.gvsu.edu/wri/buoy/data-api.htm}
#' @return A data frame based on the provided parameters.
#' @examples fetch_buoy_data(x="weekday",y="atmp1,tp001,tp002", start_date="7/7/11", end_date="7/28/11")
#' @author Beatrice Ngigi
#' @author Prof. Andrew DiLernia
#' @export

fetch_buoy_data <- function(x = "date",
                            y,
                            start_date = "10/01/2022",
                            end_date = "10/31/2022",
                            time = NULL,
                            calculation = NULL) {

  # Constructing date from start_date & end_date
  date <- paste0(start_date, "-", end_date)

  # Creating a named vector of inputs
  inputs <- c(x = x, y = y, date = date, time = time, calculation = calculation)

  # Constructing URL for API query
  baseURL <- "http://www.gvsu.edu/wri/buoy/data-generate.htm?"
  URL <- paste0(baseURL, paste(paste0(names(inputs), "=", inputs), collapse = "&"), "&format=csv")

  # Fetching data from API
  MLbuoyData <- read.csv(URL)

  return(MLbuoyData)
}



#' @title Plot Muskegon Lake Buoy Data
#'
#' @description This function offers a simple method to visualize data from Muskegon Lake in Muskegon County, Michigan from the Muskegon Lake Buoy API.
#' Grand Valley State University's Robert B. Annis Water Resources Institute (AWRI) established the buoy-based observatory in 2010. More information on the Muskegon Lake Buoy is available on the AWRI website: \url{https://www.gvsu.edu/wri/buoy/}.
#' The API documentation is available at \url{https://www.gvsu.edu/wri/buoy/data-api.htm}.
#' @param x The values to be plotted on the x-axis of the graph.
#' If no value is specified, date will be used as the default.
#' @param y The values to be used on the y-axis of the graph.
#' Multiple y values should be separated by a comma.
#' @param start_date A specific date in time that marks the beginning of a particular period.
#' Date values must be in the format MM/DD/YYYY or M/D/YY.
#' The default value is 10/01/2022.
#' @param end_date A specific date in time that marks the end of a particular period.
#' Values must be in the format MM/DD/YYYY or M/D/YY.
#' The default date is 10/31/2022.
#' @param graph_type The type of chart to be plotted.
#' The supported types are scatter, line, bar, and boxplot.
#' @details The arguments for x and y must be supported values. More information can be found at Grand Valley State University Muskegon Lake Buoy API website: \url{https://www.gvsu.edu/wri/buoy/data-api.htm}
#' @return A graph of x values by y values
#' @import tidyverse
#' @examples plot_buoy_data(x="weekday",y="rh1", graph_type="line")
#' @author Beatrice Ngigi
#' @author Prof. Andrew DiLernia
#' @export

plot_buoy_data <- function(x = "date",
                           y = NULL,
                           start_date = "10/01/2022",
                           end_date = "10/31/2022",
                           graph_type) {

  # Fetching data
  mlData <- fetch_buoy_data(x = "date", y = NULL, start_date = "10/01/2022",
                            end_date = "10/31/2022", time = NULL,
                            calculation = NULL)

  if("x_yearmonth" %in% names(mlData)){
    mlData <- dplyr::mutate(mlData, x_yearmonth = case_when(
        x_yearmonth == 4 ~ "April",
        x_yearmonth == 5 ~ "May",
        x_yearmonth == 6 ~ "June",
        x_yearmonth == 7 ~ "July",
        x_yearmonth == 8 ~ "Aug",
        x_yearmonth == 9 ~ "Sept",
        x_yearmonth == 10 ~ "Oct",
        x_yearmonth == 11 ~ "Nov"))
  }

  if("x_weekday" %in% names(mlData)){
    mlData <- mlData %>%
      dplyr::mutate(x_weekday = dplyr::case_when(
        x_weekday == 1 ~ "Mon",
        x_weekday == 2 ~ "Tue",
        x_weekday == 3 ~ "Wed",
        x_weekday == 4 ~ "Thur",
        x_weekday == 5 ~ "Fri",
        x_weekday == 6 ~ "Sat",
        x_weekday == 7 ~ "Sun"))
  }

  # Creating the arguments for x and y parameters
  parameters <- tibble(atmp1 = "Air Temp °F (above surface)",
                       atmp1max = "Maximum Air Temperature (Long term since 2011) °F (above surface)",
                       atmp1min = "Minimum Air Temperature (Long term since 2011) °F (above surface)",
                       baro1 = "Relative Barometric Pressure in Hg (above surface)",
                       cdom001 = "CDOM µg/L (2m)",
                       clcon001 = "Chlorophyll µg/L (2m)",
                       date = "Date",
                       dayhour = "Hour of Day",
                       gust1 = "Wind Gust knots (above surface)",
                       julian = "Julian Day",
                       nit001 = "Nitrate mg/L (2m)",
                       o2perc001 = "Dissolved Oxygen Saturation % (2m)",
                       o2perc002 = "Dissolved Oxygen Saturation % (5m)",
                       o2perc003 = "Dissolved Oxygen Saturation % (8m)",
                       o2perc004 = "Dissolved Oxygen Saturation % (11m)",
                       odo001 = "Dissolved Oxygen mg/L (2m)",
                       odo002 = "Dissolved Oxygen mg/L (5m)",
                       odo003 = "Dissolved Oxygen mg/L (8m)",
                       odo004 = "Dissolved Oxygen mg/L (11m)",
                       par001 = "PAR (1m)",
                       ph001 = "pH (2m)",
                       ph002 = "pH (5m)",
                       ph003 = "pH (8m)",
                       ph004 = "pH (11m)",
                       phyco001 = "Phycocyanin Cells/mL (2m)",
                       raincumulative = "Rain, Cumulative inches (above surface)",
                       raincurrent = "Rain, Currently inches (above surface)",
                       rh1 = "Relative Humidity % (above surface)",
                       spcond001 = "Specific Conductivity µs/cm (2m)",
                       spcond002 = "Specific Conductivity µs/cm (5m)",
                       spcond003 = "Specific Conductivity µs/cm (8m)",
                       spcond004 = "Specific Conductivity µs/cm (11m)",
                       tp001 = "Water Temp °F (2m)",
                       tp002 = "Water Temp °F (4m)",
                       tp003 = "Water Temp °F (6m)",
                       tp004 = "Water Temp °F (7m)",
                       tp005 = "Water Temp °F (9m)",
                       tp006 = "Water Temp °F (11m)",
                       turb001 = "Turbidity NTU (2m)",
                       wdir1 = "Wind Direction degrees (above surface)",
                       weekday = "Day of Week",
                       wspd1 = "Wind Speed knots (above surface)",
                       yearday = "Day of Year",
                       yearmonth = "Month of Year",
                       yearweek = "Week of Year")

  # Creating selected visualization
  x_val <- parameters[[x]]
  y_val <- parameters[[y]]

  if(graph_type == "scatter"){
    plt <- ggplot(mlData, aes_(x=as.name(paste0('x_',x)),
                                     y=as.name(paste0('y_',y)))) +
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

