plot1 <- function() {
  #cleanup and config
  rm(list = ls())
  graphics.off() 
  par(ps=10)
  
  #zip, original and subset file paths
  zipFile <- "exdata-data-household_power_consumption.zip"
  csvFileOrig <- "household_power_consumption.txt"
  csvFileSubset <- "household_power_consumption_subset.txt"
  
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
    
    #export subset to txt file 
    #avoid above large file processing in consequent runs 
    write.csv(data, csvFileSubset)
  } 
  
  #read subset data
  data <- read.csv(csvFileSubset)

  #plotting
  hist(as.numeric(data$Global_active_power), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
  
  #copy2png
  dev.copy(png, file="plot1.png")
  dev.off()
}