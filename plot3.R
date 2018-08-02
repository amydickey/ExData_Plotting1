#Download data
power_consump <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Access the necessary packages
library(tidyverse)

#Filter for he needed dates
power_consump_filt <- power_consump %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

#Add date_time column in POSIXct POSIXt 
power_consump_filt <- power_consump_filt %>% mutate(date_time = as.POSIXct(paste(power_consump_filt$Date, power_consump_filt$Time), format="%Y-%m-%d %H:%M:%S"))
View(power_consump_filt)

dim(power_consump_filt) #2880 rows

#Open PNG device
png(filename = "plot3.png", width = 480, height = 480)

#Make plot one
power_consump_filt$Sub_metering_1 <- as.numeric(power_consump_filt$Sub_metering_1)
power_consump_filt$Sub_metering_2 <- as.numeric(power_consump_filt$Sub_metering_2)
power_consump_filt$Sub_metering_3 <- as.numeric(power_consump_filt$Sub_metering_3)

with(power_consump_filt, plot(date_time, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
lines(power_consump_filt$date_time, power_consump_filt$Sub_metering_1)
lines(power_consump_filt$date_time, power_consump_filt$Sub_metering_2, col = "red")
lines(power_consump_filt$date_time, power_consump_filt$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)


#Close device
dev.off()

