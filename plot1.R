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

# Plot 1

png(filename = "plot1.png", width = 480, height = 480, units = "px")

with(power_feb, hist(Global_active_power, col = 'red', xlab="Global Active Power (kilowatts)", 
                          ylab = "Frequency", main = "Global Active Power"))

dev.off()






