## PLOT 2
# save default plot parameters
oldpar<-par(no.readonly = FALSE)

#read file
if(!(require(data.table))){install.packages(data.table)}
fileName<-"household_power_consumption.txt"
AllData<-fread(fileName, header = TRUE, na.strings="?",stringsAsFactors=FALSE)
AllData<-as.data.frame(AllData)
SelData <- AllData[AllData$Date =='1/2/2007'| AllData$Date == '2/2/2007', ]
rm(AllData)   # free up memory

# Fix time data
time<-paste(SelData[,1],SelData[,2],sep=" ")
timeVector<-strptime(time,"%d/%m/%Y %H:%M:%S")

# Plot Graph
png(file="plot2.png")
plot(timeVector,SelData[,3],type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

#restore default plot parameters
suppressWarnings(par(oldpar))