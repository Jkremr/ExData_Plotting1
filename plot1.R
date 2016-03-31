#Create a temporary directory to load the large file,
#Download file to temp dir,
#Unzip files in temp dir,
#Delete files in temp dir:

temp <- tempfile() 
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp) 
file <- unzip(temp) 
unlink(temp) 

#Read data into memory, subset, and remove extraneous data;
#Convert factor data to date and time:

data <- read.table(file, header = T, sep = ";", na.strings = "?");
pdat <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]; 
pdat$Date <- weekdays(as.Date(pdat$Date, format = "%d/%m/%Y"), abbreviate = T)
pdat$Time <- strptime(pdat$Time, format = "%H:%M:%S", tz = "GMT")

#Open PNG device, plot the graph, drop it into device and close device:

png("Plot1.png")
hist(pdat$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (killowats)")
dev.off()