plot3 <- function() {
  #cleanup and config
  rm(list = ls())
  graphics.off() 
  par(ps=10)
  Sys.setlocale(category="LC_TIME", "en_US.UTF-8")
  
  #read
  unzip("exdata-data-household_power_consumption.zip")
  csvFile <- "household_power_consumption.txt"
  data <- read.csv(csvFile, sep=";", header=TRUE, na.strings="?")
  
  #date conversion
  data$TD <- strptime(paste(data$Date, data$Time, sep=","), format="%d/%m/%Y,%H:%M:%S")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  #subsetting
  data <- data[data$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

  #plotting
  plot(csv$TD, csv$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering", col="white", cex=0.5)
  lines(csv$TD, csv$Sub_metering_1, col="black")
  lines(csv$TD, csv$Sub_metering_2, col="red")
  lines(csv$TD, csv$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, seg.len=1, cex=1, x.intersp=0.5, y.intersp=0.7, inset=c(0,0))
  
  #copy2png
  dev.copy(png, file="plot3.png")
  dev.off()  
}