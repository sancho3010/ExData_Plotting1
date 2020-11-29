##Course Project: Week 1##
library(sqldf)
library(lubridate)
library(dplyr)

file.exists("./data")
if(!file.exists("./data")){
        dir.create("./data")
}

#Load Data
name <- "exdata_data_household_power_consumption"
unzip(zipfile = paste0("./data/", name, ".zip"), exdir = paste0(getwd(), "./data"))

##Read File filtered by SQL.
#Read a file into R filtering an sql statement. Only the filtered portion is processed by R.
data_electricpower <- read.csv.sql("./data/household_power_consumption.txt",
                                   sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                                   sep = ";")

#Review the data structure
glimpse(data_electricpower)
head(data_electricpower)
tail(data_electricpower)
summary(data_electricpower)
sum(is.na(data_electricpower))

###Plot 2###
Sys.timezone() #My tz is "America/Bogota"

#Open the png device and create the png file.
png("./data/plot2.png", width = 480, height = 480)

#Create the plot 2
datetimevalue <- dmy_hms(paste0(data_electricpower$Date," ", data_electricpower$Time))
plot(datetimevalue, 
     data_electricpower$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

#Close the png device.
dev.off()
