# use linux command "grep" to select only those two days
dat <- read.table(pipe("grep '^[12]/2/2007;' household_power_consumption.txt"), sep = ";", na.strings = "?")
# read in the headers from the top of the file
hdr <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1)
# copy the headers to the data used
names(dat) <- names(hdr)
# now actually make the histogram
png("plot1.png")
hist(dat$Global_active_power, breaks = (0:15)/2, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

