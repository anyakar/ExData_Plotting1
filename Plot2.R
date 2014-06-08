#Reading in data from unzipped file using sqldf
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

# Replacing "?" with NAs
data[data=="?"] <- NA

# Convert date and time to POSITXct date/time format - one column out of two using strptime function
dt <- cbind(data.frame(strptime(paste(data[,1], data[,2]), "%d/%m/%Y %H:%M:%S")), data[3:9])
names(dt)[1] = "Date_and_time"

#Plot 2 
png(file = "plot2.png") 
with(dt, plot(Date_and_time, Global_active_power, type = "n", ylab = "Global active power (kilowatts)", xlab=""))
lines(dt$Date_and_time, dt$Global_active_power)
dev.off()