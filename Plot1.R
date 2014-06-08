#Reading in data from unzipped file using sqldf
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

# Replacing "?" with NAs
data[data=="?"] <- NA

# Convert date and time to POSITXct date/time format - one column out of two using strptime function
dt <- cbind(data.frame(strptime(paste(data[,1], data[,2]), "%d/%m/%Y %H:%M:%S")), data[3:9])
names(dt)[1] = "Date_and_time"

#Building plot 1
png(file = "plot1.png") 
with(dt, hist(Global_active_power, col = "red", xlab = "Global active power (kilowatts)", main = "Global Active Power"))
dev.off()
