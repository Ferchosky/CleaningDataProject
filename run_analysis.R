## Code for Cleaning Data Project
library("plyr")

## Loading the data into Dataframes

X_test <- read.table("X_test.txt")
X_train <- read.table("X_train.txt")
y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
names(subject_test) <- "Subject_ID"
names(subject_train) <- "Subject_ID"
names(y_test) <- "Activity"
names(y_train) <- "Activity"

## Activities IDs

activities <- read.table("activity_labels.txt")
names(activities) <- c("id","des")
act_vec <- as.vector(activities$des)

# This cycle replaces the code numbers for the activity description

for(i in seq_along(activities$des)){
  aux <- (y_test$Activity == activities$id[i])
  if(sum(aux) > 0){y_test$Activity[aux] <- act_vec[i]}
  aux <- (y_train$Activity == activities$id[i])
  if(sum(aux) > 0){y_train$Activity[aux] <- act_vec[i]}
}

## Setting the variable names of X_test and X_train

features <- read.table("features.txt")
X_names <- as.vector(features$V2)
X_names <- gsub("()","",X_names,fixed=T)  #getting rid of the ()'s
X_names <- gsub("-","_",X_names,fixed=T)  # replacing "-" with "_"
X_names <- gsub("BodyBody","Body",X_names,fixed=T)  # eliminating the duplicated BodyBody
X_names <- gsub("tB","Time_Dom_B",X_names,fixed=T)  # clarifying the time domain description
X_names <- gsub("fB","Freq_Dom_B",X_names,fixed=T)  # clarifying the frequency domain description
X_names <- gsub(",","_w_",X_names,fixed=T)  # substituying the "," with "-w-" (as "with")
X_names <- gsub("(","_",X_names,fixed=T)  # Eliminating the "("'s
X_names <- gsub(")","",X_names,fixed=T) # Eliminating the ")"'s
X_names <- gsub("angle","Angle",X_names,fixed=T) # Uppercasing the angle measure
names(X_test) <- X_names
names(X_train) <- X_names

# I will not include the meanFreq measure into the data, since is not the mean of a measure

mean_pos <- grep("mean()",as.vector(features$V2),fixed=TRUE)
std_pos <- grep("std()",as.vector(features$V2),fixed=TRUE)
angle_pos <- grep("angle",as.vector(features$V2),fixed=TRUE)
X_test2 <- X_test[,sort(c(mean_pos,std_pos,angle_pos))]
X_train2 <- X_train[,sort(c(mean_pos,std_pos,angle_pos))]
bigDataset <- rbind(cbind(subject_test,y_test,X_test2),cbind(subject_train,y_train,X_train2)) # merging the data with the relevant information and required descriptions and stuff

## Now we can build a tidy data set from the bigDataset. Its name will be tidyDataset

tidyDataset <- aggregate(x = bigDataset[,3:ncol(bigDataset)],by=list(bigDataset$Activity,bigDataset$Subject_ID),FUN="mean",simplify=FALSE)
aux <- paste("Average",names(bigDataset[3:ncol(bigDataset)]),sep="_")
names(tidyDataset) <- c("Activity","Subject_ID",aux)
write.table(as.matrix(tidyDataset[order(tidyDataset$Activity,tidyDataset$Subject_ID),]),file = "tidyDataset.txt",sep = " ",row.names = FALSE,col.names = TRUE)

## In order to load this data set you should use the following R expression:
# read.table("tidyDataset.txt",header = T,sep = " ")
