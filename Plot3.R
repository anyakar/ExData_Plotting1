#Reading in data from unzipped file
data = read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings ="?", stringsAsFactors = FALSE)

#Subsetting to 2/1/2007 and 2/2/2007 using a logical index (note, that the format is d/m/Y)
index <- data[,1] == "1/2/2007" | data[,1] == "2/2/2007"
data2 <- data[index,] #subsetting by index

#Convertting date and time to POSITXct date/time format - one column out of two using strptime function
dt <- cbind(data.frame(strptime(paste(data2[,1], data2[,2]), "%d/%m/%Y %H:%M:%S")), data2[3:9])
names(dt)[1] = "Date_and_time"

#Plot 3
png(file = "plot3.png")
with(dt, plot(Date_and_time, dt$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab =""))
lines(dt$Date_and_time, dt$Sub_metering_3, col = "blue")
lines(dt$Date_and_time, dt$Sub_metering_2, col = "red")
lines(dt$Date_and_time, dt$Sub_metering_1, col = "black")
legend("topright", border = NULL, pch = "————", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

