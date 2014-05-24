setwd("~/UCI HAR Dataset/train")

X_train<- read.table("X_train.txt")
Y_train<-read.table("Y_train.txt")
subject_train<-read.table("subject_train.txt")

setwd("~/UCI HAR Dataset/test")

X_test<- read.table("X_test.txt")
Y_test<-read.table("Y_test.txt")
subject_test<-read.table("subject_test.txt")

setwd("~/UCI HAR Dataset")

variables <- read.table("features.txt")



combined.X<-rbind(X_test, X_train)
combined.Y<-rbind(Y_test, Y_train)
combined.subject<-rbind(subject_test, subject_train)
combined.sets<-cbind(combined.X, combined.subject, combined.Y)

thenames <- variables[,2]
names(combined.sets) <- thenames

variables.mean <- grep("mean", variables[,2], ignore.case = TRUE)
variables.Mean <- variables[variables.mean,]
variables.identifiers <- as.character(variables.Mean[,2])

combined.mean<- subset(combined.sets, select=variables.identifiers)

variables.std <- grep("std", variables[,2], ignore.case = TRUE)
variables.Std <- variables[variables.std,]
variables.identifiers.std <- as.character(variables.Std[,2])

combined.std<- subset(combined.sets, select=variables.identifiers.std)

MergedData<- cbind(combined.mean, combined.std, combined.subject, combined.Y)
colnames(MergedData)[87] <- "Subject"
colnames(MergedData)[88] <- "Activity"

MergedData$Activity <- as.character(MergedData$Activity)
MergedData$Activity[MergedData$Activity == "1"] <- "Walking"
MergedData$Activity[MergedData$Activity == "2"] <- "Walking Upstairs"
MergedData$Activity[MergedData$Activity == "3"] <- "Walking Downstairs"
MergedData$Activity[MergedData$Activity == "4"] <- "Sitting"
MergedData$Activity[MergedData$Activity == "5"] <- "Standing"
MergedData$Activity[MergedData$Activity == "6"] <- "Laying"

tidy<-melt(MergedData, id=c("Subject", "Activity"))

tidyData<-dcast(tidy, Subject + Activity ~ variable, fun.aggregate=mean)