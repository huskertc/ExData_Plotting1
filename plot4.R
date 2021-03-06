# plot4.R
#
# load libraries
library(sqldf)
library(lubridate)
#
# Download and unzip file if not already in working dir
if(file.exists("household_power_consumption.txt")==FALSE)
	{
	data_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	setInternet2(use=TRUE)
	download.file(data_url,"data_file.zip",method="internal")
	unzip("data_file.zip")
	}
#
# load data if not already done
if(exists("mydata")==FALSE)
	{
	myfile = "household_power_consumption.txt"
	mydata_in <- read.table(myfile,header=TRUE,sep=";",stringsAsFactors=FALSE)
	mydata <- sqldf("select * from mydata_in where Date in ('1/2/2007','2/2/2007')")
	closeAllConnections()
	mycol=c(3,4,5,6,7,8,9)
	mydata[,mycol] = apply(mydata[,mycol], 2, function(x) as.numeric(x))	
 	mydata$date_time = dmy_hms(paste(mydata$Date,mydata$Time))
	}
#
# Create plot4.png, four-panel
png(file = "plot4.png", width=480, height=480)
par(mfrow = c(2,2))
# Upper Left Plot
plot(mydata$date_time, mydata$Global_active_power,type="l",xlab="",ylab="Global Active Power")
# Upper Right Plot
plot(mydata$date_time, mydata$Voltage,type="l",xlab="datetime",ylab="Voltage")
# Lower Left Plot
with (mydata, {
	plot(date_time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",col="black")
	points(date_time, Sub_metering_2, type="l", col="red")
	points(date_time, Sub_metering_3, type="l", col="blue")
	legend ("topright", lwd=1, col=c("black","red","blue"), 
		legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	})
# Lower Right Plot
plot(mydata$date_time, mydata$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()

