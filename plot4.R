#Download data
power_consump <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Access the necessary packages
library(tidyverse)

#Filter for he needed dates
power_consump_filt <- power_consump %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

#Add date_time column in POSIXct POSIXt 
power_consump_filt <- power_consump_filt %>% mutate(date_time = as.POSIXct(paste(power_consump_filt$Date, power_consump_filt$Time), format="%Y-%m-%d %H:%M:%S"))

#Change the needed columns to numberic
power_consump_filt$Sub_metering_1 <- as.numeric(power_consump_filt$Sub_metering_1)
power_consump_filt$Sub_metering_2 <- as.numeric(power_consump_filt$Sub_metering_2)
power_consump_filt$Sub_metering_3 <- as.numeric(power_consump_filt$Sub_metering_3)
power_consump_filt$Global_active_power <- as.numeric(power_consump_filt$Global_active_power)
power_consump_filt$Voltage <- as.numeric(power_consump_filt$Voltage)
power_consump_filt$Global_reactive_power <- as.numeric(power_consump_filt$Global_reactive_power)

#Open PNG device
png(filename = "plot4.png", width = 480, height = 480)

#Set plot layout
par(mfrow = c(2,2))

#Graph1
with(power_consump_filt, plot(date_time, Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = ""))
lines(power_consump_filt$date_time, power_consump_filt$Global_active_power)

#Graph2
with(power_consump_filt, plot(date_time, Voltage, type = "n", ylab = "Voltage", xlab = "datetime"))
lines(power_consump_filt$date_time, power_consump_filt$Voltage)

#Graph3
with(power_consump_filt, plot(date_time, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
lines(power_consump_filt$date_time, power_consump_filt$Sub_metering_1)
lines(power_consump_filt$date_time, power_consump_filt$Sub_metering_2, col = "red")
lines(power_consump_filt$date_time, power_consump_filt$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

#Graph4
with(power_consump_filt, plot(date_time, Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab = "datetime"))
lines(power_consump_filt$date_time, power_consump_filt$Global_reactive_power)

#Close device
dev.off()

