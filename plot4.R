mkaxis <- function(){
   axis(1, at = (0:2)*minperday, labels = c("Thu", "Fri", "Sat"))
}

dat <- read.table(pipe("grep '^[12]/2/2007;' household_power_consumption.txt"), sep = ";", na.strings = "?")
hdr <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1)
names(dat) <- names(hdr)
dat$datetime <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
dat <- dat[order(dat$datetime),]	# in case dates are not sorted
minperday <- 24 * 60
attach(dat, warn.conflicts = FALSE)
png("plot4.png")
par(mfrow=c(2,2))
# first panel
plot(Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n")
mkaxis()
# second panel
plot(Voltage, type = "l", xlab = "datetime", xaxt = "n")
mkaxis()
# third panel
plot(Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(Sub_metering_2, col = "red")
lines(Sub_metering_3, col = "blue")
legend("topright", grep("Sub", names(dat), value = TRUE), lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")
mkaxis()
# fourth panel
plot(Global_reactive_power, type = "l", xlab = "datetime", xaxt = "n")
mkaxis()
# done
dev.off()

