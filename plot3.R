plot3 <- function(dataFile = "data/household_power_consumption.txt"){
  zipFile <- "household_power_consumption.zip"
  if(!file.exists(dataFile)){
   if(!file.exists(zipFile)){
     download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=zipFile)
   }
   unzip(zipFile, exdir="data")
  }
  message("Creating data frame")
  household <- read.table(dataFile, header = TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
  household_sub <- household[(as.Date(household$Date, format="%d/%m/%Y") == "2007-02-01" | as.Date(household$Date, format="%d/%m/%Y") == "2007-02-02"),]
  hh <- cbind(as.POSIXct(paste(household_sub$Date, " ",household_sub$Time), format="%d/%m/%Y %H:%M:%S"),household_sub)
  colnames(hh)[1] <- "datetime"
  message("Creating plot...")
  #Set device to png 
  png("plot3.png", width=570, height=480, units="px")
  with(hh, plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
  lines(hh$datetime, hh$Sub_metering_1, col="black")
  lines(hh$datetime, hh$Sub_metering_2, col="red")
  lines(hh$datetime, hh$Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), col=c("black","red","blue") )
  #create png file
  dev.off()
}