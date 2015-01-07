plot4 <- function() {
  #cleanup and config
  rm(list = ls())
  graphics.off() 
  par(mfcol=c(2, 2), mar = c(4, 4, 2, 1), ps=10)
  Sys.setlocale(category="LC_TIME", "en_US.UTF-8")
  
  #zip, original and subset file paths
  zipFile <- "exdata-data-household_power_consumption.zip"
  csvFileOrig <- "household_power_consumption.txt"
  csvFileSubset <- "household_power_consumption_subset4.txt"
  
  if(!file.exists(csvFileOrig)) {
    unzip(zipFile)
  }
  if(!file.exists(csvFileSubset)) {
    #read original full file
    data <- read.csv(csvFileOrig, sep=";", header=TRUE, na.strings="?")  
    
    #date conversion
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    
    #subsetting
    data <- data[data$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]
    data$Date <- as.character(data$Date, "%d/%m/%Y")
    
    #export subset to txt file 
    #avoid above large file processing in consequent runs 
    write.csv(data, csvFileSubset)
  } 
  
  #read subset data
  data <- read.csv(csvFileSubset)
  
  #date conversion
  data$TD <- strptime(paste(data$Date, data$Time, sep=","), format="%d/%m/%Y,%H:%M:%S")
  
  #plotting  

  #plot1 (=plot2)
  plot(data$TD, data$Global_active_power, type = "l", xlab="", ylab = "Global Active Power")
  
  #plot2 (=plot3)
  plot(data$TD, data$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering", col="white")
  lines(data$TD, data$Sub_metering_1, col="black")
  lines(data$TD, data$Sub_metering_2, col="red")
  lines(data$TD, data$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, seg.len=1, bty="n", cex=1, y.intersp=0.5, inset=c(-0.12,-0.05))
  
  #plot3
  plot(data$TD, data$Voltage, type = "l", xlab="datetime", ylab = "Voltage")
  
  #plot4
  plot(data$TD, data$Global_reactive_power, type = "l", xlab="datetime", ylab = "Global_reactive_power")
    
  #copy2png
  dev.copy(png, file="plot4.png")
  dev.off()  
}