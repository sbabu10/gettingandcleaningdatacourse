# ## R program for submission to "getting and cleaning data" course in coursera
# ## as part of peer-assessment assigment
# ## R program reads Samsung files and create output file as required in the assignment

run_analysis<- function() {

# ## check required files are existing
# ## if any one of the file is missing then stop processing with error message
dirname="UCI HAR Dataset"
featuresfn=paste(dirname,"features.txt",sep="/")
activityfn=paste(dirname,"activity_labels.txt",sep="/")
testsubjectsfn=paste(dirname,"test","subject_test.txt",sep="/")  
testxfn=paste(dirname,"test","X_test.txt",sep="/")
testyfn=paste(dirname,"test","y_test.txt",sep="/")
trainsubjectsfn=paste(dirname,"train","subject_train.txt",sep="/") 
trainxfn=paste(dirname,"train","X_train.txt",sep="/")
trainyfn=paste(dirname,"train","y_train.txt",sep="/")

for ( fn in c (dirname,featuresfn,activityfn,testsubjectsfn,testxfn,testyfn,trainsubjectsfn,trainxfn,trainyfn)) {
  if (!file.exists(fn)) {
     stop(sprintf("reqired file (%s) missing.... stopping..........",fn))
  }
}

# ## check for output file and stop if it existing
outfn="tidydata_submission.txt"   ## in the current directory

if (file.exists(outfn)) {
   stop(sprintf("file (%s) already existing... hence stopping.............",outfn))
}

# ## load features into data.frame
features<-read.table(featuresfn)

# ## load activities into data.frame
activities<-read.table(activityfn)

# ## load test files (subject, X and Y) into respective data.frame
testsubjects<-read.table(testsubjectsfn)
testx<-read.table(testxfn)
testy<-read.table(testyfn)

# ## load train files (subject, X and Y) into respective data.frame
trainsubjects<-read.table(trainsubjectsfn)
trainx<-read.table(trainxfn)
trainy<-read.table(trainyfn)

# ## assign names to columns in respective data.frames
names(testsubjects)<-c("subjectid")
names(trainsubjects)<-c("subjectid")
names(testy)<-c("activityid")
names(trainy)<-c("activityid")

names(testx)<-features[,2]
names(trainx)<-features[,2]

names(activities)<-c("activityid","activity")

# ## combine columns of test and train data.frames into one single data.frame
testall<-cbind(testsubjects,testy,testx)
trainall<-cbind(trainsubjects,trainy,trainx)


# ## find out list of columns having mean() and std() in the measurement value columns
# ## and prefix subjectid and activityid as they are also required
# ## since column names are same in testall and trainall, use testall to extract required column names
reqdcols<-c("subjectid","activityid",grep("-mean[(][)]|-std[(][)]",names(testall),value=TRUE))

# ## create a data.frame with combined rows of test and train data.frames but with only required columns
meanandstdall<-rbind(trainall,testall)[,reqdcols]

# ## create a data.frame of mean values by grouping subjectid and activityid
meanofgroupby<-aggregate(meanandstdall[,3:ncol(meanandstdall)],meanandstdall[,1:2],FUN=mean)

# ## merge meanofgroupby with activities to get activity name instead of activityid 
# ## select only required columns from the merged data (leaving activityid column)
tidydata<-merge(activities,meanofgroupby,by.x="activityid",by.y="activityid")[,c(3,2,4:69)]

# ## create an output txt file from the final data.frame as required for submission
write.table(tidydata,outfn,quote=FALSE)
print(sprintf("processing completed........output file (%s) created in the current folder",outfn))

}
