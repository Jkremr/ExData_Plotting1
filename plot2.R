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

png("Plot2.png")
plot(pdat$dateTime, pdat$Global_active_power, type = "l", xlab = "Datetime", ylab = "Global Active Power")
dev.off()
