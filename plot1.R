#Kimberly Grommes
#Exploratory Data Analysis - Project 1"
#Plot1.R"

#set working directory for file reading and writing
setwd("~/Data Scientist Certificate/ExploratoryDataAnalysis/ExData_Plotting1")

#construct filtered file so that we're not always having to read all data
filtered_file_name <- "filtered_hpc.txt"

#Only download, extract and filter data once
if (!file.exists(filtered_file_name)) {
    
    #get remote file & unzip it
    zipped_file_name <- "household_power_consumption.zip"
    remote_url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(remote_url, destfile = zipped_file_name, method="auto")
    unzip(zipped_file_name)
    
    file_name <- "household_power_consumption.txt"
    
    #read unfiltered file and create filtered file
    skip_number <- grep("1/2/2007", readLines(file_name))[1] - 1
    col_headers = c("Date", "Time", "Global_active_power",
                    "Global_reactive_power", "Voltage", "Global_intensity",  
                    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    df <- read.table(file_name, header = FALSE, sep = ";", comment.char = "", 
                     skip = skip_number, nrows = 2880, col.names = col_headers) 
    write.table(df, shortened_file_name, sep=";")
}

#read in filtered data file
filtered_data <- read.table(shortened_file_name, header = TRUE, 
                            sep = ";", comment.char = "")

#open png file device so future plots are written here
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

#write plot
hist(filtered_data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "red", breaks = 12)

#always close the device
dev.off()