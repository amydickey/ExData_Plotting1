
#Download data
power_consump <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Access the necessary packages
library(tidyverse)

#Filter for he needed dates
power_consump_filt <- power_consump %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

#Add date_time column in POSIXct POSIXt 
power_consump_filt <- power_consump_filt %>% mutate(date_time = as.POSIXct(paste(power_consump_filt$Date, power_consump_filt$Time), format="%Y-%m-%d %H:%M:%S"))

#Open PNG device
png(filename = "plot1.png", width = 480, height = 480)

#Make plot one
power_consump_filt$Global_active_power <- as.numeric(power_consump_filt$Global_active_power)

hist(power_consump_filt$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red", ylim = c(0, 1200))

#Close device
dev.off()


