######################################
###     Assessment 1 - Plot1       ###
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


## Make plot 1:
filename <- "Assessment1/plot1.png"
png(filename)

hist(data$Global_active_power, col="red",
     ylim=c(0,1200), main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()
##################

######################################
###           The end              ###
######################################