plot2 <- function() {
  #general config
  rm(list = ls())
  graphics.off() 
  par(ps=10)
  Sys.setlocale(category="LC_TIME", "en_US.UTF-8")
    
  #zip, original and subset file paths
  zipFile <- "exdata-data-household_power_consumption.zip"
  csvFileOrig <- "household_power_consumption.txt"
  csvFileSubset <- "household_power_consumption_subset2.txt"
  
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
  plot(data$TD, data$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
  
  #copy2png
  dev.copy(png, file="plot2.png")
  dev.off()  
}