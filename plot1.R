plot1 <- function() {
  #cleanup and config
  rm(list = ls())
  graphics.off() 
  par(ps=10)
  
  #read
  unzip("exdata-data-household_power_consumption.zip")
  csvFile <- "household_power_consumption.txt"
  data <- read.csv(csvFile, sep=";", header=TRUE, na.strings="?")
  
  #date conversion
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  #subsetting
  data <- data[data$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]
  
  #plotting
  hist(as.numeric(data$Global_active_power), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
  
  #copy2png
  dev.copy(png, file="plot1.png")
  dev.off()
}