#Create a temporary directory to load the large file,
#Download file to temp dir,
#Unzip files in temp dir,
#Delete files in temp dir:

temp <- tempfile() 
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp) 
file <- unzip(temp) 
unlink(temp) 

#Read data into memory, subset, and remove extraneous data;
#Convert factor data to date and time and add as a new column to data frame:

data <- read.table(file, header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE, dec = ".");
pdat <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]; 
pdat$dateTime <- strptime(paste(pdat$Date, pdat$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#Open PNG device, plot the graph, drop it into device and close device:

png("Plot4.png")
par(mfrow = c(2, 2))
plot(pdat$dateTime, pdat$Global_active_power, type = "l", xlab = "Datetime", ylab = "Global Active Power")
plot(pdat$dateTime, pdat$Voltage, type = "l", xlab = "Datetime", ylab = "Voltage")
plot(pdat$dateTime, pdat$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy Sub-Metering")
lines(pdat$dateTime, pdat$Sub_metering_2, col = "red", type = "l")
lines(pdat$dateTime, pdat$Sub_metering_3, col = "blue", type = "l")
legend("topright", c("Sub-Metering 1","Sub-Metering 2","Sub-Metering 3"), lty = 1, col = c("black","red","blue"))
plot(pdat$dateTime, pdat$Global_reactive_power, type = "l", xlab = "Datetime", ylab = "Global Reactive Power")
dev.off()
