

plot1 <- function() {

  
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

  
  ##Create plot 1
  png(filename = "plot1.png", width = 480, height = 480)
  hist(HPC$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
  dev.off()
  
}

