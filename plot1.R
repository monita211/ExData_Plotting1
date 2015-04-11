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

#Plot 1
par(mfcol = c(1,1))
with(datasubset, hist(Global_active_power, col='red',xlab = 'Global Active Power (kilowatts)',main=
                        'Global Active Power'))
dev.copy(png, file = 'plot1.png')
dev.off()

