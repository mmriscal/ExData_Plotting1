######  PLOT4.R  ######

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


# PLOT 4 GRAPHICS INDICATING: GLOBAL ACTIVE POWER, VOLTAGE, ENERGY SUB METERING AND GLOBAL REACTIVE POWER vs TIME

png(file="Project1/Plot4.png",width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(4, 4, 4, 2), oma = c(1, 1, 2, 1))

with(consumption, {
        plot(time, Global_active_power, type="l", xlab = "", ylab = "Global Active Power" )
        plot(time, Voltage, type="l", xlab = "", ylab = "Voltage" )
        plot(time, consumption$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
lines(time, consumption$Sub_metering_1, type="l", col="black")
lines(time, consumption$Sub_metering_2, type="l", col="red")
lines(time, consumption$Sub_metering_3, type="l", col="blue" )
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7)
        plot(time, Global_reactive_power, type="l", xlab = "", ylab = "Global reactive Power")
        
})


dev.off()
