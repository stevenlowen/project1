dat <- read.table(pipe("grep '^[12]/2/2007;' household_power_consumption.txt"), sep = ";", na.strings = "?")
hdr <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1)
names(dat) <- names(hdr)
dat$datetime <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
dat <- dat[order(dat$datetime),]	# in case dates are not sorted
minperday <- 24 * 60
png("plot2.png")
plot(dat$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
axis(1, at = (0:2)*minperday, labels = c("Thu", "Fri", "Sat"))
dev.off()
