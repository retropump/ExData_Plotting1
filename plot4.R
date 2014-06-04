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
png(filename="plot4.png", width=480, height=480)
#Create 4 plots on one device output
par(mfrow=c(2,2))
#Draw an empty plot of the Global_active_power variable,versus Date/Time
plot(dateSubset$DateTime, as.numeric(dateSubset$Global_active_power), xlab="", ylab="Global Active Power", type="n")
#Now draw the lines on the plot
lines(dateSubset$DateTime, dateSubset$Global_active_power)
#Draw a similar graph of Voltage versus Date/Time
#Empty graph
plot(dateSubset$DateTime, as.numeric(dateSubset$Voltage), xlab="datetime", ylab="Voltage", type="n")
#Now fill in the lines
lines(dateSubset$DateTime, dateSubset$Voltage)
#Now recreate plot 3 of Date/Time versus Sub-metering, empty plot first
plot(dateSubset$DateTime, dateSubset$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "") 
#Now fill in the plot
lines(dateSubset$DateTime, dateSubset$Sub_metering_1, col="black")
lines(dateSubset$DateTime, dateSubset$Sub_metering_2, col= "red")
lines(dateSubset$DateTime, dateSubset$Sub_metering_3, col= "blue")
#Create a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = c(1,1,1), col = c("black","red", "blue"), bty="n") 
#Finally, plot Dtae/Time against Global_reactive_power, creating an empty plot first
plot(dateSubset$DateTime, dateSubset$Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab = "datetime") 
#Now fill in the lines
lines(dateSubset$DateTime, dateSubset$Global_reactive_power)
dev.off()