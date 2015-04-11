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

#Plot 4
par(mfcol = c(2,2), cex.lab = .75, mar = c(5,4,2,2), cex.axis = .6)

#top left
with(datasubset, plot(datetime,Global_active_power,type='l', xlab = '', 
                      ylab = 'Global Active Power'))
#bottom left
with(datasubset, plot(datetime, Sub_metering_1, ylab = "Energy sub metering", type = 'l', xlab =''))
with(datasubset, lines(datetime, Sub_metering_2, ylab = "Energy sub metering", type = 'l', col = "red",xlab=''))
with(datasubset, lines(datetime, Sub_metering_3, ylab = "Energy sub metering", type = 'l', col = "blue",xlab=''))
legend('topright', bty = 'n', lwd=2, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2",
                                                                               "Sub_metering_3"), cex = .5)
#top right
with(datasubset, plot(datetime,Voltage,type='l', xlab = 'datetime', 
                      ylab = 'Voltage'))
#bottom right
with(datasubset, plot(datetime,Global_reactive_power ,type='l', xlab = 'datetime', 
                      ylab = 'Global_reactive_power'))
dev.copy(png, file = 'plot4.png')
dev.off()

