plot2 <- function(dataFile = "data/household_power_consumption.txt"){
  zipFile <- "household_power_consumption.zip"
  if(!file.exists(dataFile)){
   if(!file.exists(zipFile)){
     download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=zipFile)
   }
   unzip(zipFile, exdir="data")
  }
  message("Creating data frame")
  png("plot2.png") 
  household <- read.table(dataFile, header = TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
  household_sub <- household[(as.Date(household$Date, format="%d/%m/%Y") == "2007-02-01" | as.Date(household$Date, format="%d/%m/%Y") == "2007-02-02"),]
  household_sub <- cbind(as.POSIXct(paste(household_sub$Date, " ",household_sub$Time), format="%d/%m/%Y %H:%M:%S"),household_sub)
  colnames(household_sub)[1] <- "datetime"
  message("Creating plot...")
  #Set device to png 
  with(household_sub, plot(datetime, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)"))
  lines(household_sub$datetime, household_sub$Global_active_power)
  #create png file
  dev.off()
}