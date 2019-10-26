#' @title visualization airports delay
#' @description to visualize the mean of the airport arrival time delays.by their x,y coordinator
#' @return A scatterplot according to the arrival delay
#' @importFrom stats na.omit
#' @export visualization_airports_delay

library(dplyr)
library(nycflights13)
library(ggplot2)
library(maps)
visualization_airports_delay <- function(){

  # faa   lat   lon
  airportsInfo <- na.omit(airports)
  # dest  arr_delay & remove na values from data
  flightsInfo <- na.omit(flights)


  # Group by airports, get mean according to category
  flights <- na.omit(flights)
  # claculate mean
  flights <- summarise( group_by(flights, dest),meanDelay = mean(arr_delay))
  airportDelays <- inner_join(airports, flights, by=c("faa" = "dest"))


  # Create map and plot using mean value as color scale
  ggplot(airportDelays, aes(x=airportDelays$lat, y=airportDelays$lon)) +
    geom_point(aes(color=airportDelays$meanDelay), size=3) +
    scale_color_gradient(low="red", high="#F5F5F5") +
    theme_bw() +
    labs(title="Airport times delay",
         subtitle="According to Longitude vs. Latitude",
         x="Latitude", y="Longitude",
         color="Times delays") +
    theme(plot.title = element_text(hjust=0.5, size=16),
          plot.subtitle = element_text(hjust = 0.5, size=14, face="italic"),
          axis.text = element_text(size=14))
}
