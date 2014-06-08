#Reading in data from unzipped file
data = read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings ="?", stringsAsFactors = FALSE)

#Subsetting to 2/1/2007 and 2/2/2007 using a logical index (note, that the format is d/m/Y)
index <- data[,1] == "1/2/2007" | data[,1] == "2/2/2007"
data2 <- data[index,] #subsetting by index

#Convertting date and time to POSITXct date/time format - one column out of two using strptime function
dt <- cbind(data.frame(strptime(paste(data2[,1], data2[,2]), "%d/%m/%Y %H:%M:%S")), data2[3:9])
names(dt)[1] = "Date_and_time"

#Building plot 1
png(file = "plot1.png") 
with(dt, hist(Global_active_power, col = "red", xlab = "Global active power (kilowatts)", main = "Global Active Power"))
dev.off()
