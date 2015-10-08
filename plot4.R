#plot 4
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

# Determin Range and colors
yrange<-with(SelData,range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
lineCol<-c("black","red","blue")

# Plot all 4 graphs
png(file="plot4.png")
par(mfrow=c(2,2),mar=c(5.1,4.1,4.1,2.1),oma=c(0,0,0,0))
# 1st plot
plot(timeVector,SelData[,3],type="l",xlab="",ylab="Global Active Power",main="")
# 2nd plot
plot(timeVector,SelData$Voltage,type="l",xlab="datetime",ylab="Voltage",main="")
# 3rd plot
#prepare empty plot
with(SelData,plot(timeVector, Sub_metering_1  ,type="n",ylim=yrange,ylab="Energy sub metering",xlab=""))
# plot 3 lines and add legend
for (icolor in 1:3){
  lines(timeVector, SelData[,6+icolor]  ,type="l",col=lineCol[icolor])
}
legend("topright",lty=1, col=lineCol,legend=paste0(rep("sub_metering_",3),1:3),bty = "n")
# 4th plot
plot(timeVector,SelData$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",main="")

dev.off()

#restore default plot parameters
suppressWarnings(par(oldpar))