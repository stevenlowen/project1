# use linux command "grep" to select only those two days
dat <- read.table(pipe("grep '^[12]/2/2007;' household_power_consumption.txt"), sep = ";", na.strings = "?")
# read in the headers from the top of the file
hdr <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1)
# copy the headers to the data used
names(dat) <- names(hdr)
# in case the records are not already in temporal order: first convert to POSIX date/time format
dat$datetime <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
# now put data in temporal order
dat <- dat[order(dat$datetime),]
minperday <- 24 * 60
# now actually make the plot
png("plot3.png")
plot(dat$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(dat$Sub_metering_2, col = "red")
lines(dat$Sub_metering_3, col = "blue")
legend("topright", grep("Sub", names(dat), value = TRUE), lty = c(1,1,1), col = c("black", "red", "blue"))
axis(1, at = (0:2)*minperday, labels = c("Thu", "Fri", "Sat"))
dev.off()
