#The first four commands should only be run if the data is not already unzipped into your working directory
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power <- read.table(unz(temp, "household_power_consumption.txt"),sep=";", header=T, stringsAsFactors=F)
unlink(temp)

#read the unzipped data file from working directory
power <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors=F)
#Subset the data to just the first two days in February 2007, date is already in %d%m%Y format
dateSubset <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")
#open a png graphics device
png(filename="plot1.png",width = 480, height = 480)
#Draw a histogram of the Global_active_power variable, and appropriately colour and label
hist(as.numeric(dateSubset$Global_active_power), col="red", main= "Global Active Power", xlab="Global Active Power (kilowatts)")
#Turn off png graphic device
dev.off()

