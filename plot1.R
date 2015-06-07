# plot1.R
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
# Create plot1.png, histogram of Global Active Power
# Default size is 480x480 pixels
png(file = "plot1.png")
hist(mydata$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",
	main="Global Active Power", col="red")
dev.off()

