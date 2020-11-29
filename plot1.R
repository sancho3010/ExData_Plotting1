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
str(data_electricpower) #Convert Date and Time variable to Date/Time class.
head(data_electricpower)
tail(data_electricpower)
sum(is.na(data_electricpower)) #There are not the missing values.

#Conversion
data_electricpower$Date <- dmy(data_electricpower$Date)
data_electricpower$Time <- hms(data_electricpower$Time)

#Review the data structure
glimpse(data_electricpower)
head(data_electricpower)
tail(data_electricpower)
summary(data_electricpower)

###Plot 1###

#Open the png device and create the png file.
png("./data/plot1.png", width = 480, height = 480)

#Create the plot
hist(data_electricpower$Global_active_power, main = "Global Active Power", 
     col = "red", xlab = "Global Active Power (Kilowatts)")

#Close the png device.
dev.off() 

