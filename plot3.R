#plOT 3
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

# Plot all 3 lines
png(file="plot3.png")
# prepare empty plot
with(SelData,plot(timeVector, Sub_metering_1  ,type="n",ylim=yrange,ylab="Energy sub metering",xlab=""))
# plot 3 lines and add legend
for (icolor in 1:3){
    lines(timeVector, SelData[,6+icolor]  ,type="l",col=lineCol[icolor])
  }
legend("topright",lty=1, col=lineCol,legend=paste0(rep("Sub_metering_",3),1:3))

dev.off()

#restore default plot parameters
suppressWarnings(par(oldpar))
