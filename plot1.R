dat <- read.table(pipe("grep '^[12]/2/2007;' household_power_consumption.txt"), sep = ";", na.strings = "?")
hdr <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1)
names(dat) <- names(hdr)
png("plot1.png")
hist(dat$Global_active_power, breaks = (0:15)/2, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

