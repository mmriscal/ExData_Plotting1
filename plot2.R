######  PLOT2.R  ######

# READ THE DATA

# Only necessary to read data from the dates 2007-02-01 and 2007-02-02
file <- "Project1/household_power_consumption.txt"
skip <- grep("\\b0*1/0*2/2007\\b|\\b0*2/0*2/2007\\b", readLines(file))- 1  # -1 because the header
consumption <- read.table(file, sep= ";", 
                          header = FALSE, skip = skip, nrows=length(skip))

# Insert the names of the columns
names(consumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                        "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


# TRANSFORM THE DATE FORMAT and CREATE A TIME VARIABLE TO PLOT

consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")
time <- as.POSIXct(paste(consumption$Date, as.character(consumption$Time)))


# PLOT GLOBAL ACTIVE POWER vs WEEKDAYS

png(file="Project1/Plot2.png",width = 480, height = 480)

plot(time, consumption$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (Kilowatts)" )

dev.off()
