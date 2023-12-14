DAT <- read.table(file.path(here::here("data/data.txt")),header = TRUE, sep = ",")
DAT$CLO_A1 <- DAT$CLO_A1/10
DAT$CLO_A2 <- DAT$CLO_A2/10
DAT$CLO_A3 <- DAT$CLO_A3/10
DAT$CO2_A1 <- DAT$CO2_A1/10
DAT$CO2_A2 <- DAT$CO2_A2/10
DAT$CO2_A3 <- DAT$CO2_A3/10
DAT$NH3_A1 <- DAT$NH3_A1/10
DAT$NH3_A2 <- DAT$NH3_A2/10
DAT$NH3_A3 <- DAT$NH3_A3/10
DAT$CLO_A1_MAX <- DAT$CLO_A1_MAX/10
DAT$CLO_A2_MAX <- DAT$CLO_A2_MAX/10
DAT$CLO_A3_MAX <- DAT$CLO_A3_MAX/10
DAT$CO2_A1_MAX <- DAT$CO2_A1_MAX/10
DAT$CO2_A2_MAX <- DAT$CO2_A2_MAX/10
DAT$CO2_A3_MAX <- DAT$CO2_A3_MAX/10
DAT$NH3_A1_MAX <- DAT$NH3_A1_MAX/10
DAT$NH3_A2_MAX <- DAT$NH3_A2_MAX/10
DAT$NH3_A3_MAX <- DAT$NH3_A3_MAX/10
DAT$Date <- as.Date(DAT$Date,format="%d/%m/%Y")

#Giai thich: trong file csv minh ky hieu: 05/05/2021 <=> minh hieu la: D/M/Y
#Ep R hieu day la du lieu Date voi dinh dang: D/M/Y
#Tu do R se tra ve gia tri la: 2021-05-05 (Y-M-D)

datasensors <- DAT[ , c(1:11)]
datasensors[rev(order(as.Date(datasensors$Date, format="%d/%m/%Y"))),]
realtimeDAT <- tail(read.table(file.path(here::here("data/output.txt")),header = TRUE, sep = ","),1)

#File control.txt
CONTROL_BOT <- read.table(file.path(here::here("www/control.txt")),header = TRUE, sep = ",")
CONTROL <- tail(CONTROL_BOT,1)

DAT_24 <- tail(DAT,24)
#Ly do: 1 ngay minh thu du lieu 48 lan. Neu lay so dong > so lan doc data se gay ra groups trong truc X

#Xay dung file warnings.txt
if(file.exists(file.path(here::here("www/warning.txt")))){
  file.remove(file.path(here::here("www/warning.txt")))
  file.create(file.path(here::here("www/warning.txt")))
  write.table("sensor",file.path(here::here("www/warning.txt")),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table("value",file.path(here::here("www/warning.txt")),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE )
}else{
  file.create(file.path(here::here("www/warning.txt")))
  write.table("sensor",file.path(here::here("www/warning.txt")),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table("value",file.path(here::here("www/warning.txt")),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE )
}

#So sanh cac sensors: CLO
if(realtimeDAT$CLO_A1 > CONTROL$CLO_A1_MAX){
  write.table("CLO-A1>CLO-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$CLO_A1/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$CLO_A1_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$CLO_A2 > CONTROL$CLO_A1_MAX){
  write.table("CLO-A2>CLO-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$CLO_A2/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$CLO_A2_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$CLO_A3 > CONTROL$CLO_A3_MAX){
  write.table("CLO-A3>CLO-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$CLO_A3/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$CLO_A3_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

#So sanh cac sensors: CO2
if(realtimeDAT$CO2_A1 > CONTROL$CO2_A1_MAX){
  write.table("CO2-A1>CLO-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$CO2_A1/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$CO2_A1_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$CO2_A2 > CONTROL$CO2_A1_MAX){
  write.table("CO2-A2>CO2-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$CO2_A2/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$CO2_A2_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$CO2_A3 > CONTROL$CO2_A3_MAX){
  write.table("CO2-A3>CO2-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$CO2_A3/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$CO2_A3_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

#So sanh cac sensors: NH3
if(realtimeDAT$NH3_A1 > CONTROL$NH3_A1_MAX){
  write.table("NH3-A1>NH3-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$NH3_A1/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$NH3_A1_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$NH3_A2 > CONTROL$NH3_A1_MAX){
  write.table("NH3-A2>NH3-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$NH3_A2/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$NH3_A2_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$NH3_A3 > CONTROL$NH3_A3_MAX){
  write.table("NH3-A3>NH3-MAX",file.path(here::here("www/warning.txt")),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$NH3_A3/10,file.path(here::here("www/warning.txt")),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$NH3_A3_MAX/10,file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

con <- file(file.path(here::here("www/warning.txt"))) 
numline <- length(readLines(con))
if(numline == 1){
  write.table("senors:",file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE)
  write.table("safety",file.path(here::here("www/warning.txt")),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}
messageData <- read.table(file.path(here::here("www/warning.txt")),header = TRUE)