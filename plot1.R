## PLOT 1
# save default plot parameters
oldpar<-par(no.readonly = FALSE)

#read file
if(!(require(data.table))){install.packages(data.table)}
fileName<-"household_power_consumption.txt"
AllData<-fread(fileName, header = TRUE, na.strings="?",stringsAsFactors=FALSE)
AllData<-as.data.frame(AllData)
SelData <- AllData[AllData$Date =='1/2/2007'| AllData$Date == '2/2/2007', ]
rm(AllData)   # free up memory

# Plot histogram
png(file="plot1.png")
hist(SelData[,3],col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()

#restore default plot parameters
suppressWarnings(par(oldpar))