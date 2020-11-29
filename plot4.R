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

#View the data structure
glimpse(data_electricpower)
head(data_electricpower)
tail(data_electricpower)
summary(data_electricpower)
sum(is.na(data_electricpower)) #There are not the missing values.

###Plot 4###
Sys.timezone() #My tz is "America/Bogota"

#Open the png device and create the png file
png("./data/plot4.png", width = 480, height = 480)

#Create the plot 4
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))
with(data_electricpower, {
        plot(datetimevalue, Global_active_power, xlab = "",
             ylab = "Global Active Power", type = "l")
        plot(datetimevalue, Voltage, type = "l", xlab = "datetime")
        plot(datetimevalue, Sub_metering_1, col = "black", type = "l",
             xlab = "", ylab = "Energy sub metering")
          lines(datetimevalue, Sub_metering_2, col = "red", type = "l")
          lines(datetimevalue, Sub_metering_3, col = "blue", type = "l")
          legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(datetimevalue, Global_reactive_power, type = "l", xlab = "datetime")
})

#Close the png device
dev.off()
