#The first four commands should only be run if the data is not already unzipped into your working directory
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power <- read.table(unz(temp, "household_power_consumption.txt"),sep=";", header=T, stringsAsFactors=F)
unlink(temp)

#read the unzipped data file from working directory
power <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors=F, na.strings=c("?"))
#Subset the data to just the first two days in February 2007, date is in %d%m%Y format
dateSubset<- power[power$Date %in% c("1/2/2007","2/2/2007") ,]
#Paste the Date and Time variables together in Date?Time format
dateSubset$DateTime <- strptime(paste(dateSubset$Date, dateSubset$Time), "%d/%m/%Y %H:%M:%S")
#open a png graphics device
png(filename="plot2.png", width=480, height=480)
plot(dateSubset$DateTime, as.numeric(dateSubset$Global_active_power), type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
#Close graphic device
dev.off()


