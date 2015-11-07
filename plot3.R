dat <- read.table(pipe("grep '^[12]/2/2007;' household_power_consumption.txt"), sep = ";", na.strings = "?")
hdr <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1)
names(dat) <- names(hdr)
dat$datetime <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
dat <- dat[order(dat$datetime),]	# in case dates are not sorted
minperday <- 24 * 60
png("plot3.png")
plot(dat$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(dat$Sub_metering_2, col = "red")
lines(dat$Sub_metering_3, col = "blue")
legend("topright", grep("Sub", names(dat), value = TRUE), lty = c(1,1,1), col = c("black", "red", "blue"))
axis(1, at = (0:2)*minperday, labels = c("Thu", "Fri", "Sat"))
dev.off()
