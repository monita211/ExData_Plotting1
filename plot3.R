#Read in data and load packages
library(chron)
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = '?', 
                 colClasses = c(rep("character",2), rep("numeric",7))) 

#create datasubset of just two days with Date1 as string converted to date class
dates <- as.Date(as.character(data$Date), "%d/%m/%Y")
data$Date1 <- dates
datasubset <- data[data$Date1 %in% as.Date(c("2007-02-01","2007-02-02")), ]

#add Time1 variable of time class
timetemp <- datasubset$Time #string
datasubset$Time1 <- chron(times = timetemp) #time class
#Time2 <- strptime(timetemp, format = '%H:%M:%S') #Time but using current date/WRONG DONT USE

#concatenate time and date and add column with both values
datetimeconcat <- apply(datasubset,1 ,function(x) paste(toString(x[1]), toString(x[2])))
datasubset$datetime <- strptime(datetimeconcat, format = '%d/%m/%Y %H:%M:%S')
head(datasubset)

#Plot 3
par(mfcol = c(1,1))
with(datasubset, plot(datetime, Sub_metering_1, ylab = "Energy sub metering", type = 'l', xlab =''))
with(datasubset, lines(datetime, Sub_metering_2, ylab = "Energy sub metering", type = 'l', col = "red",xlab=''))
with(datasubset, lines(datetime, Sub_metering_3, ylab = "Energy sub metering", type = 'l', col = "blue",xlab=''))
legend('topright', lwd=2, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file = 'plot3.png')
dev.off()

