plot4 <- function() {
  #general config
  rm(list = ls())
  graphics.off() 
  par(mfcol=c(2, 2), ps=10)
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

  #plot1 (=plot2)
  plot(csv$TD, csv$Global_active_power, type = "l", xlab="", ylab = "Global Active Power")
  
  #plot2 (=plot3)
  plot(csv$TD, csv$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering", col="white")
  lines(csv$TD, csv$Sub_metering_1, col="black")
  lines(csv$TD, csv$Sub_metering_2, col="red")
  lines(csv$TD, csv$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, seg.len=1, bty="n", cex=1, y.intersp=0.5, inset=c(-0.12,-0.05))
  
  #plot3
  plot(csv$TD, csv$Voltage, type = "l", xlab="datetime", ylab = "Voltage")
  
  #plot4
  plot(csv$TD, csv$Global_reactive_power, type = "l", xlab="datetime", ylab = "Global_reactive_power")
    
  #copy2png
  dev.copy(png, file="plot4.png")
  dev.off()  
}