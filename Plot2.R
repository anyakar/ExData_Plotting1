#Reading in data from unzipped file
data = read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings ="?", stringsAsFactors = FALSE)

#Subsetting to 2/1/2007 and 2/2/2007 using a logical index (note, that the format is d/m/Y)
index <- data[,1] == "1/2/2007" | data[,1] == "2/2/2007"
data2 <- data[index,] #subsetting by index

#Convertting date and time to POSITXct date/time format - one column out of two using strptime function
dt <- cbind(data.frame(strptime(paste(data2[,1], data2[,2]), "%d/%m/%Y %H:%M:%S")), data2[3:9])
names(dt)[1] = "Date_and_time"

#Plot 2 
png(file = "plot2.png") 
with(dt, plot(Date_and_time, Global_active_power, type = "n", ylab = "Global active power (kilowatts)", xlab=""))
lines(dt$Date_and_time, dt$Global_active_power)
dev.off()