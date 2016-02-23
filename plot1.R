## @header     Course Project 1 for Exploratory Data Analysis  
## @abstract   The 1st plot project
## @evironment Windows10 x64-w64-mingw32,R version 3.2.3 (2015-12-10) 
## @author     Chen Xu 
## @date       2016-02-23 

# 1.Check the file and download the targeted file
if(file.exists("household_power_consumption.txt")==FALSE){
  message("Dataset does not exist, downloading...")
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,destfile = "./household_power_consumption.zip") #Window10
  unzip("./household_power_consumption.zip")
}

# 2.load and process the dataset
rawData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",  
                      colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?") 
tidyData <- rawData[rawData$Date=="1/2/2007"|rawData$Date=="2/2/2007",]

rm(rawData) #remove the raw dataset

tidyData<- transform(tidyData, Date = as.Date(tidyData$Date, format = "%d/%m/%Y"),  #convert the Date and time
                              Time = strptime(paste(tidyData$Date, tidyData$Time), 
                                              format = "%d/%m/%Y %H:%M:%S"))
# 3.Draw the first plot
png("plot1.png",bg = "transparent")             #initiate the PNG device 
hist(tidyData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")
dev.off()  #close the device
