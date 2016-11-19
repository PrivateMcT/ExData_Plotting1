

plot4 <- function() {
  
  
  ##download data file, unzip to single file 
  if(!file.exists("./data")){dir.create("./data")}
  download.file.method = "curl"
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, destfile="./data/HPC.zip")
  unzip("./data/HPC.zip", junkpaths = TRUE, exdir = "./data/HPC")
  
  ##Read txt files into data frames
  HPC <-  subset(read.table("./data/HPC/household_power_consumption.txt", sep = ";", header =TRUE, stringsAsFactors = FALSE), Date=="1/2/2007"|Date=="2/2/2007")
  
  ##Clean up data
  HPC$DateTime<-as.POSIXct(paste(HPC$Date, HPC$Time), format="%d/%m/%Y %H:%M:%S", tz="")
  HPC[,3:8][HPC[,3:8] == "?"] <- NA
  for (i in 3:8) {HPC[,i]<-as.numeric(HPC[,i])}
  HPC<-HPC[c(10,3,4,5,6,7,8,9)]

  ##Create plot 4
  png(filename = "plot4.png", width = 480, height = 480)
  par(mfrow=c(2,2))
  with(HPC, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
  with(HPC, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))
  with(HPC, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
  with(HPC, points(DateTime, Sub_metering_2, type="l", col="red"))
  with(HPC, points(DateTime, Sub_metering_3, type="l", col="blue"))
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue"), bty="n")
  with(HPC, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
  dev.off()
}

