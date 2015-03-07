######################################
###     Assessment 1 - Plot4       ###
###     by: Mitja Pišlar           ###
###     Exploratora data analysis  ###
######################################


##################
#### Arranging the working directory:
##################
setwd("D:/CoursEra/SpecializationInDataScience/ExploratoryDataAnalysis/WorkingDirectory")
##################



##################
####  Uploading the data into R
##################
## In order to see how the data looks, only 10 rows are loaded:
file <- "Assessment1/household_power_consumption.txt"
data <- read.table(file, header=T, nrows=10, sep=";", na.strings = "?")
## save the class of the columns:
clas <- sapply(data,class)
rm(data) # removing the dataset.

## Load only the first column to determin the rows that 
##      contain the dates "1/2/2007" and "2/2/2007":
a <- read.table(file, header=T,  sep=";", na.strings = "?",
                colClasses = c(rep("factor",1), rep("NULL", 8)))

# Which rows contain specified days:
ro.num <- which((a[,1]) %in% c("1/2/2007","2/2/2007"))

skip <- min(ro.num)     # no substraction of one row, because the header must be skiped too.
nrows <- length(ro.num)

## load final dataset:
data <- read.table(file, header=F,  sep=";", na.strings = "?",
                   colClasses=clas, col.names=names(clas),
                   skip=skip, nrows=nrows)
##################



##################
#### Exploratory Plotting
##################

# Specify the date data type:
# tail(paste(data$Date,data$Time,sep=" "))
data$Date_Time <- strptime(paste(data$Date, data$Time),
                            "%d/%m/%Y %H:%M:%S")

## Setting my system to English names of weekdays:
Sys.setlocale("LC_TIME","English")


## Make plot 4:
filename <- "Assessment1/plot4.png"
png(filename)

par(mfrow=c(2,2))
with(data, plot(Date_Time, Global_active_power, type="l",
                ylab="Global Active Power (kilowatts)", xlab=""))
with(data, plot(Date_Time, Voltage, type="l",
                ylab="Voltage", xlab="datetime"))
with(data, plot(Date_Time, Sub_metering_1, type="l",
                ylab="Energy sub metering", xlab=""))
with(data, lines(Date_Time, Sub_metering_2, type="l", col="red"))
with(data, lines(Date_Time, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1,col=c("black","red","blue"),
       legend=names(data)[7:9])
with(data, plot(Date_Time, Global_reactive_power, type="l",
                xlab="datetime"))

dev.off()
##################

######################################
###           The end              ###
######################################