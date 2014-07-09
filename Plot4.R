#Reading in data from unzipped file using sqldf
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", 
                     sep=";", 
                     header = TRUE, 
                     stringsAsFactors = FALSE, 
                     sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

# Replacing "?" with NAs
data[data=="?"] <- NA

# Convert date and time to POSITXct date/time format - one column out of two using strptime function
dt <- cbind(data.frame(strptime(paste(data[,1], data[,2]), "%d/%m/%Y %H:%M:%S")), data[3:9])
names(dt)[1] = "Date_and_time"

#Plot 4
png(file = "plot4.png")

par(mar = c(2.5,5,1.5,1.5))
par(mfrow = c(2,2))

with(dt, plot(Date_and_time, 
              Global_active_power, 
              type = "n"))
lines(dt$Date_and_time, dt$Global_active_power)

with(dt, plot(Date_and_time, 
              Voltage, 
              type = "n"))
lines(dt$Date_and_time, dt$Voltage)

with(dt, plot(Date_and_time, 
              dt$Sub_metering_1, 
              type = "n", 
              ylab = "Energy sub metering", 
              xlab =""))
lines(dt$Date_and_time, dt$Sub_metering_3, col = "blue")
lines(dt$Date_and_time, dt$Sub_metering_2, col = "red")
lines(dt$Date_and_time, dt$Sub_metering_1, col = "black")
legend("topright", 
       border = NULL, 
       lty=c(1,1),
       lwd=c(1,1), 
       col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(dt, plot(Date_and_time, 
              Global_reactive_power, 
              type = "n"))
lines(dt$Date_and_time, dt$Global_reactive_power)

dev.off()

