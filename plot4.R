# Loading libraries

library(dplyr)
library(lubridate)

# Loading data and filtering for required dates

power_cons <- data.table :: fread("./household_power_consumption.txt", header = TRUE, sep = ';')
power_feb <- filter(power_cons, Date == '1/2/2007' | Date == '2/2/2007')

# Checking for missing values

"?" %in% power_feb

# Converting Global_active_power column to numeric

power_feb$Global_active_power <- as.numeric(power_feb$Global_active_power)

# Converting character data to Date class

power_feb$Date <- as.Date(power_feb$Date, "%d/%m/%Y")

# Merging date and time

power_feb$Date_Time <- with(power_feb, ymd(Date) + hms(Time))

# All plots:

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

#plot1

with(power_feb, hist(Global_active_power, col = 'red', xlab="Global Active Power (kilowatts)", 
                     ylab = "Frequency", main = "Global Active Power"))

#plot2

with(power_feb, plot(Date_Time, Global_active_power, type = "l",  xlab="", ylab = "Global Active Power (kilowatts)"))

#plot3

with(power_feb, plot(Date_Time, power_feb$Sub_metering_1, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

lines(power_feb$Date_Time, power_feb$Sub_metering_2, type = "l", col = "red")
lines(power_feb$Date_Time, power_feb$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty='n', lty = 1:3, col = c("black", "red", "blue"))


#plot4
with(power_feb, plot(Date_Time, Global_reactive_power, type ='l', xlab='datetime'))

dev.off()