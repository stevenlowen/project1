# as this is used in all four subpanels, we define it as a function here
mkaxis <- function(){
   axis(1, at = (0:2)*minperday, labels = c("Thu", "Fri", "Sat"))
}
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
# make the dat data frame the default to make things simpler later on
attach(dat, warn.conflicts = FALSE)
# now actually make the plot
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
