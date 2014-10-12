plot2 <- function() {
  #general config
  Sys.setlocale(category="LC_TIME", "en_US.UTF-8")
  
  #read
  csvFile <- "household_power_consumption.txt"
  data <- read.csv(csvFile, sep=";", header=TRUE, na.strings="?")
  
  #date conversion
  data$TD <- strptime(paste(data$Date, data$Time, sep=","), format="%d/%m/%Y,%H:%M:%S")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  #subsetting
  data <- data[data$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]
  
  #plotting
  plot(csv$TD, csv$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
  
  #copy2png
  dev.copy(png, file="plot2.png")
  dev.off()  
}